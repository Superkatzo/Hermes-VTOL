---
layout: default
title: Hermes-VTOL
---

<div class="hero">
  <h1>🚁 Hermes-VTOL</h1>
  <p class="tagline">Zivile Quadplane-VTOL für SAR, Wildschutz, Behörden &amp; Infrastruktur</p>
  <p class="tagline" style="opacity: 0.85; font-size: 1rem; margin-top: 0.5rem;"><em>„Der Pickup-Truck der Lüfte" — vielseitig, modular, nützlich.</em></p>

  <div class="stats">
    <span class="stat-pill">🪶 16 kg MTOM</span>
    <span class="stat-pill">🦅 2,3 m Spannweite (klappbar)</span>
    <span class="stat-pill">🔋 60 min Endurance</span>
    <span class="stat-pill">📦 2,3 kg Payload</span>
    <span class="stat-pill">🇪🇺 EU-konform (C3)</span>
  </div>
</div>

## Was ist Hermes-VTOL?

Hermes-VTOL ist eine Quadplane-Plattform mit Klappmechanismus, die **vier eigenständige Missionen** in einer Drohne vereint. Anstatt für jeden Use-Case ein eigenes Gerät zu kaufen, bekommst du **eine modulare Plattform** mit austauschbaren Payload-Containern.

## Anwendungsbereiche

<div class="card-grid">
  <div class="card">
    <div class="card-title">🚁 Search and Rescue (SAR)</div>
    <p>Vermisstensuche, Lageerkundung, Lawinen-Ortung. Mit Thermalkamera bei Nacht einsetzbar.</p>
  </div>
  <div class="card">
    <div class="card-title">🦌 Wildschutz</div>
    <p>Tierbeobachtung, Anti-Wilderei, Habitat-Monitoring. Sehr leise, lange Flugzeit, modular.</p>
  </div>
  <div class="card">
    <div class="card-title">🏛️ Behörden-Einsätze</div>
    <p>Polizei, Zoll, Feuerwehr, THW. Schnell einsatzbereit, robust, dokumentierbar.</p>
  </div>
  <div class="card">
    <div class="card-title">⚡ Infrastruktur-Inspektion</div>
    <p>Stromleitungen, Windkraftanlagen, Pipelines. Detail-Aufnahmen aus nächster Nähe.</p>
  </div>
</div>

## Eckdaten

<div class="stats-grid">
  <div class="stat-card">
    <div class="label">MTOM</div>
    <div class="value">16 kg</div>
  </div>
  <div class="stat-card">
    <div class="label">Spannweite</div>
    <div class="value">2,2 – 2,4 m</div>
  </div>
  <div class="stat-card">
    <div class="label">Klappbar</div>
    <div class="value">Ja ✓</div>
  </div>
  <div class="stat-card">
    <div class="label">Akku</div>
    <div class="value">14S Li-Ion</div>
  </div>
  <div class="stat-card">
    <div class="label">Endurance</div>
    <div class="value">45-60 min</div>
  </div>
  <div class="stat-card">
    <div class="label">Payload max.</div>
    <div class="value">2,28 kg</div>
  </div>
  <div class="stat-card">
    <div class="label">Antrieb</div>
    <div class="value">4+1 (Quadplane)</div>
  </div>
  <div class="stat-card">
    <div class="label">Schwebeschub-Faktor</div>
    <div class="value">2,10×</div>
  </div>
</div>

---

## Dokumentation im Überblick

<div class="card-grid">
  <div class="card">
    <div class="card-title">📋 Lastenheft v1.1</div>
    <p>Komplette Spezifikation, Antriebsberechnung, Massenverteilung, Profil-Auswahl.</p>
  </div>
  <div class="card">
    <div class="card-title">🛡️ ConOps-Vorlage SAR</div>
    <p>SORA-2.5-konform, alle 17 OSOs als Checkliste. Plug-and-Play für SAR-Käufer.</p>
  </div>
  <div class="card">
    <div class="card-title">📜 Regulatorik-Kurzfassung</div>
    <p>EU/EASA-Verordnungen, JARUS-SORA, deutsche LuftVO — aus Hersteller-Sicht.</p>
  </div>
  <div class="card">
    <div class="card-title">💰 Kosten-Realität</div>
    <p>Initiale Investition €24-108k, laufende Versicherung, Aufschlüsselung pro Block.</p>
  </div>
</div>

---

## Neueste Updates

{% for post in site.posts limit:5 %}
<ul class="posts-list">
  <li>
    <div class="post-meta">{{ post.date | date: "%d.%m.%Y" }}</div>
    <h3 style="margin: 0.2rem 0;"><a href="{{ post.url }}">{{ post.title }}</a></h3>
    {% if post.excerpt %}{{ post.excerpt | strip_html | truncate: 180 }}{% endif %}
  </li>
</ul>
{% endfor %}

## Weiterführend

| Dokument | Beschreibung |
|----------|--------------|
| 🔗 [GitHub-Repo](https://github.com/Superkatzo/Hermes-VTOL) | Komplette Quelloffene Doku, 13 Verzeichnisse, ~30 Doku-Dateien |
| 📚 [ConOps-Vorlage SAR](https://github.com/Superkatzo/Hermes-VTOL/blob/main/01_Dokumentation/ConOps-Vorlage-SAR.md) | SORA-2.5-konform, plug-and-play |
| 📖 [Kosten-Realität](https://github.com/Superkatzo/Hermes-VTOL/blob/main/01_Dokumentation/Kosten-Realitaet.md) | Detaillierte Aufschlüsselung |

<div class="callout-warn">
  <div class="label">Hard-Rules</div>
  <p style="margin: 0.4rem 0 0;">Zivil-only. Keine militärische Verwendung. Keine Waffen. Professionelles Design — keine Cyberpunk-Ästhetik.</p>
</div>
