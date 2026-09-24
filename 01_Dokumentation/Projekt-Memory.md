# Projekt-Memory — Detailwissen für Hermes-VTOL

> **Zweck:** Diese Datei ist das ausgelagerte Detail-Gedächtnis für das VTOL-Projekt.
> Das **Hermes-Memory** (testbot-Profil) hält nur den Quick-Reference-Teil;
> alles Spezifische, das nicht jeder Chat braucht, lebt hier und wird bei Bedarf geladen.
>
> **Pflege:** Manuell oder per Chat-Befehl „speichere X in die Memory-Datei".
> Letzte Aktualisierung: 2026-09-24

---

## 🛩️ Projekt-Kern (Architektur & Stack)

**Zielplattform:** Zivile VTOL-Drohne, Pusher-Quadplane-Konfiguration, ≤ 2 m Spannweite, CFK-Bauweise, BVLOS-vorbereitet.

**Use-Cases:**

- 🚁 SAR (Safety & Rescue) — Personensuche, Lageerkundung
- 🦌 Wildschutz — Tiererkennung, Monitoring
- 🏛️ Behörden — Lagebilder, Katastrophenmanagement
- 📷 Kommerzielle Inspektion — Vermessung, Industriekontrolle

**Tech-Stack:**

- **Flight-Controller:** PX4 oder ArduPilot (Entscheidung offen, Job in Todo-Liste)
- **Aerodynamik-Tools:** XFLR5 (Profil-Polaren), OpenVSP (3D-Modell)
- **CAD:** Fusion 360 (primär), Onshape (nur Kleinteile) — siehe User-Profil
- **FEM:** Fusion 360 oder ANSYS
- **Antrieb:** 14S Li-Ion · Molicel 21700 6500 mAh (~325 Wh/kg) · T-Motor P60 KV170 als Hub-Motor (in Evaluation)
- **Lastenheft v1.1:** MTOM 16 kg · Payload 2,28 kg · Schwebeschub-Faktor 2,10×

---

## 🧠 Strategie (Stand 23.09.2026)

**Entscheidung:** Drohne wird **nicht selbst geflogen**, sondern **verkauft** (Hersteller/Designer-Perspektive).

**Konsequenzen für den User:**

- Operator-Pflichten entfallen (Pilot-Lizenz, Versicherung, SORA-LBA-Antrag → Käufer)
- Hauptfokus jetzt: **CE-Kennzeichnung** (Klasse C3 wahrscheinlich) + **Produkthaftung** + **SORA-Vorlage als Verkauf-Hebel**
- **ConOps-Vorlage-SAR.md** ist der größte Verkaufs-Trumpf (Käufer kann sofort loslegen)

**Marketing-Position:** „Pickup-Truck der Lüfte" — vielseitig, modular, austauschbarer Payload-Container.

---

## 🏗️ VPS-Infrastruktur (Hostinger KVM 1)

**Server:**

- Hostname: `srv1998925.hstgr.cloud`
- IP: `179.198.208.197`
- SSH-Alias: `hermes-vps` (in `~/.ssh/config`)
- Auth: SSH-Key (auch root möglich)
- Admin-Passwort wurde vom User über hPanel geändert

**Hermes-Agent-Container:**

- Name: `hermes-agent-ekgx-hermes-agent-1`
- Image: `ghcr.io/hostinger/hvps-hermes-agent:latest`
- Interner Port: 4860
- **KRITISCH: Externer Docker-Port wechselt dynamisch** (beobachtet: 32768 ↔ 32770)
- → Vor jedem Tunnel: `sudo docker ps --format "{{.Ports}}" | grep hermes` prüfen
- → SSH-Config `LocalForward` entsprechend anpassen, sonst `Connection refused` auf `localhost:8080`

**Auto-Tunnel-Helper:** `13_VPS_Config/Hermes-Tunnel-Auto.bat` (portiert die dynamische Port-Erkennung in eine Scheduled Task)

**Traefik** lauscht auf 80/443 für spätere HTTPS-Nutzung (Domain noch nicht aufgeschaltet).

**Repo auf VPS:** `/home/hermes/Hermes-VTOL` (gespiegelt von GitHub `Superkatzo/Hermes-VTOL`)
**Lokales Repo auf PC:** `C:\Users\willow\Documents\Hermes-VTOL`

