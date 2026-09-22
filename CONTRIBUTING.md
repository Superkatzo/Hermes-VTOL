# Contributing — Hermes-VTOL

Danke für dein Interesse am Hermes-VTOL-Projekt! Dieses Dokument beschreibt die Konventionen für Beiträge.

## Branch-Strategie

| Branch | Zweck |
|--------|-------|
| `main` | Stabile, freigegebene Versionen (nur über PR) |
| `dev` | Aktive Entwicklung |
| `feature/<name>` | Neue Features / Designänderungen |
| `bugfix/<name>` | Fehlerbehebungen |
| `docs/<name>` | Reine Dokumentations-Änderungen |

## Commit-Konvention (Conventional Commits)

```
<typ>(<scope>): <beschreibung>

[optional Body]

[optional Footer]
```

**Typen:**

| Typ | Zweck |
|-----|-------|
| `feat` | Neues Feature |
| `fix` | Fehlerbehebung |
| `docs` | Nur Dokumentation |
| `style` | Formatierung (kein Code-Change) |
| `refactor` | Code-Umstrukturierung |
| `test` | Tests hinzufügen/ändern |
| `chore` | Build, Tools, Hilfsmittel |

**Beispiele:**
- `feat(lastenheft): add SORA section`
- `fix(aerodynamik): correct polar data for Re=300k`
- `docs(readme): update status table`

## Naming-Konventionen

- **Dateien (Markdown):** `Kebab-Case.md` oder `Pascal-Case.md`
- **CAD-Versionen:** `<Komponente>_v<MAJOR>.<MINOR>_<YYYY-MM-DD>.step`
- **Bilder:** `<Komponente>_<Winkel>_<YYYY-MM-DD>.png`
- **Python-Skripte:** `snake_case.py`

## Was niemals committed wird

- G-Code / Maschinen-Programme (.nc, .gcode) → aus CAM regenerieren
- STL-Dateien für 3D-Druck → aus CAD regenerieren
- Lokale Cache-Dateien (.f3d Caches, OpenVSP-Temps)
- Persönliche Daten / Tokens / Schlüssel

→ Steht alles in `.gitignore` — wenn etwas durchrutscht: `git rm --cached <datei>`

## Review-Prozess

1. PR erstellen mit aussagekräftiger Beschreibung
2. CI-Pipeline muss grün sein (Markdown-Lint, Lastenheft-Validator)
3. Mindestens ein Review (oder Selbstanmerkungen) für nicht-triviale Änderungen
4. Squash-Merge in `main`

## Lokale Entwicklung

```bash
# Clone
git clone https://github.com/Superkatzo/Hermes-VTOL.git
cd Hermes-VTOL

# Neuer Branch
git checkout -b feature/mein-feature

# Änderungen machen
# ...

# Validierung lokal
# (CI läuft auch nach push)
git add .
git commit -m "feat(scope): beschreibung"
git push origin feature/mein-feature
```

## Kontakt

Bei Fragen: Issue erstellen oder @Superkatzo direkt ansprechen.
