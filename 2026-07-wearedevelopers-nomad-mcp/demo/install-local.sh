#!/usr/bin/env bash
set -euo pipefail

# Script di installazione locale per Nomad, Consul, Tailscale e Docker.
# Usalo su una macchina Linux che deve eseguire la demo in localhost.

if [[ $(id -u) -ne 0 ]]; then
  echo "Questo script richiede privilegi di root. Esegui con sudo."
  exit 1
fi

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

install_apt_packages() {
  apt-get update
  apt-get install -y curl unzip gnupg ca-certificates lsb-release
}

install_dnf_packages() {
  dnf install -y curl unzip gnupg2 ca-certificates lsb-release
}

install_pacman_packages() {
  pacman -Sy --noconfirm curl unzip gnupg ca-certificates
}

install_zypper_packages() {
  zypper refresh
  zypper install -y curl unzip gpg2 ca-certificates lsb-release
}

install_hashicorp_apt() {
  curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list
  apt-get update
  apt-get install -y nomad consul
}

install_hashicorp_yum() {
  yum install -y yum-utils
  yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
  yum install -y nomad consul
}

install_hashicorp_pacman() {
  echo "HashiCorp non ha repository ufficiale pacman. Uso il download diretto." >&2
  install_hashicorp_binary
}

install_hashicorp_binary() {
  local version="1.6.10"
  local arch
  arch=$(uname -m)
  case "$arch" in
    x86_64) arch="amd64" ;;
    aarch64|arm64) arch="arm64" ;;
    *) echo "Architettura non supportata: $arch" ; exit 1 ;;
  esac

  for pkg in nomad consul; do
    local url="https://releases.hashicorp.com/${pkg}/${version}/${pkg}_${version}_linux_${arch}.zip"
    curl -fsSL -o "/tmp/${pkg}.zip" "$url"
    unzip -o "/tmp/${pkg}.zip" -d /tmp
    install -m 0755 "/tmp/${pkg}" /usr/local/bin/${pkg}
  done
}

install_docker_apt() {
  apt-get update
  apt-get install -y ca-certificates curl gnupg lsb-release
  mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/$(. /etc/os-release && echo "$ID")/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$(. /etc/os-release && echo "$ID") $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
  apt-get update
  apt-get install -y docker-ce docker-ce-cli containerd.io
}

install_docker_yum() {
  yum install -y yum-utils
  yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  yum install -y docker-ce docker-ce-cli containerd.io
}

install_docker_pacman() {
  pacman -Sy --noconfirm docker containerd
}

install_tailscale() {
  if command_exists tailscale; then
    echo "Tailscale già installato"
    return
  fi
  curl -fsSL https://tailscale.com/install.sh | sh
}

if command_exists apt-get; then
  install_apt_packages
  install_hashicorp_apt
  install_docker_apt
elif command_exists dnf; then
  install_dnf_packages
  install_hashicorp_yum
  install_docker_yum
elif command_exists yum; then
  install_dnf_packages
  install_hashicorp_yum
  install_docker_yum
elif command_exists pacman; then
  install_pacman_packages
  install_hashicorp_binary
  install_docker_pacman
elif command_exists zypper; then
  install_zypper_packages
  cat >/etc/zypp/repos.d/hashicorp.repo <<'EOF'
[hashicorp]
name=HashiCorp Stable - $releasever
enabled=1
autorefresh=0
baseurl=https://rpm.releases.hashicorp.com/SLE/$releasever/x86_64
gpgcheck=1
gpgkey=https://rpm.releases.hashicorp.com/gpg
EOF
  zypper refresh
  zypper install -y nomad consul
  install_docker_yum
else
  echo "Gestore pacchetti non supportato. Installa Nomad, Consul, Docker e Tailscale manualmente." >&2
  exit 1
fi

install_tailscale

# Abilita e avvia Docker se possibile
if command_exists systemctl && command_exists docker; then
  systemctl enable docker || true
  systemctl start docker || true
fi

cat <<'EOF'

Installazione completata.
Prossimi passi consigliati:

  sudo mkdir -p /opt/consul/data
  sudo chown consul:consul /opt/consul/data
  sudo mkdir -p /opt/nomad/data
  sudo chown nomad:nomad /opt/nomad/data

  # Copia le tue configurazioni locali:
  sudo cp nomad/remote-client.hcl /etc/nomad.d/nomad.hcl
  sudo cp nomad/consul-client.hcl /etc/consul.d/consul.hcl

  sudo systemctl restart consul
  sudo systemctl restart nomad

Se usi solo localhost, imposta "bind_addr" e "advertise_addr" su 127.0.0.1 nei config file.
EOF
