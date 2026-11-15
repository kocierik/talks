# Consul client configuration for 100.87.120.18
# Copy to /etc/consul.d/consul.hcl on that host and restart Consul.

data_dir = "/opt/consul/data"

server = false

datacenter = "dc1"

advertise_addr = "100.87.120.18"
bind_addr      = "0.0.0.0"

# Loopback CLI + Tailscale (API Consul raggiungibile dalla mesh)
client_addr = "127.0.0.1 100.87.120.18"

retry_join = ["100.71.13.115"]
