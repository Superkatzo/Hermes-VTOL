# 02_Aerodynamik

Aerodynamische Analyse und Modellbildung.

## Inhalt

| Ordner | Zweck |
|--------|-------|
| **XFLR5_Profile/** | Profil-Koordinaten (.dat) für Wortmann FX 63-137, Vergleichsprofile |
| **XFLR5_Polaren/** | XFLR5-Polaren-Analysen (Cl/Cd/Cm über alpha bei verschiedenen Re) |
| **OpenVSP_Modell/** | OpenVSP-Modell-Dateien (.vsp3) für das Gesamtdrohnen-Modell |
| **OpenVSP_Analysen/** | VSPAERO-Ergebnisse (Stability, Control, Surface-Autorität) |

## Workflow

1. **Profil-Auswahl:** XFLR5-Polaren für Re=300.000 berechnen
2. **3D-Analyse:** Profil-Polaren in OpenVSP-Modell einspeisen
3. **Stabilität:** VSPAERO-Cma vs. alpha, Neutralpunkt-Bestimmung
4. **Validierung:** Vergleich mit empirischen Werten (UIUC-Datenbank)

## Aktive Profile

- **Wortmann FX 63-137** (Hauptwahl für Flügel)
- Vergleich: NACA 4412 mod. (Fallback), MH 114 (Alternative)
