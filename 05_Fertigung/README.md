# 05_Fertigung

CNC-Fräsung, 3D-Druck, CFK-Layup und alle Herstellungs-Workflows.

## Inhalt

| Ordner | Zweck |
| -------- | ------- |
| **CNC_Fräsen/** | G-Code-Programme für Spanten, Mittelstück, Container (Fusion-CAM-Output) |
| **3D_Druck/** | STL/Slicer-Profile für Formen-Innenschalen, Kleinteile |
| **Sandwich_Formen/** | Negativformen für Vakuuminfusion (SLA-gedruckt) |
| **Layup_Schedules/** | Layup-Pläne pro Bauteil (Schichtenfolge, Klebepunkte) |
| **Materialliste/** | BOM (Bill of Materials), Lieferanten-Übersicht |

## Fertigungs-Pipeline

```text
CAD-Modell (.step)
        │
        ▼
Fusion 360 CAM
        │
        ├──▶ CNC-Programm (.nc, .gcode)
        │       │
        │       ▼
        │   CNC-Fräse (Spanten, Mittelstück)
        │
        └──▶ STL-Export
                │
                ▼
            SLA/MSLA-Druck (Formen)
                │
                ▼
            Layup (CFK-Prepregs + Airex-Kern)
                │
                ▼
            Vakuuminfusion
                │
                ▼
            Aushärtung (Ofen oder RT)
                │
                ▼
            Endbearbeitung (Trimmen, Schleifen)
                │
                ▼
            Montage
```text
