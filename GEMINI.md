# GEMINI.md — AI Assistant Context (`BudhiDiwali2026`)

## 1. Project Overview
This repository (`BudhiDiwali2026`) is a zero-build, single-page static website celebrating **Igas-Bagwal (Budhi Diwali)**—Uttarakhand's traditional festival of lights observed 11 days after Diwali (*Kartik Shukla Ekadashi*). It follows the **ParbonStatic** `festival-static-site` skill blueprint.

- **Production Base URL**: `https://parbonstatic.github.io/BudhiDiwali2026/`
- **Architecture**: 100% self-contained inside `index.html` (semantic HTML5, custom CSS, inline SVG illustrations, and vanilla ES6 JavaScript) with zero external JS dependencies.

---

## 2. Design Tokens & Typography

### Warm "Himalayan Night" Palette (dark, fire-lit — no cold blacks)
**Surfaces & text**
- `--bg` (`#0D0806`) — Warm hearth near-black page background
- `--surface-1` (`#1C120D`) / `--surface-2` (`#241710`) / `--surface-3` (`#2E1D15`) — Card, chip, and badge surfaces
- `--text` (`#F7EDE2`) — Chandan-cream primary text
- `--text-2` (`#C9B6A6`) / `--text-3` (`#8C7768`) — Secondary & tertiary text
- `--line-c` (`#5E4334`) — Warm brown borders (replaces the old espresso outlines)
- `--shadow-c` (`rgba(224, 83, 61, 0.42)`) — Translucent crimson hard offset zine shadows (`--shadow-hard: 5px 6px 0 var(--shadow-c)`)

**Accents**
- `--crimson` (`#E0533D`) — Ember *Geru* crimson & `--crimson-d` (`#B83B2A`) — terracotta (marquee ribbon, backing postcard)
- `--saffron` (`#FF8A3D`) — Bhailo marigold amber (also used for text that was `--crimson-d` in the light theme)
- `--gold` / `--gold-l` (`#F6C453`) — Honey diya gold
- `--ember` — `linear-gradient(120deg, #FFD97A, #FF8A3D 48%, #E0533D)` for primary buttons, the nav CTA, and the brand mark
- `--on-accent` (`#1B0F09`) — Dark ink required on any gold/ember fill (buttons, tier pills, active chips, sticker tags)

Legacy light tokens (`--ivory`, `--cream`, `--peach`, `--kajal`, `--muted`) remain defined, but they are only used for light-on-accent text and the print stylesheet. Component-specific dark overrides live in the **"Dark Himalayan night colour layer"** block at the end of the `<style>` element.

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
   - Maintain `position: fixed; inset: 0; z-index: 0; pointer-events: none` (opacity `0.12`, raised to `0.14` by the dark colour layer) so the Himalayan ridgeline, *Aipan* mandala, and Pahadi lattice glow subtly behind the translucent dark sections and cards.
3. **1200×800 Canvas PNG Export (`#savePngBtn`)**:
   - Renders entirely client-side on an offscreen `<canvas>` using the same zine layout and fonts as the live `#card`, in the night palette: `#1A100B` fill, radial ember glow, gold solid + saffron dashed stamp borders, gold Aipan corner diamonds, vector Bhailo emblem, saffron Devanagari title, cream Hindi text, `Playfair Display` italic message, and gold `Caveat` sign-off. Keep it visually in sync with `#card`.
4. **Print (`@media print`)**:
   - Forces `#card` onto a white background with the original dark-ink colours so it prints legibly (browsers drop background colours by default).
5. **Open Graph Social Preview (`og-image.png` & `og-image.svg`)**:
   - `og:image` and `twitter:image` must always use absolute `https://` URLs pointing to `og-image.png` (`1200×630`).
   - `og-image.svg` is the dark-palette source. Re-rasterize after edits with `.\.agents\skills\festival-static-site\scripts\render-og-image.ps1` (headless Chrome/Edge, real web fonts). Keep text within the left column: the real `Syne` metrics are wide, so headline sizes are tuned (60/55px) to clear the Polaroid.
6. **Verification**:
   - Run `.\.agents\skills\festival-static-site\scripts\verify-festival-site.ps1` after structural changes to confirm all required files and meta tags pass.