---

## ⏰ VPS-Cronjobs (11 aktiv, Stand 23.09.2026)

Alle Skripte versioniert in `13_VPS_Config/`. Telegram-Vorlage: Token live aus `/opt/data/.env` (`docker exec ... grep ^TELEGRAM_BOT_TOKEN`), CHAT_ID = `858968389` (TELEGRAM_HOME_CHANNEL). UTC ↔ MESZ = +2 im Sommer.

| Cron | Skript | Zweck |
| --- | --- | --- |
| `0 * * * *` | `hermes_health_monitor.sh` | Stündlicher Health-Check |
| `*/10 * * * *` | `check_self_ssh.sh` | Selbst-SSH alle 10 min |
| `*/15 * * * *` | `vps_monitor.sh` | VPS-Ressourcen alle 15 min |
| `*/30 * * * *` | `container_health.sh` | Container-Status alle 30 min |
| `*/30 * * * *` | `check_connectivity.sh` | Netzwerk alle 30 min |
| `0 3 * * *` | `hermes_backup.sh` | Backup 05:00 MESZ (131 MB, 14 Tage Retention) |
| `30 3 * * *` | `hermes_backup_retention.sh` | Backup-Cleanup 05:30 MESZ |
| `0 4 * * *` | `check_container_updates.sh` | Manual Container-Update-Check 06:00 MESZ (Watchtower inkompatibel mit Docker 29.8.1) |
| `0 8 * * 1-7` | `morning_briefing.sh` | Daily Morning-Message 10:00 MESZ via Telegram-Bot-API |
| `0 23 * * *` | `security_monitor.sh` | Security-Monitor 01:00 MESZ |
| `0 8 30 9 *` | `repo_review_reminder.sh` | **EINMALIG** Repo-Review-Reminder 30.09.2026 10:00 MESZ, danach manuell entfernen |
| `30 9 * * 5` | `github_cleaning_reminder.sh` | Wöchentlich freitags 11:30 MESZ GitHub-Repo-Cleaning-Hinweis |

---

## 📡 Telegram-Bot

- Läuft auf VPS (python-telegram-bot)
- Token + erlaubte User-IDs in `/docker/hermes-agent-ekgx/data/.env`:
  - `TELEGRAM_BOT_TOKEN=...`
  - `TELEGRAM_ALLOWED_USERS=...`
- **Polling-Konflikt-Pitfall:** Wenn der gleiche Token von einer 2. Instanz (z. B. lokale Desktop-App) verwendet wird → Token-Konflikt. Lösung: Lokale `# TELEGRAM_BOT_TOKEN=...` auskommentieren.
- **Sidecar:** `telegram_to_github.sh` deployed (Commit `3e91d85`), wartet auf (a) GitHub-PAT in `/opt/data/.env` und (b) `systemctl enable hermes-telegram-sidecar`
- Sidecar-Tests seit 23.09.: Pipeline funktioniert, Chronik-Einträge werden korrekt platziert

---

## 🤖 Geplante Experten-Bots (Job #1)

| Bot | Domäne | Verweist bei … |
| --- | --- | --- |
| **aero-wing-bot** | Aerodynamik + Profil-Design (Tragflügel, XFLR5, OpenVSP, Polaren, Reynolds, Stall, Böen-Lasten) | Struktur/Antrieb/Avionik auf andere Bots |
| **regulatory-bot** | Regulatorik + Zulassung (EU/EASA, USA/FAA, SORA, Pilot-Lizenzen, Versicherung, Drohnenklassen) | Technische Fragen auf andere Bots |

**Setup-Plan:**

