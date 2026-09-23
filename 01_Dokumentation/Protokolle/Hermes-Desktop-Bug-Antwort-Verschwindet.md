# GitHub Issue: Antworten verschwinden nach Context-Compaction (256k Threshold)

## Zusammenfassung

Wenn eine Konversation den **256.000-Token-Threshold** überschreitet und Hermes eine **Context-Compaction** durchführt, **verschwindet die vorherige Antwort** komplett aus dem Chat-Verlauf. Die Antwort wurde noch kurz gerendert (mehrere Sekunden sichtbar), ist dann aber nach der Compaction weder sichtbar noch scrollbar.

## Reproduktion

### Schritte

1. Starte eine neue Konversation in der Hermes Desktop-App
2. Führe viele Tool-Calls durch, bis die Token-Anzahl ~256.000 erreicht (lange Recherche-Sessions, viele Datei-Edits, oder umfangreiche Codegenerierung)
3. Sobald Hermes eine Antwort generiert hat (mehrere KB groß)
4. Warte, bis die nächste Antwort generiert wird
5. **Beobachten:** Die in Schritt 3 generierte Antwort ist nach der Compaction **nicht mehr im Chat-Verlauf**

### Erwartetes Verhalten

Nach der Compaction sollte:
- Die vorherige Antwort weiterhin im Verlauf sichtbar sein (zusammengefasst oder gekürzt)
- ODER durch einen expliziten "Context wurde komprimiert"-Indikator ersetzt werden
- Mindestens: Der Summary der vorherigen Antwort sollte sichtbar sein

### Tatsächliches Verhalten

- Die vorherige Antwort wird für mehrere Sekunden korrekt gerendert
- Dann "verschwindet" sie plötzlich komplett
- Auch Hochscrollen zeigt die Antwort nicht mehr
- Die Antwort ist weder im aktuellen Chat-Verlauf noch über die Suche auffindbar

## Beweise (Logs)

Aus `C:/Users/willow/AppData/Local/hermes/logs/desktop.log`:

### Wiederkehrende Compaction-Events

```
[2026-09-22T19:17:59.817Z] [hermes] 📦 Preflight compression: ~256,029 tokens >= 256,000 threshold. This may take a moment.
[2026-09-22T19:17:59.824Z] [hermes] 🗜️ Compacting context — summarizing earlier conversation so I can continue...
[2026-09-22T19:39:41.822Z] [hermes] 📦 Preflight compression: ~256,029 tokens >= 256,000 threshold. This may take a moment.
[2026-09-22T19:39:41.822Z] [hermes] 🗜️ Compacting context — summarizing earlier conversation so I can continue...
[2026-09-23T18:40:43.930Z] [hermes] 📦 Preflight compression: ~256,516 tokens >= 256,000 threshold. This may take a moment.
[2026-09-23T18:40:43.936Z] [hermes] 🗜️ Compacting context — summarizing earlier conversation so I can continue...
[2026-09-23T18:41:43.953Z] [hermes] 🗜️ Compacting context — still summarizing earlier conversation so I can continue...
[2026-09-23T22:15:52.462Z] [hermes] 📦 Preflight compression: ~257,606 tokens >= 256,000 threshold. This may take a moment.
[2026-09-23T22:15:52.468Z] [hermes] 🗜️ Compacting context — summarizing earlier conversation so I can continue...
```

### Konkret: Verschwinden um 22:15:52

**Vor 22:15:52** (normale Tool-Calls): Antworten werden gerendert

**Um 22:15:52**: Compaction startet, 3-Minuten-Pause

```
22:15:52.462 → Preflight compression: ~257,606 tokens
22:15:52.468 → Compacting context — summarizing...
22:18:51.678 → (◔_◔) reflecting...   ← erste Antwort nach Compaction
```

**Diese 3-Min-Pause** (`22:15:52` → `22:18:51`) entspricht dem Zeitfenster, in dem die vorherige Antwort aus dem UI verschwand.

## Hypothese (Ursache)

Vermutlich ein **React/Vue-State-Update-Bug** in der Chat-UI:

1. **Vor Compaction:** Antwort wurde in den Chat-State eingefügt und gerendert
2. **Während Compaction:** Frontend versucht, die Konversation zu "kürzen" (z. B. ältere Messages collapsen, Summaries einfügen)
3. **State-Replacement-Bug:** Statt nur die **Zusammenfassung** zu zeigen, wird die **vorherige Antwort komplett aus dem State entfernt**
4. **Resultat:** Im Backend ist die Antwort noch da (Conversation-Log), im UI-State aber nicht

### Mögliche betroffene Codepfade

- `desktop/src/components/ChatView/...` (oder vergleichbar)
- `MessageList`-Rendering mit `useMemo` / `useEffect`-Dependency auf `messages.length`
- Optimistic UI Updates, die bei einer Compaction-Operation nicht zurückgerollt werden

## Workarounds

### Kurzfristig (für User)

1. **Antwort vor Compaction kopieren** — bei sehr langen Antworten `Ctrl+A` → `Ctrl+C` direkt nach dem Erscheinen
2. **Checkpoint-Files schreiben** — bei sensiblen Sessions regelmäßig den Stand in eine `.md`-Datei exportieren
3. **Neue Session starten** — wenn Compaction droht, alten Stand exportieren, neue Session beginnen

### Langfristig (Fix)

- **Compaction im UI transparent machen:** Statt Antwort zu ersetzen, als "Context-Compaction: [Summary]" markieren, Original erhalten
- **State-Reconciliation:** Wenn Backend-Antwort noch da ist, aber UI-State sie verloren hat, sollte UI sie wieder hydrieren
- **Persistenz:** Compaction-Summaries in `sessions/`-Verzeichnis speichern, beim nächsten Mount wiederherstellen

## Umgebung

- **Hermes Version:** Stand 2026-09-23 (Desktop-App, lokal auf Windows 11)
- **Provider:** MiniMax-M3 (modellseitig unerheblich, da UI-Bug)
- **Desktop-Log-Pfad:** `C:/Users/willow/AppData/Local/hermes/logs/desktop.log`
- **Compaction-Threshold:** 256.000 Tokens

## Impact

- **Severity:** Medium-High (Datenverlust aus User-Sicht)
- **Frequenz:** Bei langen Sessions (Tool-intensive Recherche, Code-Gen) regelmäßig
- **Workaround-Aufwand:** Mittel (User muss manuell exportieren)

## Zusätzliche Notizen

- **KEINE** Fehler im `errors.log` oder `desktop.log` während der Compaction-Events
- **`Compacting context — still summarizing...`**-Log-Eintrag existiert — das Compaction-UI selbst scheint zu funktionieren, nur das **vorherige Antwort-Rendering** wird zerstört
- Es scheint KEIN State-Rollback zu sein (Backend sollte die Antwort noch haben), eher ein **UI-State-Update-Bug**
