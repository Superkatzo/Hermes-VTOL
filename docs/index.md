---
layout: default
title: Hermes-VTOL
---

<section class="hero">
  <div class="hero-grid">
    <div>
      <h1>Hermes-VTOL</h1>
      <p class="tagline">Zivile Quadplane-VTOL für SAR, Wildschutz, Behörden &amp; Infrastruktur.</p>
      <p class="tagline" style="opacity: 0.75; font-size: 1rem; margin-top: -0.5rem; margin-bottom: 1.75rem;"><em>„Der Pickup-Truck der Lüfte" — vielseitig, modular, nützlich.</em></p>
      <div class="pill-row">
        <span class="pill pill-accent">16 kg MTOM</span>
        <span class="pill">2,3 m klappbar</span>
        <span class="pill">60 min Endurance</span>
        <span class="pill">2,3 kg Payload</span>
        <span class="pill">EU Klasse C3</span>
        <span class="pill">SORA-2.5-konform</span>
      </div>
    </div>
    <div class="hero-visual fade-up">
      <object type="image/svg+xml" data="{{ '/assets/img/vtol-illustration.svg' | relative_url }}" aria-label="VTOL Illustration"></object>
    </div>
  </div>
</section>

<section>
  <h2 class="section-title">Einsatzbereiche</h2>
  <div class="card-grid">
    <div class="card fade-up">
      <span class="card-icon">🚁</span>
      <h3 class="card-title">Search and Rescue</h3>
      <p class="card-text">Vermisstensuche, Lageerkundung, Lawinen-Ortung. Mit Thermalkamera rund um die Uhr einsetzbar.</p>
    </div>
    <div class="card fade-up">
      <span class="card-icon">🦌</span>
      <h3 class="card-title">Wildschutz</h3>
      <p class="card-text">Tierbeobachtung, Anti-Wilderei, Habitat-Monitoring. Sehr leise, lange Flugzeit, modular.</p>
    </div>
    <div class="card fade-up">
      <span class="card-icon">🏛️</span>
      <h3 class="card-title">Behörden-Einsätze</h3>
      <p class="card-text">Polizei, Zoll, Feuerwehr, THW. Schnell einsatzbereit, robust, dokumentierbar.</p>
    </div>
    <div class="card fade-up">
      <span class="card-icon">⚡</span>
      <h3 class="card-title">Infrastruktur-Inspektion</h3>
      <p class="card-text">Stromleitungen, Windkraftanlagen, Pipelines. Detail-Aufnahmen aus nächster Nähe.</p>
    </div>
  </div>
</section>

<section>
  <h2 class="section-title">Spezifikationen</h2>
  <div class="stats-grid">
    <div class="stat-card fade-up"><div class="label">MTOM</div><div class="value">16 kg</div></div>
    <div class="stat-card fade-up"><div class="label">Spannweite</div><div class="value">2,2–2,4 m</div></div>
    <div class="stat-card fade-up"><div class="label">Klappbar</div><div class="value">Ja ✓</div></div>
    <div class="stat-card fade-up"><div class="label">Akku</div><div class="value">14S Li-Ion</div></div>
    <div class="stat-card fade-up"><div class="label">Endurance</div><div class="value">45–60 min</div></div>
    <div class="stat-card fade-up"><div class="label">Payload</div><div class="value">2,28 kg</div></div>
    <div class="stat-card fade-up"><div class="label">Antrieb</div><div class="value">4+1 Quad</div></div>
    <div class="stat-card fade-up"><div class="label">Schub-Faktor</div><div class="value">2,10×</div></div>
  </div>
</section>

<section>
  <h2 class="section-title">Dokumentation</h2>
  <div class="card-grid">
    <div class="card">
      <span class="card-icon">📋</span>
      <h3 class="card-title">Lastenheft v1.1</h3>
      <p class="card-text">Komplette Spezifikation, Antriebsberechnung, Massenverteilung, Profil-Auswahl.</p>
    </div>
    <div class="card">
      <span class="card-icon">🛡️</span>
      <h3 class="card-title">ConOps-Vorlage SAR</h3>
      <p class="card-text">SORA-2.5-konform, alle 17 OSOs als Checkliste. Plug-and-Play für SAR-Käufer.</p>
    </div>
    <div class="card">
      <span class="card-icon">📜</span>
      <h3 class="card-title">Regulatorik-Kurzfassung</h3>
      <p class="card-text">EU/EASA, JARUS-SORA, deutsche LuftVO — aus Hersteller-Sicht.</p>
    </div>
    <div class="card">
      <span class="card-icon">💰</span>
      <h3 class="card-title">Kosten-Realität</h3>
      <p class="card-text">Initiale Investition €24–108k, laufende Versicherung, Aufschlüsselung pro Block.</p>
    </div>
  </div>
</section>

<section>
  <h2 class="section-title">Neueste Updates</h2>
  <ul class="posts-list">
    {% for post in site.posts limit:5 %}
    <li>
      <a href="{{ post.url | relative_url }}" class="post-item">
        <div class="post-meta">
          <span>{{ post.date | date: "%d.%m.%Y" }}</span>
          {% if post.categories %}<span class="post-tag">{{ post.categories | first | capitalize }}</span>{% endif %}
        </div>
        <h3 class="post-title">{{ post.title }}</h3>
        {% if post.excerpt %}<p class="post-item-excerpt">{{ post.excerpt | strip_html | truncate: 200 }}</p>{% endif %}
      </a>
    </li>
    {% endfor %}
  </ul>
</section>

<div class="callout callout-accent">
  <div class="callout-label">Hard-Rules</div>
  <p style="margin: 0.3rem 0 0;">Zivil-only. Keine militärische Verwendung. Keine Waffen. Professionelles Design — keine Cyberpunk-Ästhetik.</p>
</div>
