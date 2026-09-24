# 03_CAD

3D-CAD-Modelle und Exports.

## Inhalt

| Ordner | Zweck | Versioniert? |
| -------- | ------- | -------------- |
| **Fusion360_Master/** | Originale Fusion-360-Dateien (.f3d, .f3z) | NEIN (in Git LFS) |
| **CAD_Exports_STEP/** | Neutrales CAD-Format für andere Tools | JA |
| **CAD_Exports_IGES/** | Älteres Neutralformat | JA |
| **CadFiles_Versioniert/** | Versionskontrollierte Modelle (z. B. STEP) | JA |

## Hauptmodell-Struktur (geplant)

```text
Hermes-VTOL.f3z (Master-Datei)
├── 01_Rumpf
├── 02_Fluegel_Links
├── 03_Fluegel_Rechts
├── 04_Winglets
├── 05_Hub_Ausleger
├── 06_Antriebs_Strang (Sub-Assembly: Motoren, ESCs, Props)
├── 07_Avionik (Sub-Assembly: Pixhawk, Jetson, GPS, Sensoren)
├── 08_Akkus (Sub-Assembly: Akku A + B, BMS, MOSFETs)
├── 09_Payload_Container
├── 10_Kleinteile (Schrauben, Buchsen, Klipse)
└── 11_Baugruppen (Master-Assembly)
```text

## Versions-Strategie

- `.f3d` und `.f3z` → in **Git LFS** (groß, binär, wenige Versionen)
- `.step` → versioniert in Git (klein, textbasiert, viele Versionen)
- Konvention: `<Komponente>_<Version>_<Datum>.<ext>` (z. B. `Rumpf_v0.3_2026-09-22.step`)
