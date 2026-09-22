# Profil-Analyse — Flügelkandidaten für Hermes-VTOL

**Erstellt:** analyze_profiles.py

## Übersicht

| Profil | Datei | Punkte | max Dicke [%] | bei x [%] | max Wölbung [%] | bei x [%] | LE-Radius | TE-Dicke [%] |
|--------|-------|--------|---------------|-----------|------------------|-----------|-----------|---------------|
| **E423** | `eppler423.dat` | 71 | 11.78 | 14.0 | 5.81 | 14.0 | 0.005 | 0.0 |
| **WORTMANN FX 63-137 AIRFOIL** | `fx63137.dat` | 97 | 13.71 | 31.0 | 5.85 | 46.0 | 0.011 | 0 |
| **MH 114  13.02%** | `mh114.dat` | 67 | 13.06 | 30.0 | 6.13 | 33.0 | 0.005 | 0.0 |
| **NACA 4412** | `naca4412.dat` | 35 | 12.02 | 30.0 | 4.0 | 40.0 | 0.03 | 0.26 |

## Empfehlung

**Hauptkandidat:** Wortmann FX 63-137 — bewährt im Re-Bereich 250.000–400.000, sehr gute Stall-Charakteristik.

**Vergleich:** NACA 4412 als konservativer Fallback. Eppler 423 und MH 114 als Alternativen bei abweichenden Anforderungen.

## Nächste Schritte

1. Polaren-Berechnung (Cl/Cd über alpha) bei Re=250k, 300k, 350k
2. Vergleich von L/D_max und Stall-Winkel
3. Auswahl des finalen Profils
4. 3D-Flügel-Analyse in OpenVSP
