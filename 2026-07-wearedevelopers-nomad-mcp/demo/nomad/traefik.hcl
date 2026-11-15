# Un solo Traefik sull’edge pubblico: acme.json e :443/80 solo su serverman (un job system avrebbe duplicato su ogni client).
# memory_max: vedi immich.nomad.hcl (Memory Oversubscription). cgroup max = RAM fisica serverman (~7788 MiB).
job "traefik" {
  datacenters = ["dc1"]
  type        = "service"

  group "traefik" {
    count = 1


    # Doppio vincolo: se due nodi sbaglia nome uguale, questo evita comunque Traefik dove meta.pool=laptop.
    constraint {
      operator  = "!="
      attribute = "${meta.pool}"
      value     = "laptop"
    }

    # Default health_check=checks → deploy resta bloccato se il check Consul (/ping su :8080) non è subito passing.
    update {
      health_check      = "task_states"
      max_parallel      = 1
      min_healthy_time  = "20s"
      healthy_deadline  = "10m"
      progress_deadline = "15m"
      auto_revert       = false
    }

    restart {
      attempts = 15
      interval = "24h"
      delay    = "30s"
      mode     = "delay"
    }

    # Host network: service group con porta numerica 443 a volte non compare nel catalog Consul.
    # Porte etichettate statiche + bloc service sul task è il pattern nominale per Consul + docker host.
    network {
      mode = "host"
      port "https" {
        static = 443
      }
      port "api" {
        static = 8080
      }
    }

    task "traefik" {
      driver = "docker"

      # Traefik fa shutdown “Waiting 10s…” per entrypoint: default Nomad (~5s) manda SIGKILL troppo presto → “crash”.
      kill_timeout = "45s"

      service {
        name     = "traefik"
        port     = "https"
        provider = "consul"
        address_mode = "host"

        # HTTP /ping può fallire (ordine avvio, router, redirect): TCP :8080 = solo listen, meno flap → meno deregister.
        check {
          type     = "tcp"
          port     = "api"
          interval = "20s"
          timeout  = "5s"

          failures_before_critical = 8
          success_before_passing   = 2

          on_update                = "ignore"
        }
      }

      config {
        # :latest cambia comportamento/versione tra un pull e l'altro; v3.x coerente con i tag Consul.
        image        = "traefik:v3.6"
        network_mode = "host"

        volumes = [
          "local/traefik.yml:/etc/traefik/traefik.yml",
          "local/dynamic-transport.yml:/etc/traefik/dynamic-transport.yml",
          "/opt/nomad/traefik/acme.json:/letsencrypt/acme.json",
        ]
      }

      template {
        data = <<-EOF
          # https://doc.traefik.io/traefik/contributing/data-collection/
          global:
            checkNewVersion: true
            sendAnonymousUsage: true

          api:
            insecure: true
            dashboard: true

          ping:
            entryPoint: "traefik"

          entryPoints:
            web:
              address: ":80"
              http:
                redirections:
                  entryPoint:
                    to: websecure
                    scheme: https
                    permanent: true
            websecure:
              address: ":443"
              # Immich / grossi upload: timeout bassi sulla lettura body (lato browser→Traefik) → Multer vede connessione chiusa → "Request aborted".
              # 0s = nessun limite per read/write/idle su questo entrypoint (vedi GH Immich #8872, issue Traefik upload).
              transport:
                respondingTimeouts:
                  readTimeout: 0s
                  writeTimeout: 0s
                  idleTimeout: 0s
            traefik:
              address: ":8080"

          providers:
            # serversTransport deve stare in config “dinamica” per poter essere referenziato come …@file dai tag Consul.
            file:
              filename: "/etc/traefik/dynamic-transport.yml"
              watch: true
            consulCatalog:
              endpoint:
                address: "http://127.0.0.1:8500"
                datacenter: "dc1"
              exposedByDefault: false
              # Con false, in log DEBUG compare "Filtering disabled item" per ogni servizio senza traefik.enable=true
              # (normale per consul, nomad, nomad-client e per il nostro ingress "traefik" registrato da Nomad: evita router che puntano al proxy stesso).
              prefix: "traefik"
              # Default strictChecks = passing,warning → istanze critical NON entrano in config (sembra “non rilevato”).
              # Incluso critical finché i check Nomad/Consul sui client restano rossi; togli "critical" quando i check sono passing.
              strictChecks: "passing,warning,critical"
              requireConsistent: false
              # watch lunghi blocchi su Consul ↔ risorse/panic sporadici; polling via refreshInterval è più stabile.
              watch: false
              refreshInterval: 15s
              connectAware: false

          certificatesResolvers:
            myresolver:
              acme:
                email: "kocierik@gmail.com"
                storage: "/letsencrypt/acme.json"
                tlsChallenge: {}

          log:
            level: "INFO"
        EOF

        destination = "local/traefik.yml"
      }

      template {
        data = <<-EOF
          http:
            # laptop-echo: router e backend da tag Consul sul job `laptop-echo` (LB su più alloc).
            # Middleware strip usato dal router Consul → whoami vede path `/`.
            middlewares:
              laptop-echo-strip:
                stripPrefix:
                  prefixes:
                    - /echo-demo
              pairdrop-proxy:
                headers:
                  customRequestHeaders:
                    X-Forwarded-Proto: "https"
                    X-Forwarded-Port: "443"

            serversTransports:
              immich-http:
                disableHTTP2: true
                forwardingTimeouts:
                  dialTimeout: 30s
                  responseHeaderTimeout: 0s
                  # 0s = nessun limite: upload lunghi / pause tra chunk non chiudono la connessione verso backend.
                  idleConnTimeout: 0s
                  readIdleTimeout: 0s
                  pingTimeout: 0s
              pairdrop-http1:
                disableHTTP2: true
                forwardingTimeouts:
                  dialTimeout: 30s
                  responseHeaderTimeout: 120s
                  idleConnTimeout: 300s
                  readIdleTimeout: 0s
                  pingTimeout: 0s

          # Client TLS: solo HTTP/1.1 in ALPN (niente h2 verso Traefik). Mitiga upload che si interrompono con
          # Nest/raw-body quando il browser negozia h2 davanti al proxy mentre il backend va in HTTP/1.1.
          tls:
            options:
              immich-http11:
                alpnProtocols:
                  - http/1.1
        EOF

        destination = "local/dynamic-transport.yml"
      }

      # Troppo poca RAM → OOM quando il resto dell'host è sotto stress: Traefik parte ma i backend
      # risultano assenti nei router → 404 su tutti gli host nel catalog.
      resources {
        cpu        = 400
        memory     = 1024
        memory_max = 7788
      }
    }
  }
}