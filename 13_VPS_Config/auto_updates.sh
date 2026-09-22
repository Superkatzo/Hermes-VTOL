#!/bin/bash
# ============================================================
# Automatische Security-Updates
# ============================================================

set -euo pipefail

echo "[1/3] unattended-upgrades konfigurieren..."

sudo tee /etc/apt/apt.conf.d/20auto-upgrades > /dev/null << 'EOF'
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Download-Upgradeable-Packages "1";
EOF

echo "[2/3] Unattended-Upgrades aktivieren..."

sudo tee /etc/apt/apt.conf.d/50unattended-upgrades > /dev/null << 'EOF'
Unattended-Upgrade::Allowed-Origins {
    "${distro_id}:${distro_codename}";
    "${distro_id}:${distro_codename}-security";
    "${distro_id}:${distro_codename}-updates";
};

Unattended-Upgrade::DevRelease "false";
Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";
Unattended-Upgrade::Remove-Unused-Dependencies "true";
Unattended-Upgrade::Automatic-Reboot "false";
Unattended-Upgrade::Automatic-Reboot-Time "04:00";
EOF

echo "[3/3] Service aktivieren..."
sudo systemctl restart unattended-upgrades
sudo systemctl enable unattended-upgrades

echo ""
echo "  ✓ Auto-Updates aktiv."
echo ""
echo "  Status:"
sudo systemctl status unattended-upgrades --no-pager -l
echo ""
