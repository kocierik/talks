# Nomad Server & Client Configuration
# Copia questo file in /etc/nomad.d/nomad.hcl sul server
#
# Client remoti (laptop su Tailscale) devono poter usare Serf/RPC su questo IP.
data_dir = "/opt/nomad/data"

bind_addr = "0.0.0.0"

advertise {
  http = "100.71.13.115"
  rpc  = "100.71.13.115"
  serf = "100.71.13.115"
}

server {
  enabled          = true
  bootstrap_expect = 1
  # Oversubscription per memory_max nei job non è configurabile qui (API raft):
  # nomad operator scheduler set-config -memory-oversubscription=true -check-index <ModifyIndex>
}

client {
  enabled = true

  # Stesso CIDR del laptop: consente `host_network = "tailscale"` nei job (es. node-exporter)
  # così Consul pubblica l’IP tailnet per lo scrape da Prometheus su serverman.
  host_network "tailscale" {
    cidr = "100.64.0.0/10"
  }
}

consul {
  address = "127.0.0.1:8500"
}

plugin "docker" {
  config {
    allow_privileged = false
    volumes {
      enabled = true
    }
  }
}