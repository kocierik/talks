# Copia in /etc/consul.d/consul.hcl (consul.service usa -config-dir=/etc/consul.d/).
# Se dopo il deploy il riavvio va ancora in timeout, aumenta TimeoutStartSec nel drop-in systemd.

data_dir = "/opt/consul/data"

server = true
bootstrap_expect = 1

ui_config {
  enabled = true
}

# advertise Serf LAN: Tailscale così altri nodi (es. laptop) join-ano sulla mesh senza WAN.
# Ritenta se tailscale non è su eth0: allinea o usa leave_on_terminate + restart ordinato.
bind_addr      = "0.0.0.0"
advertise_addr = "100.71.13.115"

# Loopback (Nomad locale), Tailscale (server sulla VPN).
client_addr = "127.0.0.1 100.71.13.115"

ports {
  http = 8500
}
 