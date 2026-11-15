# Nomad client configuration for nomad-server-2 acting as a client (100.87.120.18)
# Copy this file to /etc/nomad.d/nomad.hcl on 100.87.120.18 and restart Nomad.

data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"

datacenter = "dc1"

advertise {
  http = "100.87.120.18"
  rpc  = "100.87.120.18"
  serf = "100.87.120.18"
}

server {
  enabled = false
}

client {
  enabled = true
  servers = ["100.71.13.115:4647"]

  meta {
    pool = "remote-client"
  }

  host_network "tailscale" {
    cidr = "100.64.0.0/10"
  }
}

consul {
  address = "http://127.0.0.1:8500"
}

plugin "docker" {
  config {
    volumes {
      enabled = true
    }
  }
}
