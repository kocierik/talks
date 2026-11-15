# Grafana sul pool laptop — HTTPS pubblico via Traefik; Prometheus in `proxy` dal backend verso `job.meta.prometheus_url`.
#
# Esportazione: DNS `grafana.man.ovh` → IP pubblico dove ascolta Traefik (come gli altri servizi). Poi:
#   nomad job run -var="grafana_admin_password=..." nomad/grafana.nomad.hcl
# (Password: anche `-var-file` con file non committato). Non committare la password.
#
# Se `/opt/nomad/grafana/data` contiene già `grafana.db`, Grafana ignora `GF_SECURITY_ADMIN_*`:
# la password resta quella nel DB — sembra che `-var=grafana_admin_password` non serva a nulla.
# Usa `grafana-cli admin reset-admin-password` nell'alloc, oppure (solo dev) svuota il volume e rifai il primo deploy.
#
# Prima del deploy: conferma che dal laptop `prometheus_url` sia raggiungibile (tailnet :9090 verso serverman).
# Volume host: sul laptop `sudo mkdir -p /opt/nomad/grafana/data && sudo chown -R 472:472 /opt/nomad/grafana/data`.
# Plugins in /tmp nel container così Grafana non deve creare sottocartelle su un volume montato solo root (stderr: Permission denied mkdir plugins).
#
# Dashboard demo: JSON embedded sotto (delimitatori <% %> così {{instance}} Grafana non passa dal template engine Nomad).
# Copia editabile anche in `nomad/grafana/demo-infra.json` — tieni i due allineati se modifichi a mano.

variable "grafana_admin_password" {
  type        = string
  description = "Password utente admin al primo avvio (volume dati vuoto). Con DB già presente Grafana non la rilegge — usa reset-admin-password."
}

