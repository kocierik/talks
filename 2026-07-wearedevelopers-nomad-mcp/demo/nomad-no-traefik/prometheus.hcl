# Prometheus su serverman — host network (:9090). Discovery via Consul delle istanze "node-exporter".
# Prima avvia il job node-exporter su tutti i client; poi questo job.
#
# Sul laptop apri TCP 9100 verso questo server (Tailscale/firewall) così Prometheus possa scrape-are quel nodo (pull).
#
# Volume host: Prometheus 3 nell'immagine usa utente non-root → /opt/nomad/prometheus/data deve essere scrivibile da quel UID
# oppure (come qui) fai girare il container come root sul nodo dopo aver letto rischi operativi.
job "prometheus" {
  datacenters = ["dc1"]
  type        = "service"

  meta {
    consul_http = "100.71.13.115:8500"
    dc          = "dc1"
  }

  group "prometheus" {
    count = 1



    restart {
      attempts = 5
      interval = "24h"
      delay    = "30s"
      mode     = "delay"
    }

    update {
      health_check      = "task_states"
      max_parallel      = 1
      min_healthy_time  = "15s"
      healthy_deadline  = "15m"
      progress_deadline = "25m"
    }

    network {
      mode = "host"
      port "http" {
        static = 9090
      }
    }

    task "prometheus" {
      driver = "docker"

      # L'immagine ufficiale è non-root; UID default non può scrivere /opt/nomad/prometheus/data senza chown.
      user = "0:0"

      config {
        image        = "prom/prometheus:v3.3.0"
        network_mode = "host"

        args = [
          "--config.file=/etc/prometheus/prometheus.yml",
          "--storage.tsdb.path=/prometheus",
          "--storage.tsdb.retention.time=15d",
          "--web.enable-lifecycle",
          "--web.listen-address=0.0.0.0:9090",
        ]

        volumes = [
          "local/prometheus.yml:/etc/prometheus/prometheus.yml:ro",
          "/opt/nomad/prometheus/data:/prometheus",
        ]
      }

      template {
        data = <<-EOF
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: node-exporter
    consul_sd_configs:
      - server: '{{ env "NOMAD_META_consul_http" }}'
        datacenter: '{{ env "NOMAD_META_dc" }}'
        services:
          - node-exporter
EOF

        destination = "local/prometheus.yml"
        change_mode = "signal"
        change_signal = "SIGHUP"
      }

      service {
        name         = "prometheus"
        port         = "http"
        provider     = "consul"
        address_mode = "host"

        check {
          type     = "http"
          path     = "/-/ready"
          interval = "20s"
          timeout  = "5s"

          failures_before_critical = 4
        }
      }

      resources {
        cpu        = 200
        memory     = 512
        memory_max = 2048
      }
    }
  }
}