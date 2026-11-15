# Porte host dedicate: con network_mode=host 5432/6379 spesso sono già usate (OS, altri stack, Docmost…).
# Postgres: usare PGPORT (template), non docker args, così il CMD dell'immagine Immich mantiene VectorChord in shared_preload_libraries.
# IMICH_*: allineare redis/ML e env del server.
#
# Tailscale-only (questo repo): Nomad/Consul server su 100.112.254.123; laptop 100.118.206.109; Traefik+Immich su serverman; Glance su host_network tailscale.
# In Immich → impostazioni server / URL esterno usa il nome che risolvi sulla tailnet (es. https://immich.man.ovh via MagicDNS); evita URL “LAN” se entri solo da TS.
#
# Machine learning:
# · Task ML nel group è disattivo (blocco /* */). Per ML su serverman leva quel blocco e nel template server usa ENABLED=true + URL come sotto (commentato).
# · Oppure job immich-machine-learning-remote con count=1 sul laptop + meta.ml_remote_host (vedi quel file).
#
# Postgres ufficiale: ≥2048 MiB con limiti Docker quando usi questo stack.
# Profilo alleggerito (~3.9 GiB riservati al gruppo + Traefik): ok su ~8 GiB RAM. Se thumbnails/backup vanno spesso OOM Postgres, alza DB (≥2048) o shm modestamente.
# Se la CPU va al 100% e l’UI “muore”: è quasi sempre il worker microservices (thumbnail/video/…). Imposta CPU_CORES
# sotto; in Admin → Jobs abbassa la concorrenza per job. Per separare carico: secondo container con IMMICH_WORKERS_INCLUDE=api
# e uno con EXCLUDE=api (vedi docs.immich.app/administration/jobs-workers).
# check_restart sul ping HTTP: durante carico Nest risponde lento → Consul critical → Nomad riavvia tutto (sembra “crash”). Evitare.
# Se la macchina ha 8 GiB RAM totali, abbassa proporzionalmente prima di redeploy per evitare OOM sistema.
# Volumi host su /opt/nomad/immich/*: se il gruppo schedula su un altro nodo servono gli stessi directory lì.
#
# memory_max: richiede Memory Oversubscription sul cluster (una tantum):
# nomad operator scheduler set-config -memory-oversubscription=true -check-index <modify_index>
#
# memory_max sotto quota (non più RAM intera/nodo): evita burst paralleli che mandano tutto il box in swap/OOM.
job "immich" {
  datacenters = ["dc1"]
  type        = "service"

  group "immich" {
    count = 1

    network {
      mode = "host"
      port "http" {
        static = 2283
      }
    }

    restart {
      attempts = 15
      interval = "24h"
      delay    = "30s"
      mode     = "delay"
    }

    update {
      health_check      = "task_states"
      max_parallel      = 1
      min_healthy_time  = "30s"
      healthy_deadline  = "30m"
      progress_deadline = "45m"
    }

    meta {
      db_username      = "postgres"
      db_password      = "postgres"
      db_database_name = "immich"
      # IP Tailscale del laptop se ML gira col job immich-machine-learning-remote (porta 30013 sul client).
      ml_remote_host = "100.118.206.109"
    }

    task "database" {
      driver = "docker"
      config {
        image        = "ghcr.io/immich-app/postgres:14-vectorchord0.4.3-pgvectors0.2.0"
        network_mode = "host"
        # Non usare args per -p: sostituirebbe il CMD dell'immagine e toglierebbe
        # shared_preload_libraries (VectorChord/vchord) → errore "vchord must be loaded via shared_preload_libraries".
        # La porta è in PGPORT nel template qui sotto.
        volumes = [
          "/opt/nomad/immich/pgdata:/var/lib/postgresql/data",
        ]
        # shm enorme conta nel cgroup → su host 8 GiB toglie tanto margine; 512 MiB basta alla maggior parte delle librerie; alza se Postgres lamenta shm.
        shm_size = 536870912  # 512 MiB
      }
      template {
        data = <<-EOF
          PGPORT=55432
          POSTGRES_PASSWORD={{ env "NOMAD_META_db_password" }}
          POSTGRES_USER={{ env "NOMAD_META_db_username" }}
          POSTGRES_DB={{ env "NOMAD_META_db_database_name" }}
          POSTGRES_INITDB_ARGS=--data-checksums
        EOF
        destination = "local/db.env"
        env         = true
      }
      resources {
        cpu    = 1200
        # Minimo ragionevole Immich vector image; più basso aumenta disk temp / eviction.
        memory     = 2048
        memory_max = 3584
      }
      lifecycle {
        hook    = "prestart"
        sidecar = true
      }
    }

    task "redis" {
      driver = "docker"
      config {
        image        = "docker.io/valkey/valkey:8"
        network_mode = "host"
        # Evita conflitto con redis/valkey su :6379
        args = ["valkey-server", "--port", "56379"]
      }
      resources {
        cpu        = 650
        memory     = 656
        memory_max = 884
      }
      lifecycle {
        hook    = "prestart"
        sidecar = true
      }
    }

    /* ML disattivato lato server (IMMICH_MACHINE_LEARNING_ENABLED=false): ~2.8 GiB risparmiati su host 8 GiB.
       Per riattivare: decommenta il task e imposta IMMICH_MACHINE_LEARNING_ENABLED=true nel template server. */
    /*
    task "machine-learning" {
      driver = "docker"
      config {
        image        = "ghcr.io/immich-app/immich-machine-learning:release"
        network_mode = "host"
        volumes = [
          "/opt/nomad/immich/model-cache:/cache",
        ]
      }
      env {
        IMMICH_PORT = "30013"
      }
      resources {
        cpu        = 2000
        memory     = 2048
        memory_max = 3584
      }
      lifecycle {
        hook    = "prestart"
        sidecar = true
      }
    }
    */

    task "server" {
      driver = "docker"

      kill_timeout = "90s"

      service {
        name         = "immich"
        port         = "http"
        provider     = "consul"
        address_mode = "host"
        tags = [
          "traefik.enable=true",
          "traefik.http.routers.immich.rule=Host(`immich.man.ovh`)",
          "traefik.http.routers.immich.entrypoints=websecure",
          "traefik.http.routers.immich.tls=true",
          "traefik.http.routers.immich.tls.certresolver=myresolver",
          "traefik.http.routers.immich.tls.options=immich-http11@file",
          "traefik.http.services.immich.loadbalancer.serversTransport=immich-http@file",
        ]
        check {
          type     = "http"
          path     = "/api/server/ping"
          interval = "30s"
          timeout  = "15s"
          failures_before_critical = 10
          success_before_passing   = 2
          on_update                = "ignore"
        }
      }

      config {
        image        = "ghcr.io/immich-app/immich-server:release"
        network_mode = "host"
        volumes = [
          "/opt/nomad/immich/upload:/data",
          "/etc/localtime:/etc/localtime:ro",
        ]
      }
      env {
        # Per risparmio massimo RAM/CPU: IMMICH_WORKERS_INCLUDE=api (solo API, niente job in bg nello stesso container; vedi docs worker split).
        # WASI/ExperimentalWarning da dipendenze Nest → rumore in log; non è l’errore upload.
        NODE_NO_WARNINGS = "1"
        NODE_OPTIONS     = "--max-old-space-size=1024"
        # Default Immich = tutti i core per FFmpeg/code → su host piccolo satura CPU. Abbassa se serve (1–2).
        CPU_CORES = "1"
        IMMICH_LOG_LEVEL = "warn"
      }
      template {
        data = <<-EOF
          DB_HOSTNAME=127.0.0.1
          DB_PORT=55432
          DB_USERNAME={{ env "NOMAD_META_db_username" }}
          DB_PASSWORD={{ env "NOMAD_META_db_password" }}
          DB_DATABASE_NAME={{ env "NOMAD_META_db_database_name" }}
          REDIS_HOSTNAME=127.0.0.1
          REDIS_PORT=56379
          # Traefik→Immich locale + IP tailnet server (100.112.254.123) + RFC6598 TS (100.64.0.0/10) per X-Forwarded-* coerenti sulla tailnet.
          IMMICH_TRUSTED_PROXIES=127.0.0.1,::1,100.112.254.123,100.64.0.0/10
          # ML spento mentre task/job ML non sono in esecuzione. Per attivare: false → true e decommentare la riga URL.
          IMMICH_MACHINE_LEARNING_ENABLED=false
          #IMMICH_MACHINE_LEARNING_URL=http://{{ env "NOMAD_META_ML_REMOTE_HOST" }}:30013
        EOF
        destination = "local/env"
        env         = true
      }
      resources {
        cpu        = 900
        memory     = 1536
        memory_max = 4096
      }
    }
  }
}