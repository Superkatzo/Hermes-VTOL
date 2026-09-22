#!/bin/bash
# ============================================================
# Firewall-Konfiguration (UFW)
# - Default: alles eingehend blockieren
# - Erlauben: SSH (22), HTTPS (443) für Hermes-Web-UI
# ============================================================

set -euo pipefail

echo "[1/4] UFW-Status prüfen..."
sudo ufw status verbose

echo ""
echo "[2/4] Regeln setzen..."

# Defaults
sudo ufw default deny incoming
sudo ufw default allow outgoing

# SSH (zwingend, sonst sperrst du dich aus!)
sudo ufw allow 22/tcp comment 'SSH'

# HTTPS für Hermes-Web-UI (falls vorhanden)
sudo ufw allow 443/tcp comment 'Hermes Web-UI HTTPS'

# Optional: HTTP für Redirect (nur wenn du Let's Encrypt nutzt)
# sudo ufw allow 80/tcp comment 'HTTP -> HTTPS redirect'

echo ""
echo "[3/4] UFW aktivieren..."
sudo ufw --force enable

echo ""
echo "[4/4] Status anzeigen..."
sudo ufw status verbose

echo ""
echo "  ✓ Firewall aktiv."
echo ""
