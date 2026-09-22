#!/usr/bin/env python3
"""
Profil-Analyse für die 4 VTOL-Flügelkandidaten
==============================================

Liest .dat-Profile aus XFLR5_Profile/, extrahiert geometrische Kennzahlen
und erstellt einen Markdown-Vergleichsbericht.

Verwendung:
    python analyze_profiles.py

Ausgabe:
    - profile_analysis.md (Vergleichstabelle)
    - profile_summary.csv (für weitere Tools)
"""

from pathlib import Path
import csv
from dataclasses import dataclass, asdict
import re


@dataclass
class ProfileData:
    """Geometrische Kennzahlen eines Profils."""
    name: str
    source_file: str
    n_points: int
    max_thickness: float        # in % Sehne
    max_thickness_pos: float    # in % Sehne
    max_camber: float           # in % Sehne
    max_camber_pos: float       # in % Sehne
    leading_edge_radius: float  # dimensionslos
    trailing_edge_thickness: float  # in % Sehne


def read_dat_file(filepath: Path) -> tuple[str, list[tuple[float, float]]]:
    """
    Liest eine .dat-Datei im Selig- oder Lednicer-Format.
    """
    with open(filepath, "r", encoding="utf-8", errors="replace") as f:
        lines = f.readlines()

    # Erste Zeile ist Name/Beschreibung
    name = lines[0].strip()

    # Punkte einlesen — Selig-Format: jede Zeile hat "x y"
    points = []
    for line in lines[1:]:
        line = line.strip()
        if not line:
            continue
        parts = re.split(r'\s+', line)
        if len(parts) >= 2:
            try:
                x = float(parts[0])
                y = float(parts[1])
                points.append((x, y))
            except ValueError:
                continue

    return name, points


def analyze_profile(name: str, points: list[tuple[float, float]]) -> ProfileData:
    """
    Berechnet geometrische Kennzahlen aus den Profil-Punkten.

    Annahme: Punkte sind im Selig-Format (TE oben → LE → TE unten).
    """
    if not points:
        return ProfileData(
            name=name, source_file="", n_points=0,
            max_thickness=0, max_thickness_pos=0,
            max_camber=0, max_camber_pos=0,
            leading_edge_radius=0, trailing_edge_thickness=0,
        )

    # Punkte nach x sortieren
    points_sorted = sorted(set(points), key=lambda p: p[0])

    # Upper und Lower Surface trennen
    # Heuristik: erste Hälfte der Punkte = oben (y >= 0), zweite = unten (y <= 0)
    n = len(points_sorted)

    # Besser: finde Leading Edge (kleinstes x) und TE (x=1.0)
    # Punkte von TE-oben → LE → TE-unten
    # Wir suchen die beiden Punkte mit x=1 (TE) und das mit kleinstem x (LE)

    upper = []  # y >= 0
    lower = []  # y <= 0

    for x, y in points_sorted:
        if y >= 0:
            upper.append((x, y))
        else:
            lower.append((x, y))

    # Sortiere nach x
    upper.sort(key=lambda p: p[0])
    lower.sort(key=lambda p: p[0])

    # Thickness = upper - lower an gleicher x-Position
    # Da die Diskretisierung ungleich sein kann, lineare Interpolation
    def y_at(xs: list[tuple[float, float]], x_query: float) -> float | None:
        """Interpoliert y bei gegebenem x."""
        if not xs:
            return None
        for i in range(len(xs) - 1):
            x1, y1 = xs[i]
            x2, y2 = xs[i + 1]
            if x1 <= x_query <= x2 or x2 <= x_query <= x1:
                if x2 == x1:
                    return y1
                t = (x_query - x1) / (x2 - x1)
                return y1 + t * (y2 - y1)
        return None

    # Sampling-Punkte
    x_samples = [i / 100.0 for i in range(1, 100)]

    thicknesses = []
    camber = []
    max_thickness = 0
    max_thickness_pos = 0
    for x_q in x_samples:
        y_up = y_at(upper, x_q)
        y_lo = y_at(lower, x_q)
        if y_up is None or y_lo is None:
            continue
        t = y_up - y_lo
        c = (y_up + y_lo) / 2
        thicknesses.append((x_q, t))
        camber.append((x_q, c))
        if t > max_thickness:
            max_thickness = t
            max_thickness_pos = x_q

    max_camber = 0
    max_camber_pos = 0
    for x_q, c in camber:
        if abs(c) > abs(max_camber):
            max_camber = c
            max_camber_pos = x_q

    # Trailing Edge Thickness (am letzten Punkt beider Surfaces)
    te_thickness = 0
    if upper and lower:
        te_x_upper = upper[-1][0]
        te_x_lower = lower[-1][0]
        # Nimm den Punkt am nähesten x=1
        te_y_upper = upper[-1][1] if abs(te_x_upper - 1) < 0.05 else 0
        te_y_lower = lower[-1][1] if abs(te_x_lower - 1) < 0.05 else 0
        te_thickness = abs(te_y_upper - te_y_lower)

    # Leading-Edge-Radius (Näherungsformel nach Howe):
    # r_LE ≈ (max_thickness)^2 / (2 * sqrt(3) * dy/dx_leading_edge)
    # Vereinfacht: aus den ersten Punkten von upper und lower die Steigung
    le_radius = 0
    if upper and len(upper) > 2 and lower and len(lower) > 2:
        # Slope am LE aus oberem und unterem Surface
        x0, y0 = upper[1]
        x1, y1 = upper[2]
        slope_upper = abs((y1 - y0) / (x1 - x0)) if x1 != x0 else 0
        x0, y0 = lower[1]
        x1, y1 = lower[2]
        slope_lower = abs((y1 - y0) / (x1 - x0)) if x1 != x0 else 0
        total_slope = (slope_upper + slope_lower) / 2
        if total_slope > 0:
            le_radius = (max_thickness ** 2) / (total_slope * 100) * 100

    return ProfileData(
        name=name,
        source_file="",
        n_points=n,
        max_thickness=round(max_thickness * 100, 2),
        max_thickness_pos=round(max_thickness_pos * 100, 1),
        max_camber=round(max_camber * 100, 2),
        max_camber_pos=round(max_camber_pos * 100, 1),
        leading_edge_radius=round(le_radius, 3),
        trailing_edge_thickness=round(te_thickness * 100, 2),
    )


