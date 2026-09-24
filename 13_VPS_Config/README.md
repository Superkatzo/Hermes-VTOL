# 13_VPS_Config

Konfiguration und Setup-Skripte für den Hostinger VPS (Hermes-Agent-Instanz).

## Überblick

| Element | Wert |
| --------- | ------ |
| **Anbieter** | Hostinger |
| **Plan** | KVM 1 |
| **Standort** | Deutschland (DSGVO) |
| **Zweck** | Isolierte Laufzeit-Umgebung für Hermes-Agent |
| **Authentifizierung** | SSH-Key (siehe `ssh_key_setup.md`) |

## Inhalt

| Datei | Zweck |
| ------- | ------- |
| `bootstrap.sh` | Initiales Setup auf einem frischen Ubuntu-VPS |
| `harden_ssh.sh` | SSH-Härtung: Key-only, no root, fail2ban |
| `setup_firewall.sh` | UFW-Firewall-Konfiguration |
| `auto_updates.sh` | Unattended-Upgrades aktivieren |
| `monitor.sh` | Health-Check + Memory-Reporting |
| `ssh_key_setup.md` | Anleitung SSH-Key-Generierung |

## Erstmaliges Setup (Reihenfolge)

1. VPS bestellen (Hostinger) → IP-Adresse per E-Mail
2. SSH-Key auf VPS hinterlegen (Hostinger-Webpanel)
3. Verbindung testen: `ssh hermes-vps`
4. `bash bootstrap.sh` ausführen
5. `bash harden_ssh.sh` ausführen
6. `bash setup_firewall.sh` ausführen
7. `bash auto_updates.sh` ausführen
8. `bash monitor.sh` für Health-Check einrichten (Cron)

## Sicherheitsprinzipien

- **Kein Passwort-Login** (nur SSH-Key)
- **Root-Login deaktiviert**
- **Minimaler Port-Zugriff** (22 SSH, 443 HTTPS für Hermes-UI)
- **Automatische Security-Updates**
- **Tägliche Memory-Backups**
- **Watchtower für Container-Updates** (wenn Docker genutzt wird)

## Wiederherstellung

Falls etwas schiefgeht:

1. Hostinger-Panel → VPS → **Reset/Snapshot**
2. Bootstrap-Skripte erneut laufen lassen
3. Memory-Backup zurückspielen
