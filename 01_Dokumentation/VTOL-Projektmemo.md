# 🚁 VTOL-Projekt — Briefing-Memo

> **Kurzes Briefing** für den Wiedereinstieg nach Pausen.
> Stand: 2026-09-22 · Für Details: siehe Repo `Superkatzo/Hermes-VTOL`

---

## 1. Was ist das Projekt?

Zivile VTOL-Drohne (Quadplane, Pusher + 4 Hub) für **SAR + Behörden + Wildschutz + kommerzielle Inspektion**.
Einsatzraum: **Mitteleuropa / Deutschland** (Mischbetrieb urban/ländlich), regenresistent, Tag+Nacht, BVLOS-Hardware vorbereitet.

**Mission:** Austauschbarer Payload-Container macht die Plattform zum **„Pickup-Truck der Lüfte"** — ein Fluggerät, mehrere Missionen.

**Use-Cases (MVP):**

| Modul | Funktion |
|-------|----------|
| **M1 SAR** | Personensuche, Thermal-Kamera |
| **M2 Wildschutz** | Tier-Tracking, Wildzählung |
| **M3 Behörden** | Lagebilder, Einsatzdokumentation |
| **M4 Vermessung** | RTK-GPS, Photogrammetrie, Karten |

---

## 2. Wo stehen wir?

| Phase | Status | Datum |
|-------|--------|-------|
| **Lastenheft v1.1** | ✅ fertig | 2026-09-22 |
| **MTOM 16 kg, Payload 2,28 kg, Schwebeschub-Faktor 2,10×** | ✅ validiert | 2026-09-22 |
| **Profil-Recherche + Python-Analyse** | ✅ 4 Profile heruntergeladen (Wortmann FX 63-137 Favorit) | 2026-09-22 |
| **VPS-Setup (Hostinger KVM 1)** | ✅ produktiv mit MiniMax M3 | 2026-09-22 |
| **Telegram-Bot** | ✅ aktiv (vom Handy aus chatten) | 2026-09-22 |
| **Cron-Backup mit Retention (14 Tage)** | ✅ läuft täglich 03:00 / 03:30 UTC | 2026-09-22 |

**Was noch offen ist** (siehe Todo-Liste für Details):

- 🔴 Job #0: Komplett auf VPS umstellen (Security)
- 🟠 Job #1: Experten-Bots (Aero + Regulatory) erstellen
- 🟠 Telegram ↔ GitHub Connection (Todo-Liste per Handy pflegen)
- 🟢 Aerodynamik: XFLR5-Setup, OpenVSP-Modell, Polaren
- 🟢 Struktur: Materialauswahl (CFK), FEM-Simulation
- 🟢 Antrieb: Motor-Final, Akku-Konfiguration
- 🟢 Avionik: Flight-Stack (PX4 vs. ArduPilot)
- 🔵 Regulatorik: EU/EASA + USA/FAA + SORA-Doku

---

## 3. Wo lebt alles?

| Asset | Pfad |
|-------|------|
| **Repo (public)** | https://github.com/Superkatzo/Hermes-VTOL |
| **Lastenheft** | `01_Dokumentation/Lastenheft/Lastenheft-VTOL-Zivildrohne.md` |
| **Todo-Liste** | `01_Dokumentation/Todos/Todo-Liste.md` |
| **CAD (geplant)** | `03_CAD/` (Fusion 360 STEP/STL) |
| **FEM (geplant)** | `04_FEM_Simulation/` |
| **Python-Skripte** | `12_Skripte_Tools/` (z. B. `analyze_profiles.py`) |
| **VPS-Konfiguration** | `13_VPS_Config/` (Bootstrap, Hardening, Firewall, Backup-Skripte) |
| **Lokal (PC)** | `C:\Users\willow\Documents\Hermes-VTOL\` |
| **VPS (live)** | `srv1998925.hstgr.cloud` (Ubuntu 24.04, Hermes-Container) |

---

## 4. Kernzahlen (komprimiert)

| Größe | Wert |
|-------|------|
| **MTOM** | 16 kg |
| **Payload** | 2,28 kg |
| **Spannweite** | 2,30 m klappbar (≤ 2,40 m Transportmaß) |
| **Akku** | 14S Li-Ion (Molicel 21700 6500 mAh, ~325 Wh/kg) |
| **Schwebeschub-Faktor** | 2,10× |
| **Endurance** | 45–60 min |
| **Material** | CFK-Composite (T800 Standard-Modul, Biax + Unidirektional) |
| **Hub-Motor (in Eval)** | T-Motor P60 KV170 mit 22×6,6 (8,4 kg Schub) |
| **Flügelprofil** | Wortmann FX 63-137 (Favorit), Alternativen: NACA 4412, Eppler 423 |
| **CAD** | Fusion 360 (primär), Onshape (nur Ausnahmen) |

---

## 5. Wie du mit dem Projekt arbeitest

| Stil | Detail |
|------|--------|
| **Sprache** | Deutsch mit englischen Fachbegriffen |
| **Physik-Ansatz** | Realistisch, nicht optimistisch — Massen/Toleranzen mit echten Datenblättern |
| **Entscheidungen** | „Runde für Runde" mit a/b/c-Fragen; Empfehlungen als Default |
| **Modularität** | Liebt austauschbare Komponenten |
| **Reviews** | Korrigiert aktiv unsaubere Schätzungen |

---

## 6. Nächste sinnvolle Schritte

1. **Aerodynamik:** XFLR5 installieren, Profile testen, Polaren berechnen
2. **CAD:** Fusion-360-Modell aufbauen (vorher OpenVSP für Konzept)
3. **Material:** T800 vs. T700 vs. M40J entscheiden, CFK-Rezepte festlegen
4. **Antrieb:** Motor final auswählen, Akku-Konfiguration festlegen
5. **Struktur:** Holm/Rippen-Dimensionierung (statisch + dynamisch)
6. **Avionik:** Companion-PC (NVIDIA Jetson Orin NX 16GB), Flight-Stack (PX4/ArduPilot)

Details in der **Todo-Liste** (`01_Dokumentation/Todos/Todo-Liste.md`).

---

## 7. Dein Team

| Wer | Rolle |
|-----|-------|
| **Du** | „Dirigent" — entscheidest, koordinierst |
| **testbot (default)** | Hauptkonto für alles, koordiniert Experten-Bots |
| **aero-wing-bot (geplant)** | Spezialist für Aerodynamik + Profil-Design |
| **regulatory-bot (geplant)** | Spezialist für EU/US-Zulassung (SORA, EASA, FAA) |

Alle Bots laufen idealerweise **auf dem VPS** (Job #0 in Todo-Liste).

---

## 8. Was du heute Abend erreicht hast (zusammengefasst)

- ✅ VPS komplett produktiv (Hostinger KVM 1, DE)
- ✅ MiniMax M3 via OAuth eingebunden
- ✅ Telegram-Bot läuft 24/7
- ✅ Cron: Health-Monitor, Backup mit Retention, Update-Check
- ✅ Todo-Liste als lebendiges Projektgedächtnis (auf GitHub)
- ✅ Memory-Audit: alle relevanten Infos dauerhaft dokumentiert
- ✅ 73 Tasks erfasst, organisiert, priorisiert

**Damit ist das Fundament für die nächsten Wochen gesetzt.** 🚀

---

*Letzte Aktualisierung: 2026-09-22, nach Setup-Marathon.*
