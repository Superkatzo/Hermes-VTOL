# 12_Skripte_Tools

Hilfsskripte für Aerodynamik, Energie-Simulation und CAD-Automatisierung.

## Inhalt

| Ordner | Zweck |
| -------- | ------- |
| **Python_Simulationen/** | Energie-Bilanz, Flug-Simulation, Transition-Validierung |
| **OpenVSP_Batch/** | OpenVSP-CLI-Batch-Runs, VSPAERO-Sweeps |
| **CAD_Makros/** | Fusion-360-API-Skripte (Python), CAM-Automatisierung |

## Geplante Skripte

| Skript | Zweck |
| -------- | ------- |
| `energie_sim.py` | Endurance + Reichweite aus MTOM, L/D, Akku-Kapazität |
| `transition_sim.py` | Transition Fixed-Wing ↔ Multirotor (PX4-Parameter-Tuning) |
| `vsp_sweep.py` | OpenVSP-Batch: Variation von Anstellwinkel, Höhe |
| `cad_mass_props.py` | Fusion-360-API: Masse-Eigenschaften automatisch extrahieren |
| `gcode_check.py` | G-Code-Validierung (Werkzeugwege, Vorschub) |
