# Un allocation per client: metriche Prometheus (nodename, RAM, disco, ecc.).
# Richiede che dal nodo Prometheus (serverman) la porta 9100 su ogni client sia raggiungibile.
#
# `host_network = "tailscale"` sulla porta: Consul registra l’IP nella tailnet (100.x), così Prometheus
# (solo su Tailscale verso il laptop) non prova l’IP LAN del PC — tipico motivo per cui “vedo un solo nodo”.
# Sul client Nomad dev’essere definito `host_network "tailscale" { cidr = "100.64.0.0/10" }` (server + laptop).
#
# IMPORTANTE — `provider = "consul"` con Consul solo sul server:
# senza **Consul agent sul laptop**, Nomad può registrare i servizi del client remoto sul nodo Consul “serverman”
# con indirizzi incoerenti → check HTTP verso 192.168.x:9100 dal server falliscono → **deployment bloccato** (Healthy: 0).
# Soluzione: avvia Consul client sul PC (`nomad/consul-client-local-pc.hcl` + join) e nel nomad del laptop usa
# `consul { address = "http://127.0.0.1:8500" }` (agent locale) invece dell’URL del server.
#
# NO privileged: molti client Nomad hanno Docker allow_privileged=false; usiamo i bind come l’immagine ufficiale.
job "node-exporter" {
  datacenters = ["dc1"]
  type        = "system"

  group "metrics" {

    network {
      mode = "host"
      port "metrics" {
        static       = 9100
        host_network = "tailscale"
      }
    }

    task "node-exporter" {
      driver = "docker"

      config {
        image        = "quay.io/prometheus/node-exporter:v1.8.2"
        network_mode = "host"
        pid_mode     = "host"

        volumes = [
          "/proc:/host/proc:ro",
          "/sys:/host/sys:ro",
          "/:/host/rootfs:ro",
        ]

        args = [
          "--path.procfs=/host/proc",
          "--path.sysfs=/host/sys",
          "--path.rootfs=/host/rootfs",
          "--collector.filesystem.mount-points-exclude=^/(sys|proc|dev|host|etc|run)($$|/)",
        ]
      }

      service {
        name         = "node-exporter"
        port         = "metrics"
        provider     = "consul"
        address_mode = "host"

        check {
          type     = "http"
          path     = "/metrics"
          interval = "20s"
          timeout  = "5s"

          failures_before_critical = 5
          success_before_passing   = 1

          on_update = "ignore"
        }
      }

      resources {
        cpu        = 50
        memory     = 64
        memory_max = 192
      }
    }
  }
}