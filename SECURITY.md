# SECURITY.md — Hermes-VTOL Sicherheits-Dokumentation

> **Zweck:** Übersicht aller Sicherheits-Maßnahmen, die auf dem VPS `hermes-vps` (Hostinger KVM 1) umgesetzt sind.
> **Stand:** 2026-09-24
> **Wichtig:** Diese Datei enthält KEINE Secrets, IPs oder Token.

---

## 1. SSH-Härtung

### 1.1 Passwort-Login deaktiviert

In `/etc/ssh/sshd_config`:

```text
PasswordAuthentication no
```text

**Effekt:** SSH akzeptiert nur noch Public-Key-Authentifizierung. Brute-Force über Passwörter ist nicht mehr möglich.

### 1.2 SSH-Key-Authentifizierung

- **Public-Key:** `ED25519 SHA256:Adi1Y6xKW5p4zzgaPFzuPWIctTKPv9kjVMUE6cB/32k` (in `~/.ssh/authorized_keys` des Users `hermes`)
- **Private-Key-Pfad (lokal):** `~/.ssh/hostinger_vps` (siehe `~/.ssh/config` für Alias `hermes-vps`)

### 1.3 fail2ban

- **Version:** 1.0.2
- **sshd-Jail aktiv:** `maxretry=3`, `bantime=3600s`, `findtime=600s`
- **Backend:** nftables (über `f2b-chain` in `table inet f2b-table`)

---

## 2. Recovery-Plan

### 2.1 Wenn der SSH-Key verloren geht

1. **Hostinger hPanel** öffnen: <https://hpanel.hostinger.com>
2. **VPS → Console** (Browser-Terminal, kein SSH nötig)
3. **Neuen SSH-Key hinterlegen:**

   ```bash
   mkdir -p ~/.ssh
   echo "ssh-ed25519 NEUER_KEY_HIER user@host" >> ~/.ssh/authorized_keys
   chmod 600 ~/.ssh/authorized_keys
```text

### 2.2 Wenn fail2ban dich selbst aussperrt

1. **hPanel-Console** öffnen (wie oben)
2. **fail2ban-Status prüfen:**

   ```bash
   sudo fail2ban-client status sshd
```text

3. **IP entsperren:**

   ```bash
   sudo fail2ban-client set sshd unbanip DEINE.EIGENE.IP
```text

### 2.3 Wenn der Container nicht startet

1. **hPanel-Console** öffnen
2. **Docker-Status:**

   ```bash
   sudo docker ps -a
   sudo docker logs CONTAINER_NAME
```text

3. **Container-Restart:**

   ```bash
   sudo docker restart hermes-agent-ekgx-hermes-agent-1
```text

---

## 3. Sicherheits-Monitoring

### 3.1 Aktive Monitor-Scripts

| Script | Cron | Zweck | Schwelle |
| --- | --- | --- | --- |
| `hermes_health_monitor.sh` | alle 60 min | Disk, RAM, Container, SSH-Logins | SSH>10/h |
| `vps_monitor.sh` | alle 15 min | Container, Disk, RAM, Load, SSH | SSH>10/h |
| `security_monitor.sh` | täglich 23:00 | SSH-Bruteforce, fail2ban-Status | SSH>20/h |
| `container_health.sh` | alle 30 min | Container-Restarts > 3, Container-Down | Restarts>3 |

### 3.2 Bugfix-Historie

- **2026-09-24:** Alle 4 Scripts hatten den Bug, dass `grep -c "Failed password"` eigene `sudo`-Aufrufe mitzählte. Fix: `grep "sshd\[.*\]: Failed password" | grep -v "sudo:"` + `journalctl --since "1 hour ago"` statt auth.log total.

---

## 4. Was du NICHT im Repo findest

Folgende Dinge sind **bewusst nicht** im Repo (Sicherheit):

- ❌ VPS-IP-Adresse
- ❌ SSH-Public-Key (außer der in `~/.ssh/config` lokal)
- ❌ GitHub-PAT (in `/opt/data/.env` im Container, nicht im Repo)
- ❌ Telegram-Bot-Token (in `/opt/data/.env` im Container)
- ❌ hPanel-Zugangsdaten
- ❌ VPS-Admin-Passwort

**Wo diese stattdessen gespeichert sind:**

- Container-`/opt/data/.env` (live deployed, nicht versioniert)
- Lokaler `~/.ssh/` (User-spezifisch, nicht im Repo)
- User-Gedächtnis / Passwort-Manager

---

## 5. Zukünftige Härtungs-Schritte

| # | Was | Status |
| --- | --- | --- |
| 1 | SSH-Port ändern (von 22 auf was anderes) | ⚠️ offen — reduziert Bot-Scans um ~90 % |
| 2 | UFW-Regel: SSH nur von deiner IP | ⚠️ offen — maximale Härtung |
| 3 | 2FA für hPanel | ⚠️ offen — Account-Sicherheit |
| 4 | Auto-Updates für Sicherheits-Patches | ⚠️ offen — unattended-upgrades |
| 5 | Hauptbot auf Webhook umstellen | ⚠️ offen — vermeidet Polling-Konflikte |

---

## 6. Wichtige Log-Pfade

Auf dem VPS:

- **SSH-Auth:** `/var/log/auth.log`
- **fail2ban:** `/var/log/fail2ban.log`
- **Container-Logs:** `sudo docker logs CONTAINER_NAME`
- **Cron-Logs:** `/home/hermes/hermes/logs/cron.log`
