# Glance sul laptop (meta.pool=laptop). Consul tag URL literal → Traefik raggiunge Tailscale:8877 sulla macchina cliente.
# host_network=tailscale sul porto: senza client { host_network "tailscale" } su remote-client.hcl la 8877 resta solo sulla LAN (es. eth/wifi), non su Tailscale.
# Verifica catalogo su http://<server>:8500 — sul laptop localhost:8500 non è il Consul del cluster (API va al server in remote-client.hcl).
#
# Check: deve usare il network namespace dell’allocazione (Docker), non solo la porta 8877 sull’host.
# Probe TCP sulla 8080 *del container* (address_mode=driver): la 8877 pubblicata dall’host spesso risultava
# irraggiungibile al runner del check da Consul/Nomad → sempre critical.
#
# Deploy che resta “deploying”: default update.health_check=checks richiede check Consul passing;
# glance-ts/rest spesso critical → uso task_states (solo stato task Nomad running, non Consul) per chiudere il deployment.
job "glance" {
  datacenters = ["dc1"]
  type        = "service"

  group "glance" {
    count = 1

    update {
      health_check      = "task_states"
      max_parallel      = 1
      min_healthy_time  = "10s"
      healthy_deadline  = "15m"
      progress_deadline = "20m"
      auto_revert       = false
    }

    network {
      port "http" {
        static       = 8877
        to           = 8080
        host_network = "tailscale"
      }
    }

    task "glance" {
      driver = "docker"

      # Nei tag Traefik il nome router non può contenere "." (es. glance.edge → errore "field not found, node: edge").
      service {
        name     = "glance"
        port     = "http"
        provider = "consul"

        tags = [
          "traefik.enable=true",
          "traefik.http.routers.glance-edge.rule=Host(`man.ovh`)",
          "traefik.http.routers.glance-edge.entrypoints=websecure",
          "traefik.http.routers.glance-edge.tls=true",
          "traefik.http.routers.glance-edge.tls.certresolver=myresolver",
          "traefik.http.routers.glance-edge.service=glance-ts",
          "traefik.http.services.glance-ts.loadbalancer.server.url=http://100.118.206.109:8877",
        ]

        check {
          type         = "tcp"
          address_mode = "driver"
          port         = 8080
          interval     = "10s"
          timeout      = "5s"

          failures_before_critical = 6
          success_before_passing   = 1

          on_update                = "ignore"
        }
      }

      config {
        image = "glanceapp/glance"
        ports = ["http"]

        volumes = [
          "/opt/nomad/glance/config:/app/config",
          "/etc/timezone:/etc/timezone:ro",
          "/etc/localtime:/etc/localtime:ro",
        ]
      }

      resources {
        cpu        = 100
        memory     = 256
        # Laptop (~7–8 GiB): aggiorna se diversa dalla RAM effettiva del nodo glance.
        memory_max = 7788
      }
    }
  }
}