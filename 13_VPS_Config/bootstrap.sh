#!/bin/bash
# ============================================================
# Hermes-VPS Bootstrap-Skript
# Ausführen als 'hermes' User (nicht root)
# ============================================================
#
# Voraussetzungen:
#   - Ubuntu 22.04 LTS oder neuer
#   - SSH-Key-Auth funktioniert
#   - User 'hermes' existiert und hat sudo-Rechte
#
# Aufruf:
#   bash bootstrap.sh
#
# ============================================================

set -euo pipefail

echo "=========================================="
echo "  Hermes-VPS Bootstrap"
echo "=========================================="
echo ""

# System aktualisieren
echo "[1/8] System-Update..."
sudo apt update && sudo apt upgrade -y

# Wichtige Pakete installieren
echo "[2/8] Grundpakete installieren..."
sudo apt install -y \
    curl \
    wget \
    git \
    vim \
    htop \
    tmux \
    ufw \
    fail2ban \
    unattended-upgrades \
    apt-listchanges \
    ca-certificates \
    gnupg \
    lsb-release \
    software-properties-common

# Docker installieren (optional, je nach Setup)
echo "[3/8] Docker installieren..."
if ! command -v docker &> /dev/null; then
    curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
    sudo sh /tmp/get-docker.sh
    sudo usermod -aG docker "$USER"
    rm /tmp/get-docker.sh
    echo "Docker installiert."
else
    echo "Docker bereits installiert."
fi

# Docker-Compose installieren (falls nicht vorhanden)
echo "[4/8] Docker-Compose installieren..."
if ! command -v docker compose &> /dev/null; then
    sudo apt install -y docker-compose-plugin
fi

# Hermes-spezifische Verzeichnisse anlegen
echo "[5/8] Verzeichnisstruktur anlegen..."
mkdir -p "$HOME/hermes/data/memory"
mkdir -p "$HOME/hermes/data/logs"
mkdir -p "$HOME/hermes/data/cache"
mkdir -p "$HOME/hermes/config"

# Bash-Aliasse für komfortableres Arbeiten
echo "[6/8] Aliasse einrichten..."
cat >> "$HOME/.bashrc" << 'EOF'

# Hermes-VPS Aliasse
alias ll='ls -la'
alias h='htop'
alias df='df -h'
alias mem='free -h'
alias hermes-logs='tail -f ~/hermes/data/logs/*.log 2>/dev/null'
alias hermes-status='sudo systemctl status hermes-agent 2>/dev/null || docker ps'
EOF

# Memory und Disk-Status
echo "[7/8] System-Status..."
echo ""
echo "  RAM:    $(free -h | grep Mem | awk '{print $3 " / " $2}')"
echo "  Disk:   $(df -h / | tail -1 | awk '{print $3 " / " $2}')"
echo "  CPU:    $(nproc) Core(s)"
echo ""

# Done
echo "[8/8] Bootstrap abgeschlossen."
echo ""
echo "=========================================="
echo "  Nächste Schritte:"
echo "=========================================="
echo ""
echo "  1. SSH-Härtung:    bash harden_ssh.sh"
echo "  2. Firewall:       bash setup_firewall.sh"
echo "  3. Auto-Updates:   bash auto_updates.sh"
echo "  4. Health-Monitor: bash monitor.sh"
echo ""
echo "  Danach: Hermes-Agent-Status prüfen:"
echo "    sudo systemctl status hermes-agent"
echo "  oder (Docker-Setup):"
echo "    docker ps"
echo ""
