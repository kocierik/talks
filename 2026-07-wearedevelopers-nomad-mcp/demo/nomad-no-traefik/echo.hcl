# Demo HTTP: whoami su tutti i nodi (system job).
# Porta dinamica su Tailscale. Scopri le porte via Consul:
#   dig +short laptop-echo.service.consul SRV
job "laptop-echo" {
  datacenters = ["dc1"]
  type        = "system"

  group "echo" {
    network {
      port "http" {
        to           = 80
        host_network = "tailscale"
      }
    }

    service {
      name         = "laptop-echo"
      port         = "http"
      provider     = "consul"
      address_mode = "host"

      check {
        type                     = "http"
        path                     = "/"
        interval                 = "15s"
        timeout                  = "5s"
        failures_before_critical = 6
      }
    }

    task "whoami" {
      driver = "docker"

      config {
        image = "containous/whoami"
        ports = ["http"]
      }

      resources {
        cpu        = 50
        memory     = 48
        memory_max = 128
      }
    }
  }
}