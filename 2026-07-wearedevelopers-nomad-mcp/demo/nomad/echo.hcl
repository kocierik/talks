# Demo HTTP: whoami (HTML) con Host, IP, header X-Forwarded-* dietro Traefik HTTPS.
# Router: tag Consul → `https://man.ovh/echo-demo` (cert condiviso con `man.ovh`).
# Porte host dinamiche → più istanze sullo stesso nodo senza collisioni; Traefik fa LB sul servizio Consul `laptop-echo`.
job "laptop-echo" {
  datacenters = ["dc1"]
  type        = "service"

  group "echo" {
    count = 3

    network {
      port "http" {
        to = 80
      }
    }

    service {
      name         = "laptop-echo"
      port         = "http"
      provider     = "consul"
      address_mode = "host"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.laptop-echo.rule=Host(`echo.man.ovh`)",
        "traefik.http.routers.laptop-echo.entrypoints=websecure",
        "traefik.http.routers.laptop-echo.tls=true",
        "traefik.http.routers.laptop-echo.tls.certresolver=myresolver",
        "traefik.http.routers.laptop-echo.middlewares=laptop-echo-strip@file",
        "traefik.http.routers.laptop-echo.priority=100",
        "traefik.http.services.laptop-echo.loadbalancer.passHostHeader=true",
      ]

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
        image = "traefik/whoami:v1.10.2"
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