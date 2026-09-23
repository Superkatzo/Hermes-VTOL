# 📋 Todo-Liste — Hermes-VTOL Projekt

> **Dynamische, lebendige TODO-Liste** für das VTOL-Drohnen-Projekt (ziviler Einsatz).
> Diese Liste wird **bei jeder Erwähnung im Chat** ergänzt: einfach „speichere dies für später" sagen.

**Verwendung:**
- Neue Tasks unten anhängen
- Erledigte mit `[x]` markieren (nicht löschen — Historie behalten)
- Cron-Jobs können einzelne Sektionen automatisieren
- Immer mit Datum versehen

---

## 🔴 Aktuell in Arbeit (Heute / Morgen)

### Job #0 — Komplett auf VPS umstellen (SECURITY, 2026-09-22)
- [ ] **MiniMax-Account auf VPS-Hermes ist der einzige** — kein lokaler MiniMax-Login mehr auf PC/Laptop
- [ ] **Hermes-Desktop-App auf PC: VPS-Profil nutzen** (nicht lokales Profil) — Desktop-App wird zum reinen Client
- [ ] **Hermes-Desktop-App auf Laptop: VPS-Profil nutzen** — Laptop darf KEINEN direkten MiniMax-Zugang haben
- [ ] **Lokale Tokens entfernen/prüfen** — `MEMORY.md` auf PC enthält keine Credentials mehr (oder Account abmelden)
- [ ] **GitHub-Token nur auf VPS** — lokaler `gh auth` nicht nötig, PC pusht über VPN oder behält nur Lese-Rechte
- [ ] **SSH-Keys für VPS bleiben lokal** (PC braucht sie für Tunnel) — sind ok, weil VPS-spezifisch
- [ ] **Containment-Ziel erreicht:** Agent-Bugs beschränken sich auf VPS, niemals auf PC/Laptop

