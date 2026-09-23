# Memory-Persistenz-Test — Ergebnisprotokoll

**Datum:** 2026-09-23 (Mittwoch-Nacht, MESZ)
**Tester:** testbot (testbot-Profil, lokal)
**Methode:** Zwei-Wege-Test — (a) Subagent-Isolation, (b) Parent-Session

---

## Test-Methode (a): Subagent-Isolation

**Versuch:** Einen Subagent (`delegate_task`) beauftragen, 3 Memory-Einträge via `memory()` zu schreiben.

**Ergebnis:** ❌ **Fehlgeschlagen**

**Befund (vom Subagent dokumentiert):**
- `memory`-Tool ist in Subagent-Sessions **nicht verfügbar** — weder als top-level tool, noch über `tool_search`/`tool_describe`/`tool_call` (alle 15 deferred-Kataloge geprüft), noch über `hermes_tools`-Python-Modul
- Bestätigt durch `import hermes_tools as ht; print(sorted([n for n in dir(ht) if not n.startswith('_')]))` → Liste enthält **kein** `memory` oder `skills_list`
- Auch `skills_list` ist in Subagent-Sessions nicht verfügbar
- Nur diese Tools sind im Subagent verfügbar: `terminal`, `tool_search`, `tool_describe`, `tool_call`, `execute_code`, `read_file`, `write_file`, `patch`, `search_files`, `web_search`, `web_extract`, `browser_*`, `vision_analyze`, `text_to_speech`

**Konsequenz:**
- Memory-Persistenz kann nur in der **Parent-Session** getestet werden
- Subagent-Tasks können keine persistenten Notizen für die Zukunft hinterlassen
- Persistente Findings müssen via `write_file` ins Repo oder via `delegate_task(action='spawn')` mit explizitem Output-to-Repo-Pfad festgehalten werden

---

## Test-Methode (b): Parent-Session direkt

**Versuch:** In der Parent-Session direkt via `memory()` einen Test-Marker setzen.

**Ergebnis:** ❌ **Schon der add()-Call scheitert** — `Memory at 4,252/2,200 chars. Adding this entry would exceed the limit.`

**Befund:**
- Aktuelles Memory-Budget: **4.252/2.200** (also bereits **193% überfüllt**)
- Mehrere redundante Einträge (VPS-Port-Info 2× vorhanden, Cronjob-Stand veraltet mit nur 5 Jobs statt aktuell 11, Sicherheits-Containment doppelt mit Projekt-Todo-Liste)
- Die "Persistenz" der Memory scheitert schon am Speicherplatz, bevor ein neuer Test-Marker überhaupt gespeichert werden könnte

**Konsequenz:**
- Memory braucht dringend eine **Konsolidierung** — siehe `01_Dokumentation/Todos/Todo-Liste.md` Abschnitt "🟠 VPS & Infrastruktur"
- Empfehlung: In einer ruhigen Minute alle Einträge auf das Wesentliche reduzieren (Ziel: <1.500/2.200 Zeichen)

---

## Was bedeutet das für die offene Todo-Aufgabe?

> **Aufgabe in Todo-Liste:** "Memory-Persistenz testen: Erinnerung geben, neuen Tab öffnen, prüfen"

**Status:** ⚠️ **Teilweise getestet, Ergebnis besorgniserregend**

| Erwartet | Realität |
|---|---|
| Erinnerung in neuem Tab sichtbar | Theoretisch ja — aber `memory()` ist in Subagent-Sessions **nicht verfügbar**; in Parent-Sessions schon, aber **Speicher voll** |
| Persistente Notizen über Session-Grenzen | Nur über **Repo-Dateien** zuverlässig (`01_Dokumentation/Protokolle/`, Todo-Liste) — Memory nicht |
| Empfehlung | **Repo-Dateien bevorzugen** für alle persistenten Notizen. Memory nur für sehr kurze, hochrelevante Fakten (Ziel <50% Auslastung) |

---

## Action Items daraus

1. ⏳ **Memory konsolidieren** (nächste ruhige Minute)
   - VPS-Port-Info: nur 1× behalten (im Haupt-VPS-Block)
   - Cronjobs: 11 statt 5, aktualisieren
   - Sicherheits-Containment: mit Todo-Job #0 zusammenführen
   - Telegram-Bot-Detail: kann weg, da in Cronjobs referenziert
2. ⏳ **Aktuelle Memory-Größe überwachen** — Auslastung nicht über 80% ansteigen lassen
3. ✅ **Skill `vtol-experte` angelegt** (parallel erledigt) — bessere Domänenwissen-Quelle als Memory
4. ✅ **Telegram-Connector aktiviert** — persistente Updates via Repo-Datei statt Memory

---

## Lessons Learned (für künftige Sessions)

> **Persistenz-Regel für Hermes-VTOL:**
> Für dauerhafte Notizen → **immer Repo-Dateien** (Todo-Liste, Protokolle, Skill-Dateien). Memory ist nur für kurze, hochrelevante Fakten, die in jede Session müssen.
>
> **Subagent-Limitation:**
> `memory()`-Tool ist in `delegate_task`-Subagent-Sessions nicht verfügbar. Wenn ein Subagent etwas Persistentes hinterlassen soll, muss er es als Datei ins Repo schreiben oder als finalen summary zurückgeben.
