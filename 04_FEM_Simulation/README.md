# 04_FEM_Simulation

Strukturelle Lastfälle und Finite-Elemente-Analysen.

## Inhalt

| Ordner | Zweck |
|--------|-------|
| **FEM_Reports/** | PDF-Reports der FEM-Analysen |
| **FEM_Models/** | Native Fusion-360-Simulations-Modelle |

## Lastfälle (gemäß Lastenheft Kapitel 5.1)

| Lastfall | Faktor | Status |
| ---------- | -------- | -------- |
| Manöver-Last positiv | +2,5 g | 🔜 offen |
| Manöver-Last negativ | −1,5 g | 🔜 offen |
| Böen-Last | +3,8 g | 🔜 offen |
| Bruch-Last | +5,7 g | 🔜 offen |
| Vibration/Ermüdung | ±0,5 g @ 15 Hz | 🔜 offen |

## Materialien (FEM-Materialbibliothek)

- T800-CFK: E=140 GPa, σ=2400 MPa, ρ=1,58 g/cm³
- M55J-CFK: E=180 GPa, σ=2100 MPa, ρ=1,91 g/cm³ (falls verwendet)
- Airex C70.75: ρ=0,075 g/cm³ (Sandwich-Kern)
- S-Glas: E=40 GPa, ρ=2,54 g/cm³ (für Rippen)
- Aluminium 7075: E=72 GPa, σ=572 MPa (Verbindungsbeschläge)