job "grafana" {
  datacenters = ["dc1"]
  type        = "service"

  meta {
    prometheus_url = "http://100.112.254.123:9090"
  }

  group "ui" {
    count = 1
    restart {
      attempts = 5
      interval = "24h"
      delay    = "30s"
      mode     = "delay"
    }

    update {
      health_check       = "task_states"
      max_parallel       = 1
      min_healthy_time   = "10s"
      healthy_deadline   = "15m"
      progress_deadline  = "25m"
    }

    network {
      port "http" {
        static       = 8788
        to           = 3000
        host_network = "tailscale"
      }
    }

    task "grafana" {
      driver = "docker"

      template {
        left_delimiter  = "<%"
        right_delimiter = "%>"
        destination     = "local/dashboards-static/demo-infra.json"
        change_mode       = "restart"
        data              = <<-DASH
{"uid":"demo-infra-nomad","title":"Demo \u00b7 Infrastructure (Nomad / node-exporter)","description":"Homelab: two nodes, CPU, RAM, load, root disk, network. Prometheus + node-exporter. Demo folder.","tags":["demo","nomad","node-exporter"],"timezone":"browser","schemaVersion":39,"version":5,"refresh":"10s","time":{"from":"now-1h","to":"now"},"editable":true,"graphTooltip":1,"panels":[{"type":"row","title":"CPU & memory","gridPos":{"h":1,"w":24,"x":0,"y":0},"id":101,"collapsed":false},{"id":3,"type":"timeseries","title":"CPU % non-idle (by instance)","gridPos":{"h":8,"w":12,"x":0,"y":1},"datasource":{"type":"prometheus","uid":"prom_ds"},"targets":[{"refId":"A","expr":"100 * (1 - avg by (instance) (rate(node_cpu_seconds_total{mode=\"idle\",job=\"node-exporter\"}[5m])))","legendFormat":"{{instance}}","datasource":{"type":"prometheus","uid":"prom_ds"}}],"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"drawStyle":"line","lineInterpolation":"smooth","fillOpacity":12,"showPoints":"never"},"unit":"percent","min":0,"max":100},"overrides":[]},"options":{"legend":{"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"multi","sort":"desc"}}},{"id":4,"type":"timeseries","title":"Memory available %","gridPos":{"h":8,"w":12,"x":12,"y":1},"datasource":{"type":"prometheus","uid":"prom_ds"},"targets":[{"refId":"A","expr":"100 * (node_memory_MemAvailable_bytes{job=\"node-exporter\"} / node_memory_MemTotal_bytes{job=\"node-exporter\"})","legendFormat":"{{instance}}","datasource":{"type":"prometheus","uid":"prom_ds"}}],"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"drawStyle":"line","lineInterpolation":"smooth","fillOpacity":10,"showPoints":"never"},"unit":"percent","min":0,"max":100},"overrides":[]},"options":{"legend":{"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"multi","sort":"desc"}}},{"type":"row","title":"Load, disk, network","gridPos":{"h":1,"w":24,"x":0,"y":9},"id":102,"collapsed":false},{"id":5,"type":"timeseries","title":"Load average (1m / 5m)","gridPos":{"h":7,"w":12,"x":0,"y":10},"datasource":{"type":"prometheus","uid":"prom_ds"},"targets":[{"refId":"A","expr":"node_load1{job=\"node-exporter\"}","legendFormat":"{{instance}} load1","datasource":{"type":"prometheus","uid":"prom_ds"}},{"refId":"B","expr":"node_load5{job=\"node-exporter\"}","legendFormat":"{{instance}} load5","datasource":{"type":"prometheus","uid":"prom_ds"}}],"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"drawStyle":"line","lineInterpolation":"smooth","fillOpacity":0,"showPoints":"never"},"unit":"short"},"overrides":[]},"options":{"legend":{"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"multi","sort":"desc"}}},{"id":6,"type":"timeseries","title":"Disk / \u2014 used %","description":"100 minus free space on root (ext4/xfs, \u2026)","gridPos":{"h":7,"w":12,"x":12,"y":10},"datasource":{"type":"prometheus","uid":"prom_ds"},"targets":[{"refId":"A","expr":"100 * (1 - node_filesystem_avail_bytes{job=\"node-exporter\",mountpoint=\"/\",fstype!~\"tmpfs|squashfs|fuse.*\"} / node_filesystem_size_bytes{job=\"node-exporter\",mountpoint=\"/\",fstype!~\"tmpfs|squashfs|fuse.*\"})","legendFormat":"{{instance}}","datasource":{"type":"prometheus","uid":"prom_ds"}}],"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"drawStyle":"line","lineInterpolation":"smooth","fillOpacity":15,"showPoints":"never"},"unit":"percent","min":0,"max":100},"overrides":[]},"options":{"legend":{"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"multi","sort":"desc"}}},{"id":7,"type":"timeseries","title":"Network \u2014 receive (bit/s)","gridPos":{"h":7,"w":12,"x":0,"y":17},"datasource":{"type":"prometheus","uid":"prom_ds"},"targets":[{"refId":"A","expr":"sum by (instance) (rate(node_network_receive_bytes_total{job=\"node-exporter\",device!~\"lo|veth.*|br-.*|docker0|virbr.*\"}[5m])) * 8","legendFormat":"{{instance}}","datasource":{"type":"prometheus","uid":"prom_ds"}}],"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"drawStyle":"line","lineInterpolation":"smooth","fillOpacity":8,"showPoints":"never"},"unit":"bps"},"overrides":[]},"options":{"legend":{"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"multi","sort":"desc"}}},{"id":8,"type":"timeseries","title":"Network \u2014 transmit (bit/s)","gridPos":{"h":7,"w":12,"x":12,"y":17},"datasource":{"type":"prometheus","uid":"prom_ds"},"targets":[{"refId":"A","expr":"sum by (instance) (rate(node_network_transmit_bytes_total{job=\"node-exporter\",device!~\"lo|veth.*|br-.*|docker0|virbr.*\"}[5m])) * 8","legendFormat":"{{instance}}","datasource":{"type":"prometheus","uid":"prom_ds"}}],"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"drawStyle":"line","lineInterpolation":"smooth","fillOpacity":8,"showPoints":"never"},"unit":"bps"},"overrides":[]},"options":{"legend":{"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"multi","sort":"desc"}}},{"type":"row","title":"Uptime","gridPos":{"h":1,"w":24,"x":0,"y":24},"id":103,"collapsed":false},{"id":9,"type":"stat","title":"Uptime (days)","gridPos":{"h":4,"w":24,"x":0,"y":25},"datasource":{"type":"prometheus","uid":"prom_ds"},"targets":[{"refId":"A","expr":"(time() - node_boot_time_seconds{job=\"node-exporter\"}) / 86400","legendFormat":"{{instance}}","datasource":{"type":"prometheus","uid":"prom_ds"}}],"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"unit":"d","decimals":1,"thresholds":{"mode":"absolute","steps":[{"color":"blue","value":null}]}},"overrides":[]},"options":{"colorMode":"value","graphMode":"none","justifyMode":"auto","orientation":"horizontal","reduceOptions":{"calcs":["lastNotNull"],"fields":"","values":false},"textMode":"value_and_name"}}],"templating":{"list":[]},"annotations":{"list":[]}}
DASH
      }

      config {
        image = "grafana/grafana:11.4.0"
        ports = ["http"]

        volumes = [
          "local/nomad.yaml:/etc/grafana/provisioning/datasources/nomad.yaml:ro",
          "local/provisioning-dashboards.yaml:/etc/grafana/provisioning/dashboards/demo.yaml:ro",
          "local/dashboards-static/demo-infra.json:/etc/grafana/dashboards-static/demo-infra.json:ro",
          "/opt/nomad/grafana/data:/var/lib/grafana",
        ]
      }

      template {
        destination = "local/provisioning-dashboards.yaml"
        change_mode   = "restart"
        data = <<-EOF
apiVersion: 1

providers:
  - name: demo-infra
    orgId: 1
    folder: Demo
    type: file
    disableDeletion: false
    editable: true
    updateIntervalSeconds: 30
    allowUiUpdates: true
    options:
      path: /etc/grafana/dashboards-static
EOF
      }

      template {
        data = <<-EOY
{{- $prom := env "NOMAD_META_prometheus_url" }}
apiVersion: 1

datasources:
  - name: Prometheus
    uid: prom_ds
    type: prometheus
    access: proxy
    url: "{{ $prom }}"
    isDefault: true
    editable: false
EOY

        destination = "local/nomad.yaml"
        change_mode = "restart"
      }

      # Grafana usa GF_SECURITY_ADMIN_* solo alla creazione iniziale del DB su volume vuoto.
      env {
        GF_PATHS_PLUGINS            = "/tmp/grafana-plugins"
        GF_SERVER_HTTP_PORT         = "3000"
        GF_SERVER_ROOT_URL          = "https://grafana.man.ovh/"
        GF_USERS_ALLOW_SIGN_UP      = "false"
        GF_AUTH_ANONYMOUS_ENABLED   = "false"
        GF_SECURITY_ADMIN_USER     = "admin"
        GF_SECURITY_ADMIN_PASSWORD = var.grafana_admin_password
      }

      service {
        name         = "grafana"
        port         = "http"
        provider     = "consul"
        address_mode = "host"

        tags = [
          "traefik.enable=true",
          "traefik.http.routers.grafana.rule=Host(`grafana.man.ovh`)",
          "traefik.http.routers.grafana.entrypoints=websecure",
          "traefik.http.routers.grafana.tls=true",
          "traefik.http.routers.grafana.tls.certresolver=myresolver",
          "traefik.http.routers.grafana.middlewares=pairdrop-proxy@file",
          "traefik.http.services.grafana.loadbalancer.passHostHeader=true",
        ]

        check {
          type                     = "http"
          path                     = "/api/health"
          interval                 = "20s"
          timeout                  = "10s"

          failures_before_critical = 5
          success_before_passing   = 1

          on_update = "ignore"
        }
      }

      resources {
        cpu        = 150
        memory     = 256
        memory_max = 1024
      }
    }
  }
}