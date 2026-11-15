# Nomad client sul PC → server via Tailscale (IP server: 100.71.13.115).
#
# 1) advertise: IP Tailscale del laptop (qui 100.118.206.109), allineato a Consul advertise sul PC.
# 2) Firewall: in genere Tailscale è già aperto; altrimenti TCP 41641/UDP (Tailscale), sul server anche 4647/8500/8301 se bloccati sul link TS.
# 3) sudo cp remote-client.hcl /etc/nomad.d/nomad.hcl && sudo systemctl restart nomad
#
# Consul: con agent locale (`consul members` → `man` client) usa **127.0.0.1:8500** così Nomad registra
# i servizi sul nodo Consul `man`. Con solo API remota al server le registrazioni `provider=consul` restano ambigue.
# Per schedulare workload solo su questo nodo: constraint `meta.pool = "laptop"`.

data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"

datacenter = "dc1"

advertise {
  http = "100.118.206.109"
  rpc  = "100.118.206.109"
  serf = "100.118.206.109"
}

server {
  enabled = false
}

client {
  enabled = true
  servers = ["100.71.13.115:4647"]

  meta {
    pool = "laptop"
  }

  # Per job con porta statica bridge: la "default" host network segue il default route (LAN).
  # Glance usa host_network="tailscale" nel job così Docker bind sulla 100.x usata dal reverse proxy.
  # CIDR Tailscale RFC6598 CGNAT — evita dipendenza dal nome interfaccia (tailscale0 vs utun).
  host_network "tailscale" {
    cidr = "100.64.0.0/10"
  }
}

consul {
  address = "http://127.0.0.1:8500"
}

# Senza agent Consul sul PC, ripristina: address = "http://100.112.254.123:8500"

plugin "docker" {
  config {
    volumes {
      enabled = true
    }
  }
}

# Driver QEMU (VM): richiede QEMU sul PATH del processo nomad (es. /usr/bin) e, per KVM, accesso a /dev/kvm.
#
# Arch Linux — dopo aver copiato questo file in /etc/nomad.d/ e prima del restart:
#   sudo pacman -S qemu-base          # metapacchetto con QEMU + util CLI (qemu-img, qemu-system-x86_64)
#   sudo pacman -S qemu-img          # opzionale: CLI per creare/convertire .qcow2
#   sudo mkdir -p /opt/nomad/data/qemu-images
#   sudo chmod 755 /opt/nomad/data/qemu-images
#   Se l'agent Nomad non gira come root: sudo usermod -aG kvm nomad
#   Moduli KVM se mancano: lsmod | grep kvm — su Intel/AMD carica kvm_intel o kvm_amd (vedi wiki Arch "KVM").
# Poi: sudo systemctl restart nomad
# Verifica fingerprint: nomad node status -self | grep -i qemu
#
# Le immagini .qcow2/.img usate dai job devono stare sotto image_paths (o in alloc dir via artifact).
plugin "qemu" {
  config {
    image_paths = ["/opt/nomad/data/qemu-images"]
  }
}