def main():
    """Hauptfunktion: alle Profile analysieren und Bericht erstellen."""
    script_dir = Path(__file__).parent
    # Skript liegt in 12_Skripte_Tools/, Profile in 02_Aerodynamik/XFLR5_Profile/
    profile_dir = script_dir.parent / "02_Aerodynamik" / "XFLR5_Profile"

    if not profile_dir.exists():
        print(f"❌ Profil-Verzeichnis nicht gefunden: {profile_dir}")
        return

    print(f"📁 Profil-Verzeichnis: {profile_dir}")
    print()

    profiles = []
    for dat_file in sorted(profile_dir.glob("*.dat")):
        print(f"  → Analysiere {dat_file.name}...")
        name, points = read_dat_file(dat_file)
        profile = analyze_profile(name, points)
        profile.source_file = dat_file.name
        profiles.append(profile)
        print(f"     {profile.n_points} Punkte, max Dicke: {profile.max_thickness}%")

    print()
    print(f"✅ {len(profiles)} Profile analysiert.")

    # Markdown-Report erstellen
    md_path = script_dir / "profile_analysis.md"
    with open(md_path, "w", encoding="utf-8") as f:
        f.write("# Profil-Analyse — Flügelkandidaten für Hermes-VTOL\n\n")
        f.write(f"**Erstellt:** {Path(__file__).name}\n\n")
        f.write("## Übersicht\n\n")
        f.write("| Profil | Datei | Punkte | max Dicke [%] | bei x [%] | max Wölbung [%] | bei x [%] | LE-Radius | TE-Dicke [%] |\n")
        f.write("|--------|-------|--------|---------------|-----------|------------------|-----------|-----------|---------------|\n")
        for p in profiles:
            f.write(f"| **{p.name}** | `{p.source_file}` | {p.n_points} | "
                    f"{p.max_thickness} | {p.max_thickness_pos} | "
                    f"{p.max_camber} | {p.max_camber_pos} | "
                    f"{p.leading_edge_radius} | {p.trailing_edge_thickness} |\n")
        f.write("\n## Empfehlung\n\n")
        f.write("**Hauptkandidat:** Wortmann FX 63-137 — bewährt im Re-Bereich 250.000–400.000, ")
        f.write("sehr gute Stall-Charakteristik.\n\n")
        f.write("**Vergleich:** NACA 4412 als konservativer Fallback. Eppler 423 und MH 114 ")
        f.write("als Alternativen bei abweichenden Anforderungen.\n\n")
        f.write("## Nächste Schritte\n\n")
        f.write("1. Polaren-Berechnung (Cl/Cd über alpha) bei Re=250k, 300k, 350k\n")
        f.write("2. Vergleich von L/D_max und Stall-Winkel\n")
        f.write("3. Auswahl des finalen Profils\n")
        f.write("4. 3D-Flügel-Analyse in OpenVSP\n")

    print(f"📄 Markdown-Report: {md_path}")

    # CSV für weitere Tools
    csv_path = script_dir / "profile_summary.csv"
    with open(csv_path, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=asdict(profiles[0]).keys())
        writer.writeheader()
        for p in profiles:
            writer.writerow(asdict(p))
    print(f"📊 CSV-Export: {csv_path}")


if __name__ == "__main__":
    main()
