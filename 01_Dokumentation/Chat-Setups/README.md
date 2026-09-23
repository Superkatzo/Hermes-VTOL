# Themenchats — Setup-Anleitung (2-Chat-Struktur)

> **Zweck:** Du arbeitest in **2 themen-basierten Chats**, jeweils an unterschiedlichen Workspaces verankert. Das ist einfacher als 6 Mini-Chats und passt zur natürlichen Arbeitsteilung: **Bauen** vs. **Planen & Verkaufen**.

## Die 2 Chats

| # | Datei | Thema | Workspace |
|---|---|---|---|
| 1 | [`NEU-01-Technik-Hardware.md`](./NEU-01-Technik-Hardware.md) | 🛠️ **Technik & Hardware** — Aerodynamik, CAD, CFK, FEM, Antrieb, Avionik, Payload | `VTOL-Projekt` (Repo-Root) |
| 2 | [`NEU-02-Strategie-Umfeld.md`](./NEU-02-Strategie-Umfeld.md) | 🧠 **Strategie & Umfeld** — Strategie, Regulatorik, CE, Vermarktung, Infra | `VTOL-Doku` (`01_Dokumentation/`) |

---

## So legst du die 2 neuen Chats an

### Chat 1: 🛠️ Technik & Hardware
1. Workspace `VTOL-Projekt` aktivieren
2. `+ New Chat`
3. Inhalt aus `NEU-01-Technik-Hardware.md` ab **„Du bist jetzt im Technik & Hardware-Chat …"** reinkopieren
4. Erste Frage: „Hallo Technik-Bot, lies den Stand aus Projekt-Memory.md nach. Was steht heute an?"

### Chat 2: 🧠 Strategie & Umfeld
1. Workspace `VTOL-Doku` aktivieren
2. `+ New Chat`
3. Inhalt aus `NEU-02-Strategie-Umfeld.md` ab **„Du bist jetzt im Strategie & Umfeld-Chat …"** reinkopieren
4. Erste Frage: „Hallo Strategie-Bot, lies den Stand aus Projekt-Memory.md + Todo-Liste nach. Wo stehen wir?"

---

## Wann welcher Chat?

### 🛠️ Technik & Hardware
- Profil-Vergleich / Polaren rechnen
- OpenVSP-Modell aufbauen
- CAD in Fusion 360
- FEM-Mesh & Lastanalyse
- Motor/Prop/Akku auswählen
- PX4/ArduPilot konfigurieren
- Payload-Module konstruieren
- **Alles, was eine Bauplan- oder Spec-Frage ist**

### 🧠 Strategie & Umfeld
- Wochenrückblick / Priorisierung
- SORA-Recherche / EASA-C3-Pfad
- ConOps-Vorlage für Käufer schreiben
- Marketing-Material / Website-Text
- VPS-Setup / Cronjob / Bug-Fix
- Bot-Team-Setup (aero-wing-bot, regulatory-bot)
- **Alles, was eine Entscheidungs- oder Doku-Frage ist**

---

## Brücke zwischen den Chats

Die **Todo-Liste** (`01_Dokumentation/Todos/Todo-Liste.md`) ist die Wahrheit zwischen den Chats.

Wenn der Strategie-Bot entscheidet „PX4 statt ArduPilot", schreibt er:
1. Eintrag in `Entscheidungen.md`
2. Eintrag in `Todo-Liste.md` (Chronik)
3. → Im nächsten Technik-Chat sagst du: „Brücke aus Strategie: wir haben auf PX4 entschieden. Lade `01_Dokumentation/Entscheidungen.md` und lies die letzte Entscheidung."

---

## Persistenz-Regel

- **Hermes-Memory** = nur Quick-Reference (VPS-IP, Hard-Rules, Containment-Ziel) → wird automatisch geladen
- **`01_Dokumentation/Projekt-Memory.md`** = alles Detaillierte → einmal pro Chat-Start laden lassen
- **Subagent-Sessions** haben kein `memory()` und kein `skills_list` → Persistenz nur via Repo oder finalem Summary

---

## Alte 6-Chat-Variante (archiviert)

Die alten `00–05` Setup-Files aus dem ersten Entwurf liegen noch im Repo und sind nicht gelöscht — sie können als Inspiration dienen, falls du später doch feiner trennen willst. Für den normalen Workflow reichen die 2 neuen Chats.

## Chronik

| Datum | Änderung |
|---|---|
| 2026-09-24 | Initiale 6 Themenchat-Setups + README angelegt |
| 2026-09-24 | **Überarbeitet auf 2-Chat-Struktur**: 🛠️ Technik & Hardware + 🧠 Strategie & Umfeld. Alte 6-Setups bleiben archiviert im Repo, README aktualisiert |