1. Profile in Hermes anlegen (VPS bevorzugt nach Job #0)
2. Persona-Dokumente für jeden Bot (Rollen, Tools, Ausschlüsse)
3. Wissen einspeisen (1. Konversation pro Bot mit Domänenwissen)
4. Erste echte Fragen testen (Aero: „vergleich 4 Profile", Regulatory: „was gilt für 16 kg in DE?")

**Bis Projekt steht bleibt testbot „Dirigent".**

---

## 🔒 Sicherheits-Containment (Job #0)

**Ziel-Architektur:** ALLES über VPS — kein direkter LLM-Zugang von PC/Laptop. Nur die Hermes-Desktop-App als dünner Client zum VPS.

**Grund:** Agent-Bugs (z. B. prompt-injection) dürfen nicht das lokale System kompromittieren.

**Aktueller Status:** Mischbetrieb, Umstellung läuft.

**Konkrete Aufgaben (Job #0 in Todo-Liste):**

- [ ] MiniMax-Account auf VPS-Hermes ist der einzige — kein lokaler MiniMax-Login mehr
- [ ] Hermes-Desktop-App auf PC: VPS-Profil nutzen
- [ ] Hermes-Desktop-App auf Laptop: VPS-Profil nutzen
- [ ] Lokale Tokens entfernen/prüfen — `MEMORY.md` auf PC enthält keine Credentials
- [ ] GitHub-Token nur auf VPS
- [ ] SSH-Keys für VPS bleiben lokal (PC braucht sie für Tunnel) — ok, VPS-spezifisch
- [ ] Containment-Ziel erreicht

---

## 🐛 Bekannter Bug: Antworten verschwinden aus Chat-UI

**Dokumentiert in:** `01_Dokumentation/Protokolle/Hermes-Desktop-Bug-Antwort-Verschwindet.md` (DE) + `...-EN.md` (EN)

**Symptom:** Bei Compaction (256k-Token-Threshold) oder Scroll/Reload verschwinden gerenderte Antworten komplett aus dem UI-State. Backend hat sie noch.

**Workaround (kurzfristig):**

1. Nach jeder Antwort: `Ctrl+A` → `Ctrl+C` in `.md` oder Chat
2. Bei sensiblen Inhalten: Erst Repo-Commit, dann Antwort lesen
3. Bei 256k-Token-Nähe: Neue Session starten mit Checkpoint-File

**Langfristig:** Siehe Issue-File für Triage-Empfehlungen.

---

## 📝 Persistenz-Strategie

- **Memory:** Nur für **sehr kurze, hochrelevante Quick-Reference-Fakten** (Ziel < 50 % Auslastung)
- **Persistente Notizen:** Primär via Repo-Dateien (diese Datei, Todo-Liste, ConOps, etc.)
- **Subagent-Sessions:** Haben KEIN `memory()` und kein `skills_list` → Persistenz via Repo oder finalem Summary
- **Befund-Doku:** `01_Dokumentation/Protokolle/Memory-Persistenz-Test-2026-09-23.md`

---

## 🌙 Arbeitsrythmus (Stand 23.09.2026)

- **Aktuell:** Nachteulen-Modus — aufstehen 14–15 Uhr, arbeiten 12–04 Uhr nachts
- **Ab Mo 28.09.:** Normaler Tag, aufstehen 9–10 Uhr
- Cron-Times und Morning-Briefing auf UTC + Bezug MESZ planen

---

## 🧩 Wichtige Repo-Pfade (Quick-Reference)

| Pfad | Inhalt |
| --- | --- |
| `01_Dokumentation/Lastenheft/` | Lastenheft v1.1 |
| `01_Dokumentation/Todos/Todo-Liste.md` | **Haupt-TODO** (dynamisch via Chat) |
| `01_Dokumentation/ConOps/` | ConOps-Vorlagen (SAR als Verkauf-Trumpf) |
| `01_Dokumentation/Regulatorik-Notizen/` | EASA, FAA, SORA-Notizen |
| `01_Dokumentation/Projekt-Memory.md` | **Diese Datei** (ausgelagertes Detailwissen) |
| `01_Dokumentation/Protokolle/` | Vorfall-Protokolle, Tests, Bug-Reports |
| `02_Aerodynamik/` | XFLR5-Profile, OpenVSP-Modell |
| `03_CAD/` | STEP/STL-Exporte (Fusion 360 → Cloud, STEP/STL hier) |
| `09_Regulatorik/` | Vollständige Drohnenklasse-Doku EU/US |
| `13_VPS_Config/` | Alle VPS-Skripte versioniert |

---

## 📜 Chronik (Änderungen an dieser Datei)

| Datum | Änderung |
|---|---|
| 2026-09-24 | Initiale Datei angelegt — Detailwissen aus Hermes-Memory ausgelagert (Cronjob-Liste, VPS-Details, Bot-Team-Plan, Persistenz-Strategie) |
