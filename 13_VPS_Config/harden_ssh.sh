#!/bin/bash
# ============================================================
# SSH-Härtung
# - Nur SSH-Key-Authentifizierung
# - Root-Login deaktiviert
# - fail2ban für Brute-Force-Schutz
# ============================================================

set -euo pipefail

echo "[1/4] SSH-Config härten..."

# Backup der Original-Config
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup-$(date +%Y%m%d)

# SSH-Config-Änderungen
sudo tee /etc/ssh/sshd_config.d/00-hardening.conf > /dev/null << 'EOF'
# Nur SSH-Key-Authentifizierung
PasswordAuthentication no
PermitRootLogin no
PermitEmptyPasswords no
PubkeyAuthentication yes
ChallengeResponseAuthentication no
KerberosAuthentication no
GSSAPIAuthentication no

# Zusätzliche Härtung
X11Forwarding no
AllowTcpForwarding no
AllowAgentForwarding no
MaxAuthTries 3
MaxSessions 3
LoginGraceTime 30
ClientAliveInterval 300
ClientAliveCountMax 2
EOF

echo "[2/4] fail2ban konfigurieren..."
sudo tee /etc/fail2ban/jail.local > /dev/null << 'EOF'
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 3

[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 3600
EOF

sudo systemctl restart fail2ban
sudo systemctl enable fail2ban

echo "[3/4] SSH-Service neu starten..."
sudo sshd -t && sudo systemctl restart sshd

echo "[4/4] Verifikation..."
echo ""
echo "  Aktive SSH-Settings:"
sudo sshd -T 2>/dev/null | grep -E "^(passwordauthentication|permitrootlogin|pubkeyauthentication|maxauthtries)" | sort
echo ""
echo "  fail2ban-Status:"
sudo fail2ban-client status sshd
echo ""
echo "  WICHTIG: Teste die Verbindung aus einem zweiten Terminal,"
echo "  bevor du dieses Fenster schließt! Sonst sperrst du dich aus."
echo ""
