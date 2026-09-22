# XFLR5-Profile (UIUC-Datenbank)

Profil-Koordinaten für XFLR5- und OpenVSP-Analysen.

## Herkunft

Alle Profile stammen aus der **UIUC Airfoil Coordinates Database** (Prof. Michael Selig, University of Illinois):
- Quelle: https://m-selig.ae.illinois.edu/ads/coord_database.html
- Lizenz: Public Domain (Forschungsdaten, frei verfügbar)
- Format: Selig-Format (Standard `.dat`)

## Verfügbare Profile

| Datei | Profil | max Dicke | max Wölbung | Reynolds-Optimum | Bemerkung |
|-------|--------|-----------|-------------|-------------------|-----------|
| `fx63137.dat` | **Wortmann FX 63-137** | 13,7 % | 6,0 % | 250.000–400.000 | **Hauptwahl** für Flügel |
| `naca4412.dat` | NACA 4412 | 12 % | 4 % | 100.000–1.000.000 | Standard-Fallback |
| `eppler423.dat` | Eppler 423 | ~12,5 % | ~3,5 % | 200.000–500.000 | Sehr gutes L/D |
| `mh114.dat` | MH 114 (Martin Hepperle) | 13,02 % | ~3 % | 200.000–400.000 | Gutmütige Stall-Charakteristik |

## Verwendung in XFLR5

1. **Datei → Open** → `*.dat` auswählen
2. Re=300.000 für Standard-Reiseflug einstellen
3. **Analyse → Polar** → `Type 1` (fixe Auftrieb) oder `Type 2` (fixer Anstellwinkel)
4. Alpha-Sweep: -5° bis +15°
5. Iterationszahl: 250

## Verwendung in OpenVSP

1. **Geometry → Wing → Section → Airfoil**
2. **Custom Airfoil** auswählen
3. Datei-Pfad zum `.dat` angeben
4. Polar-Datei später über **VSPAERO** berechnen

## Reihenfolge der Profil-Analyse

1. **Wortmann FX 63-137** (Hauptwahl) → Polare bei Re=300k
2. **NACA 4412** (Fallback) → Vergleich
3. **Eppler 423** → Vergleich bei höherem Re
4. **MH 114** → Vergleich bei Stall-Verhalten

## Quellen-Übersicht

- **Wortmann FX 63-137:** Entwickelt für Human-Power-Aircraft (Puffin II / Liverpuffin), sehr gut im Low-Re-Bereich
- **NACA 4412:** Klassisches 4-stelliges NACA-Profil, Standard für allgemeine Anwendungen
- **Eppler 423:** Prof. Richard Eppler, optimiert für Modellflugzeuge
- **MH 114:** Martin Hepperle, moderne Auslegung für UAV/Modellbau

## Nächste Schritte

Nach den Profilen folgt:
- Polaren-Berechnung (Cl/Cd über alpha) bei Re=250k, 300k, 350k
- 3D-Flügel-Analyse in OpenVSP mit LLT-Methode
- Vergleich der Profile im Markdown-Bericht
