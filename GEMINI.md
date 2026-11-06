# GEMINI.md — AI Assistant Context (`BudhiDiwali2026`)

## 1. Project Overview
This repository (`BudhiDiwali2026`) is a zero-build, single-page static website celebrating **Igas-Bagwal (Budhi Diwali)**—Uttarakhand's traditional festival of lights observed 11 days after Diwali (*Kartik Shukla Ekadashi*). It follows the **ParbonStatic** `festival-static-site` skill blueprint.

- **Production Base URL**: `https://parbonstatic.github.io/BudhiDiwali2026/`
- **Architecture**: 100% self-contained inside `index.html` (semantic HTML5, custom CSS, inline SVG illustrations, and vanilla ES6 JavaScript) with zero external JS dependencies.

---

## 2. Design Tokens & Typography

### Warm Hospitality Palette
- `--ivory` (`#FFFBF2`) — Sandalwood silk surface
- `--cream` (`#FDF3DF`) — Chandan cream secondary surface
- `--crimson` (`#B83B2A`) — Pahadi *Geru* terracotta-vermilion
- `--crimson-d` (`#8E281B`) — Deep rust-maroon
- `--saffron` (`#E07A2E`) — Marigold & Bhailo fire amber
- `--peach` (`#FFE5CC`) — Soft festive peach
- `--gold` (`#D99B26`) & `--gold-l` (`#F6C453`) — Honey & brass diya gold
- `--kajal` (`#3B231A`) — Roasted espresso brown (used instead of harsh black `#000`)
- `--muted` (`#6E4F41`) — Warm cinnamon brown

### 5-Voice Font Stack
- **Display & Index Badges**: `Syne` (700/800)
- **Editorial Italic Splices**: `Playfair Display` (italic 400/600/700)
- **Handwritten Annotations & Captions**: `Caveat` (600/700)
- **Devanagari Chants & Titles**: `Tiro Devanagari Hindi`
- **Body Copy & Controls**: `Plus Jakarta Sans` (400/500/600/700)

---

## 3. Architectural Guardrails
1. **Hero Polaroid Collage (`.hero-collage`)**:
   - Keep `.collage-back` at `z-index: 1`, `.polaroid` at `z-index: 2`, and `.floating-tag` stickers at `z-index: 4` (placed **after** `.polaroid` in the DOM with `left: 0` / `right: 0`) so stickers never clip or fall behind the Polaroid stacking context.
2. **Translucent Cultural Backdrop (`body::before`)**:
   - Maintain `position: fixed; inset: 0; z-index: 0; pointer-events: none; opacity: 0.12` so the *Aipan* mandala and Pahadi lattice subtly show through light sections and cards.
3. **1200×800 Canvas PNG Export (`#savePngBtn`)**:
   - Renders entirely client-side on an offscreen `<canvas>` with warm ivory fill, radial golden glow, solid + dashed stamp borders, vector Bhailo emblem, wrapped Hindi + English text, and `Caveat` sign-off.
4. **Open Graph Social Preview (`og-image.png` & `og-image.svg`)**:
   - `og:image` and `twitter:image` must always use absolute `https://` URLs pointing to `og-image.png` (`1200×630`).
5. **Verification**:
   - Run `.\.agents\skills\festival-static-site\scripts\verify-festival-site.ps1` after structural changes to confirm all required files and meta tags pass.

