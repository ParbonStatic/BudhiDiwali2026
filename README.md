# इगास-बग्वाल | Budhi Diwali — A Himalayan Zine Tribute

A zero-build, single-page cultural tribute website celebrating **Igas-Bagwal (Budhi Diwali)**—the living folk festival of **Devbhoomi Uttarakhand**, traditionally observed 11 days after Diwali on *Kartik Shukla Ekadashi*.

Built with the **ParbonStatic** architecture, this site blends authentic Garhwali & Kumaoni cultural traditions (*Bhailo Khelna*, *Madho Singh Bhandari* folklore, *Pashu Dhan Puja*, *Aipan* art, and *Pahadi Bhoj*) with a warm, tactile **Gen Z Indie-Zine aesthetic**.

---

## ✨ Key Features

- **Warm "Himalayan Night" Palette**: A dark, fire-lit scheme built on warm near-black hearth tones (`#0D0806` page, `#1C120D`–`#2E1D15` card surfaces) with chandan-cream text (`#F7EDE2`), *Geru* ember crimson (`#E0533D`), Bhailo marigold saffron (`#FF8A3D`), and honey diya gold (`#F6C453`). Primary buttons use a gold → saffron → crimson **ember gradient**, zine shadows glow in translucent crimson, and there are zero cold blacks.
- **Translucent Cultural Background Artwork (`body::before`)**: Fixed, low-opacity (`0.14`) multi-layer inline SVG backdrop depicting a panoramic Himalayan ridgeline, an octagonal *Aipan* mandala with whirling *Bhailo* flame, and a `160×160` repeating Pahadi geometric lattice, plus a glowing `.hero-hills` horizon with village *diya* lights at the base of the hero.
- **Asymmetric Mixed-Font Stack**: Combines `Syne` (wide display headers & index badges), `Playfair Display` italic (wavy-underlined editorial splices), `Caveat` (tilted handwritten margin scribbles & Polaroid captions), `Tiro Devanagari Hindi` (native folk chants & greetings), and `Plus Jakarta Sans` (body copy).
- **Multi-Layer Hero Polaroid Collage (`.hero-collage`)**:
  - **Layer 1 (`.collage-back`, `z-index: 1`)**: Tilted (`-6.5deg`) backing Pahadi terracotta postcard.
  - **Layer 2 (`.polaroid`, `z-index: 2`)**: Tilted (`+2.6deg`) Polaroid with centered Washi tape, a `140×120` SVG night courtyard stage (snow-capped Garhwal peaks, *Aipan* border, *Dhol* drum, clay *diyas*, and an animated whirling *Bhailo* fire ring), `FIG. 01 // BHAILO NIGHT` metadata, and handwritten caption.
  - **Layer 3 (`.floating-tag`, `z-index: 4`)**: Top-level floating zine stickers (`🔥 Bhailo Khelna`, `🏔️ 11 Days Later`) rendered cleanly above the Polaroid stacking context.
- **Interactive Modules**:
  - **01 // The Sacred Lore**: Taped Garhwali *Bhailo* folk chant + rotated lore cards (*Madho Singh Bhandari's Return* & *News Crossing the High Passes*).
  - **02 // Core Rituals**: Staggered 3-column grid covering *Bhailo Khelna*, *Pashu Dhan Puja*, and *Aipan, Chhura & Jhumelo*.
  - **03 // Pahadi Bhoj Tier List**: Asymmetric 12-column Bento grid (`7 + 5` top row, `4 + 4 + 4` bottom row) with expandable tasting notes for *Arsa*, *Swunla & Urad Pakora*, *Gahat Dal & Mandua*, *Jhangora ki Kheer*, and *Pashu Pinda & Roat*.
  - **04 // Virtual Bhailo & Greeting Card Studio**: Vibe preset chips (`✨ Classic Blessing`, `🔥 Bhailo Squad`, `🍯 Arsa Tax Due`, `🏔️ Himalayan Roots`), animated Bhailo spinner, warm-palette confetti burst, live stamp-bordered dark preview card, and a 4-action export bar (**Copy Text**, **Share 📲**, **Save `1200×800` PNG 📸** rendered in the same night palette, **Print 🖨️** which switches the card to a printer-friendly light version).
  - **05 // 1-Tap Quick Wishes**: Instant copyable Garhwali/Hindi and English festival greetings.

---

## 📁 Repository Structure

```text
BudhiDiwali2026/
├── .github/
│   └── workflows/
│       └── static.yml    # GitHub Actions workflow for GitHub Pages deployment
├── favicon.svg           # Custom 64×64 vector emblem (Bhailo fire ring + Himalayan peaks)
├── og-image.svg          # 1200×630 editable vector source for the Open Graph banner
├── og-image.png          # 1200×630 rasterized PNG banner for WhatsApp/Facebook/X crawlers
├── index.html            # Self-contained single-page app (HTML5 + CSS + inline SVG + ES6 JS)
├── LICENSE               # The Unlicense (Public Domain dedication)
├── GEMINI.md             # AI assistant context, architecture, and OG link guide
└── README.md             # Project documentation and customization guide
```

---

## 🚀 Zero-Build Local Usage

No Node.js, bundler, or build step is required. Open `index.html` directly in any modern browser, or serve locally:

```powershell
# Verify all required files and Open Graph tags:
powershell -ExecutionPolicy Bypass -File .\.agents\skills\festival-static-site\scripts\verify-festival-site.ps1
```

---

## 🔗 Customizing Open Graph Social Preview URLs

Social media crawlers (WhatsApp, Facebook, LinkedIn, X) require **absolute `https://` URLs** pointing to a raster image (`og-image.png`). If deploying under a different GitHub organization or custom domain, update these tags in `index.html`:

- `<link rel="canonical" href="https://parbonstatic.github.io/BudhiDiwali2026/" />`
- `<meta property="og:url" content="https://parbonstatic.github.io/BudhiDiwali2026/" />`
- `<meta property="og:image" content="https://parbonstatic.github.io/BudhiDiwali2026/og-image.png" />`
- `<meta property="og:image:secure_url" content="https://parbonstatic.github.io/BudhiDiwali2026/og-image.png" />`
- `<meta name="twitter:url" content="https://parbonstatic.github.io/BudhiDiwali2026/" />`
- `<meta name="twitter:image" content="https://parbonstatic.github.io/BudhiDiwali2026/og-image.png" />`

### Regenerating `og-image.png`

`og-image.svg` is the editable source (dark Himalayan-night banner with the Bhailo Polaroid collage). After editing it, re-rasterize the PNG with headless Chrome/Edge so the real web fonts are used:

```powershell
powershell -ExecutionPolicy Bypass -File .\.agents\skills\festival-static-site\scripts\render-og-image.ps1
```

Social platforms cache previews aggressively — use the Facebook Sharing Debugger or LinkedIn Post Inspector to force a refresh after deploying.

---

## 📄 License

Dedicated to the public domain under **The Unlicense** (see [LICENSE](./LICENSE)).