### Job #1 — Experten-Bot-Team für VTOL (2026-09-22)
- [ ] **Aero-Wing-Bot erstellen** — Persona: Aerodynamik + Profil-Design (Tragflügel, XFLR5, OpenVSP, Polaren, Reynolds, Stall, Böen-Lasten). Verweist bei Struktur/Antrieb/Avionik auf andere Bots.
- [ ] **Regulatory-Bot erstellen** — Persona: Regulatorik + Zulassung (EU/EASA, USA/FAA, SORA, Pilot-Lizenzen, Versicherung, Drohnenklassen). Verweist bei technischen Fragen auf andere Bots.
- [ ] **Profile in Hermes anlegen** (VPS bevorzugt nach Job #0)
- [ ] **Persona-Dokumente** für jeden Bot erstellen (Rollen, Tools, Ausschlüsse)
- [ ] **Wissen einspeisen** (1. Konversation pro Bot mit Domänenwissen)
- [ ] **Erste echte Fragen** testen (Aero: „vergleich 4 Profile", Regulatory: „was gilt für 16 kg in DE?")

### Laufende Aufgaben
- [x] **SSH-Tunnel auf PC automatisieren** (Scheduled Task) — `Hermes-Tunnel-Auto.bat` getestet, Port 32769 erkannt, Tunnel steht auf :8080, HTTP 302 von Hermes-UI. Scheduled-Task noch manuell anzulegen.
- [x] **Telegram-Bot** vollständig testen (mehrere Nachrichten senden) — Test-Nachrichten bestätigt
- [x] **Memory-Persistenz** testen — Ergebnis dokumentiert, Befund: Repo-Dateien bevorzugen
- [x] **Memory konsolidieren** (24.09.2026) — von 4.252/2.200 (193 %) auf 1.545/2.200 (70 %); Detail-Wissen in `01_Dokumentation/Projekt-Memory.md` ausgelagert
- [x] **Themenchat-Setup-Files anlegen** (24.09.2026) — 6 Setup-Markdown-Files + README in `01_Dokumentation/Chat-Setups/` (Commit `8918185`)
- [ ] **Themenchats in Hermes-Desktop anlegen** — manuell via UI (siehe `Chat-Setups/README.md`): 🧠 Strategie, 🏗️ Infra, 🪶 Aerodynamik, ⚙️ Tech, 📜 Regulatorik, 🛒 Vermarktung
- [ ] **Telegram ↔ GitHub Connection einrichten** — Skript + Sidecar-Bot deployed. Wartet auf (a) GitHub-PAT in `/opt/data/.env` und (b) `systemctl enable hermes-telegram-sidecar`

---

## 🟠 VPS & Infrastruktur (Hostinger KVM 1)

- [x] VPS bestellt + bereitgestellt (2026-09-22)
- [x] SSH-Key generiert + hinterlegt
- [x] VPS gehärtet (Bootstrap, harden_ssh, setup_firewall)
- [x] Hermes-Agent läuft
- [x] MiniMax M3 OAuth eingerichtet
- [x] Telegram-Bot aktiv
- [x] Tool-Whitelist gesetzt (computer_use aus)
- [x] Cron: Health-Monitor (jede Stunde)
- [x] Cron: Backup (täglich 03:00 UTC)
- [x] Cron: Update-Check (täglich 04:00 UTC)
- [x] Backup-Strategie mit Retention
- [ ] Traefik + HTTPS + eigene Domain (für öffentlichen Zugang)
- [ ] Watchtower oder Alternative für Container-Auto-Updates
- [ ] Caddy/Nginx als zweiter Reverse-Proxy für Performance

---

## 🟡 Hermes-Setup & Tools

- [x] Hermes-Desktop-App auf Laptop installiert
- [x] Laptop-Login via Nous-Portal-Account
- [x] MiniMax-OAuth auf Laptop aktiv
- [x] SSH-Keys auf Laptop kopiert
- [x] SSH-Config auf PC + Laptop mit Port 32768
- [ ] SSH-Tunnel als Scheduled Task auf Laptop (analog zu PC)
- [ ] Memory-Tools aktivieren (was soll sich Hermes merken?)
- [ ] Skill: „vtol-experte" erstellen (sammelt Domänenwissen)

---

## 🟢 VTOL-Design (laufendes Projekt)

### Aerodynamik
- [ ] **Profil-Vergleich** mit XFLR5: Wortmann FX 63-137 vs. NACA 4412 vs. Eppler 423
- [ ] **OpenVSP-Modell** aufbauen (Flügel + Rumpf + Ausleger)
- [ ] **Polaren-Berechnung** für 4 Profile (CL, CD, CM bei Re=300000)
- [ ] **Stall-Verhalten** dokumentieren
- [ ] **Böen-Lasten** nach ECS / DIN 8947

### Struktur (CFK)
- [ ] **Materialauswahl** T800 vs. T700 vs. M40J (Festigkeit/Gewicht/Kosten)
- [ ] **Laminat-Aufbau** definieren (Biax/Unidirectional-Verhältnis)
- [ ] **Holm-Dimensionierung** (statische + dynamische Lasten)
- [ ] **Rippen-Layout** (CNC-Fräsplan)
- [ ] **Schalenformen** (3D-Druck-Plan)
- [ ] **FEM-Analyse** mit Fusion 360 oder ANSYS

### Antrieb
- [ ] **Motor-Auswahl** final (T-Motor P60 KV170 vs. MN501-S KV340 vs. KDE)
- [ ] **Propeller-Dimensionierung** (15×8 Klappprop?)
- [ ] **Akku-Konfiguration** final (14S3P vs. 14S4P, Molicel P45B vs. Samsung 40T)
- [ ] **ESC-Auslegung** (40A vs. 60A, BLHeli-32 vs. KISS)
- [ ] **Reichweiten-Berechnung** (effektiver Verbrauch, Reserve)

### Avionik & Software
- [ ] **Flight-Stack-Entscheidung** (PX4 vs. ArduPilot)
- [ ] **Companion-PC-Auswahl** (NVIDIA Jetson Orin NX 16GB)
- [ ] **KI-Modell** für Object-Detection (YOLOv8?)
- [ ] **MAVLink-Routing** (QGroundControl ↔ Companion)
- [ ] **Telemetrie-Cloud** (an VPS anbinden)

### Payload-Module
- [ ] **M1 SAR-Modul** (Thermal, Personenerkennung)
- [ ] **M2 Wildschutz-Modul** (Multispektral, Tiererkennung)
- [ ] **M3 Behörden-Modul** (Kamera + LiDAR)
- [ ] **M4 Vermessungs-Modul** (RTK-GPS, Photogrammetrie)
- [ ] **Universal-Container** (austauschbar, Schnellverschluss)

---

## 🔵 Regulatorik & Zulassung (für Regulatory-Bot)

### EU (EASA)
- [ ] **Drohnenklassen** (C0-C6) und Pflichten
- [ ] **MTOM-Klassifizierung** (aktuell 16 kg → Kategorie „offen" oder „speziell"?)
- [ ] **SORA-Pfad** (Specific Operations Risk Assessment)
- [ ] **OSO-Anforderungen** (Operational Safety Objectives)
- [ ] **Pilotenlizenzen** (A1/A3, A2, STS)
- [ ] **Versicherungs-Pflichten**

### USA (FAA)
- [ ] **Part 107** (Commercial Drone Operations)
- [ ] **Remote ID** (Compliance ab 2023)
- [ ] **Waivers** (für BVLOS, Nacht, Personen)
- [ ] **LAANC** (Low Altitude Authorization)

### International
- [ ] **Versicherungs-Vergleich** (HDI, Allianz, Drone-Guard)
- [ ] **Export-Kontrolle** (falls Komponenten aus USA)

---

## 🟣 Doku & Repo

- [x] Lastenheft v1.1 (MTOM 16 kg, Payload 2,28 kg, Schwebeschub-Faktor 2,10×)
- [x] Repo-Struktur (13 Verzeichnisse)
- [x] GitHub Actions (markdown-lint, lastenheft-validator)
- [ ] **Privates Repo `Hermes-VTOL-CAD` einrichten** — Hybrid-Strategie: STEP/STL/G-Code hier, .f3d-Originale in Fusion-Cloud. Erstellt 2026-09-22.
- [ ] **Erste CAD-Exporte** aus Fusion 360 (Tragflügel-Rumpf als Test-Exports) — sobald CAD-Modell fertig
- [ ] **CAD-Versions-Konventionen** im VERSIONS.md des privaten Repos dokumentiert
- [ ] **CAD-Modell** (Fusion 360) als STEP + STL in `03_CAD/`
- [ ] **FEM-Ergebnisse** (Statik, Mode-Shapes) in `04_FEM_Simulation/`
- [ ] **Test-Protokolle** (Bodentests, Flugtests) in `07_Tests/`
- [ ] **Bilder & Renderings** in `11_Bilder_Renderings/`
- [ ] **Drohnenklasse-Doku** (vollständige EU/US-Vorschriften) in `09_Regulatorik/`

---

## ⚪️ Ideen-Pool (nicht eilig)

- Hermes-VPS als **MAVLink-Router** für Live-Telemetrie
- **Web-UI-Theme** customizen (VTOL-Branding)
- **Discord-Bot** als Alternative zu Telegram (Community)
- **Telegram-Bot-Skills**: Skills automatisch bei wichtigen Events triggern
- **VTOL-3D-Modell** als interaktive WebGL-Ansicht
- **Open-Source-Veröffentlichung** von Teilen (CFK-Recipes, Software)

---

## 📊 Status-Übersicht

| Bereich | Erledigt | Offen | Total |
|---------|----------|-------|-------|
| VPS & Infrastruktur | 11 | 3 | 14 |
| Hermes-Setup | 5 | 3 | 8 |
| VTOL-Design | 0 | 26 | 26 |
| Regulatorik | 0 | 11 | 11 |
| Doku & Repo | 3 | 5 | 8 |
| Ideen-Pool | 0 | 6 | 6 |
| **Total** | **19** | **54** | **73** |

---

| 2026-09-23 21:46 UTC | Via Telegram: Telegram-Sidecar-Test: erfolgreich gepusht um $(date +%H:%M) |

| 2026-09-23 21:50 UTC | Via Telegram: Telegram-Sidecar LIVE-TEST (Token jetzt mit Contents:write) |

## 📅 Chronik

| Datum | Was hinzugefügt wurde |
|---
| 2026-09-23 21:57 UTC | Via Telegram: sidecar-live-test (Pipeline-check vom handy) |
| 2026-09-23 21:57 UTC | Via Telegram: sidecar-live-test (Pipeline-check vom handy) |
| 2026-09-23 21:57 UTC | Via Telegram: sidecar-live-test (Pipeline-check vom handy) |
| 2026-09-23 21:51 UTC | Via Telegram: Telegram-Sidecar FINAL-TEST: Trenner intakt, Zeile in Chronik-Tabelle |
| 2026-09-24 | **Memory konsolidiert** (4.252→1.545 Zeichen, 70 %) + **Projekt-Memory.md angelegt** als ausgelagertes Detail-Wissen |
| 2026-09-24 | **6 Themenchat-Setup-Files angelegt** in `01_Dokumentation/Chat-Setups/` (Strategie, Aerodynamik, Tech-Stack, Regulatorik, Vermarktung, Infra) + README |
| 2026-09-24 | Offene Aufgabe: Themenchats in Hermes-Desktop anlegen (manuell via UI) |
| 2026-09-22 | Job #1 hinzugefügt: Aero-Wing-Bot + Regulatory-Bot erstellen |
| 2026-09-22 | Telegram ↔ GitHub Connection als laufende Aufgabe hinzugefügt (Falscheintrag CAD-Modell-Rebuild korrigiert) |
| 2026-09-22 | **Job #0 ganz oben hinzugefügt: Komplett auf VPS umstellen (SECURITY)** — wegen Containment-Argument: Agent-Bugs dürfen nie dein lokales System betreffen |

---

> **Hinweis:** Diese Datei wird **automatisch per Chat aktualisiert**, wenn du „speichere XYZ für später" sagst. Du kannst sie auch manuell editieren oder ich tue es auf Zuruf.
