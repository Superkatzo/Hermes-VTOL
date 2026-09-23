# Themenchats — Setup-Anleitung

> **Zweck:** Statt eines einzigen Mega-Chats, der mit der Zeit instabil wird, arbeitest du in **6 themen-basierten Chats**. Jeder hat ein vorbereitetes Setup-File.

## Die 6 Chats

| # | Datei | Thema | Wann rein |
|---|---|---|---|
| 0 | [`00-Strategie-Planung.md`](./00-Strategie-Planung.md) | 🧠 **Dirigent** — Wochenrückblick, Priorisierung, Architektur-Entscheidungen, Bot-Team-Setup | 1× pro Woche, oder bei großen Entscheidungen |
| 1 | [`01-Aerodynamik.md`](./01-Aerodynamik.md) | 🪶 Profil-Auswahl, Polaren, OpenVSP, Stall, Böen | Wenn du am Flügel arbeitest |
| 2 | [`02-Tech-Stack-Mechanik.md`](./02-Tech-Stack-Mechanik.md) | ⚙️ CAD, CFK, FEM, Antrieb, Avionik, Payload | Wenn du an Hardware/Software arbeitest |
| 3 | [`03-Regulatorik-CE.md`](./03-Regulatorik-CE.md) | 📜 EASA, CE, SORA, FAA, Pilot-Lizenzen, Versicherung | Wenn du Behörden-/Verkaufsthemen klären musst |
| 4 | [`04-Vermarktung-Produkthaftung.md`](./04-Vermarktung-Produkthaftung.md) | 🛒 Käufer-Persona, Pricing, Marketing-Material | Wenn du an Verkaufs-/Marketing-Sachen arbeitest |
| 5 | [`05-Infra-DevOps.md`](./05-Infra-DevOps.md) | 🏗️ VPS, Cron, Telegram, Git, Bug, Containment | Wenn du an Server-Setup/Pipeline arbeitest |

---

## So legst du einen neuen Chat an

### Schritt 1: Im Hermes-Desktop neuen Tab öffnen
- Sidebar → `+ New Chat` (oder Tastenkürzel, je nach Version)
- **Erste Nachricht = Setup-Text** aus dem jeweiligen `.md`

### Schritt 2: Setup-Text reinkopieren
Öffne die `.md`-Datei in deinem Editor, **kopiere den kompletten Inhalt ab „Du bist jetzt im Themenchat…"**, und füge ihn als **erste Nachricht** in den neuen Chat ein.

Der Bot liest dann den Text, lädt `01_Dokumentation/Projekt-Memory.md`, und ist betriebsbereit.

### Schritt 3: Brücke schlagen (optional aber empfohlen)
Wenn du aus einem anderen Themenchat rüber willst, sag dem neuen Chat:
> „Brücke aus Themenchat [Name]: wir hatten entschieden, dass X. Lade bitte `01_Dokumentation/Projekt-Memory.md` und lies kurz die letzten Commits im betroffenen Bereich."

---

## Reihenfolge zum Aufsetzen (heute)

Du brauchst nicht alle 6 heute. Empfohlene Reihenfolge nach Dringlichkeit:

1. **🧠 Strategie & Planung** (`00`) — der Dirigent, hier fängst du normalerweise an
2. **🏗️ Infra & DevOps** (`05`) — wenn du den Bug noch fixen oder Containment weitertreiben willst
3. **🪶 Aerodynamik** (`01`) — wenn du am Profil-Vergleich weiterarbeiten willst
4. **⚙️ Tech-Stack** (`02`) — wenn du am CAD/Antrieb weiterarbeiten willst
5. **📜 Regulatorik** (`03`) — wenn du CE/SORA vorbereiten willst
6. **🛒 Vermarktung** (`04`) — für den späteren Verkaufsaufbau

---

## Brücke zwischen den Chats: Die Todo-Liste

Die **`01_Dokumentation/Todos/Todo-Liste.md`** ist die **Wahrheit** zwischen den Chats. Jeder Bot liest sie am Anfang und ergänzt sie am Ende. Wenn du in einem Chat eine Entscheidung triffst, soll er:

1. Eintrag in Todo-Liste (Chronik-Zeile)
2. Commit + Push
3. Im Strategie-Chat im nächsten Rückblick erwähnen

---

## Memory- & Persistenz-Regel (für alle Bots gleich)

- **Hermes-Memory** = nur Quick-Reference (VPS-IP, Hard-Rules, Containment-Ziel) → wird von Hermes automatisch geladen
- **Repo-Datei `Projekt-Memory.md`** = alles Detaillierte → bei jedem Chat-Start einmal manuell oder per Bot laden
- **Subagent-Sessions** haben kein `memory()` und kein `skills_list` → Persistenz nur via Repo oder finalem Summary

---

## Pflege der Setup-Files

Wenn sich etwas Grundsätzliches ändert (neuer Bot, neues Tool, neue Strategie), bitte **die Setup-Files updaten und committen**, nicht nur im Chat erwähnen. So überleben sie auch, wenn ein Bot „den Kontext verliert".

## Chronik

| Datum | Änderung |
|---|---|
| 2026-09-24 | Initiale 6 Setup-Files + diese Anleitung angelegt |
