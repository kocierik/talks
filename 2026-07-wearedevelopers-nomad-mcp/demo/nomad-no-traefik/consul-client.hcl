# Consul agent (client) sul PC che join-a il server via Tailscale.
#
# PC advertise: IP Tailscale laptop (100.118.206.109) | Server join: Tailscale server (100.71.13.115)
#
# Serf gossip: default 8301/tcp+udp (raggiungibile sul percorso Tailscale tra i due nodi).
#
# Setup:
#   sudo mkdir -p /opt/consul/data && sudo chown consul:consul /opt/consul/data
#   sudo cp consul-client-local-pc.hcl /etc/consul.d/consul.hcl
#   sudo systemctl restart consul
#
# Sul server (fw): permetti 8301/tcp+udp da IP pubblico/VPN dal quale parte il gossip.

data_dir = "/opt/consul/data"

server = false

datacenter = "dc1"

advertise_addr = "100.118.206.109"
bind_addr      = "0.0.0.0"

# Loopback CLI + Tailscale (API Consul raggiungibile dalla mesh)
client_addr = "127.0.0.1 100.118.206.109"

retry_join = ["100.71.13.115"]