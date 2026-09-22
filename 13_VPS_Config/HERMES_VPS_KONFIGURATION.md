# Hermes-VPS Konfiguration

Live-Konfiguration des produktiven Hermes-VPS (Stand: aktiv).

## Server-Übersicht

| Element | Wert |
|---------|------|
| **Anbieter** | Hostinger |
| **Plan** | KVM 1 |
| **Standort** | Deutschland |
| **Hostname** | srv1998925.hstgr.cloud |
| **IPv4** | 179.198.208.197 |
| **OS** | Ubuntu 24.04 LTS |
| **RAM** | 3,8 GB / 4 GB |
| **Disk** | 6,1 GB / 48 GB |

## Zugang

| Methode | Befehl |
|---------|--------|
| **SSH (Standard)** | `ssh hermes-vps` |
| **SSH mit Hostname** | `ssh srv1998925` |
| **Tunnel für UI** | `ssh -L 8080:127.0.0.1:32768 -N hermes-vps` |
| **Hermes-UI (im Browser)** | `http://localhost:8080` |

## LLM-Konfiguration

| Element | Wert |
|---------|------|
| **Provider** | `minimax-oauth` |
| **Modell** | `MiniMax-M3` |
| **Endpunkt** | `https://api.minimax.io/anthropic` |
| **API-Modus** | `anthropic_messages` |
| **Auth-Methode** | OAuth-Login (Credentials in `~/.hermes/auth.json`) |

## Sicherheit

| Aspekt | Status |
|--------|--------|
| **Root-Login** | deaktiviert |
| **Passwort-Login** | deaktiviert |
| **SSH-Key-Auth** | aktiv (ed25519) |
| **fail2ban** | aktiv (sshd-Jail) |
| **UFW-Firewall** | aktiv (22, 443 offen) |
| **unattended-upgrades** | aktiv |
| **SSH-Tunnel** | `AllowTcpForwarding local` |

## Container-Stack

| Container | Image | Funktion |
|-----------|-------|----------|
| `hermes-agent-ekgx-hermes-agent-1` | `ghcr.io/hostinger/hvps-hermes-agent:latest` | Hermes-Agent + UI |
| `traefik-traefik-1` | `traefik:latest` | Reverse-Proxy (HTTP/HTTPS) |

## Context-Kompression

Hermes komprimiert automatisch den Kontext:

| Setting | Wert |
|---------|------|
| **Enabled** | ja |
| **Threshold** | 50 % des Token-Caps |
| **Token-Cap** | 256.000 Tokens |
| **Protect last** | 20 Nachrichten |
| **Protect first** | 3 Head-Messages |

→ Bei ~128k Tokens beginnt die Komprimierung (ältere Teile werden zusammengefasst).

## Persistente Pfade

| Pfad im Container | Pfad auf VPS |
|-------------------|-------------|
| `/opt/data/config.yaml` | `/docker/hermes-agent-ekgx/data/config.yaml` |
| `/opt/data/.env` | `/docker/hermes-agent-ekgx/data/.env` |
| `/opt/data/SOUL.md` | `/docker/hermes-agent-ekgx/data/SOUL.md` |
| `/opt/data/cron/` | `/docker/hermes-agent-ekgx/data/cron/` |
| `/opt/data/backups/` | `/docker/hermes-agent-ekgx/data/backups/` |

## Zugriff auf Container

```bash
# Einmal-Befehl im Container:
sudo docker exec hermes-agent-ekgx-hermes-agent-1 /opt/hermes/bin/hermes <command>

# Interaktive Shell:
sudo docker exec -it hermes-agent-ekgx-hermes-agent-1 /bin/bash
```

## Nächste Schritte

- [ ] Passwort der Hermes-Web-UI ändern (Sicherheit)
- [ ] Backups in Hostinger-Panel aktivieren
- [ ] Health-Monitor-Cron einrichten
- [ ] Telegram-Bot-Anbindung (optional)
- [ ] Eigene Domain + HTTPS via Caddy (optional)
