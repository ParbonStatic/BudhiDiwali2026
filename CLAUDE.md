# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A zero-build, single-page festival tribute site for **Igas-Bagwal (Budhi Diwali)** of Uttarakhand, part of the "ParbonStatic" family of festival sites. There is no package manager, bundler, linter, or test suite: open `index.html` directly in a browser to run it.

## Commands

```powershell
# The only automated check: required files + OG tags + key hero/background markers
powershell -ExecutionPolicy Bypass -File .\.agents\skills\festival-static-site\scripts\verify-festival-site.ps1
```

Deployment: `.github/workflows/static.yml` publishes the **entire repo root** to GitHub Pages on push to `main` (day-to-day work happens on `dev`). The production URL is `https://parbonstatic.github.io/BudhiDiwali2026/`.

## Architecture

Everything lives in `index.html` (~2.8k lines). It has three parts, in this order:

1. **`<style>`** (starts ~line 39): design tokens are CSS custom properties on `:root`. These are the accent tokens (`--crimson`, `--saffron`, `--gold`, `--gold-l`, the `--ember` gradient) plus the dark-theme tokens (`--bg`, `--surface-1/2/3`, `--text`, `--text-2`, `--text-3`, `--line-c` for borders, `--shadow-c` for hard offset shadows, `--on-accent` for dark text on gold or ember fills). The legacy light tokens (`--ivory`, `--cream`, `--kajal`, `--muted`) still exist, but component rules now use the dark tokens. A "Dark Himalayan night colour layer" block near the end of the stylesheet overrides individual components. The fixed translucent backdrop is `body::before`, built from inline `data:image/svg+xml` layers. Print styles isolate `#card` and force it onto a light background.
2. **Markup**: sticky `.nav` → `.hero` (with the layered `.hero-collage`) → sections `#legend`, `#rituals`, `#bhoj`, `#virtual-bhelo` (greeting card studio), `#wishes` → `.footer`. All artwork is inline SVG, with no external image assets except `favicon.svg` and the OG images.
3. **`<script>`** (one IIFE, ~line 2377): plain ES6 with no dependencies. `$` is a `getElementById` helper.

### Greeting card studio: keep three renderers in sync
The `presets` object (keyed by vibe: `classic`, etc.) drives the card. The same card content is rendered **three separate ways**, and each repeats the same default-value fallbacks (`'Dear Family & Friends'`, `'With Pahadi Warmth'`, `preset.eng`):
- `updateLiveCard()`: the live DOM preview card
- `formatPlainCardText()`: used by Copy and Share (`navigator.share` with clipboard fallback, and `execCommand('copy')` as the final fallback)
- the `savePngBtn` handler: draws a 1200×800 PNG by hand on an offscreen canvas (coordinates are hardcoded)

If you add a preset, add a field, or change the default text, update all three.

### Hero collage stacking invariant
`.floating-tag` stickers must keep `z-index: 4` and come **after** `.polaroid` (`z-index: 2`) in the DOM, with `.collage-back` at `z-index: 1`. Otherwise they render beneath the Polaroid's stacking context or get clipped on mobile.

### Open Graph
Social crawlers need absolute `https://` URLs and a raster image. `og-image.svg` is the editable source and `og-image.png` (1200×630) is the file actually served. If you change the domain or repo name, update `canonical`, `og:url`, `og:image`, `og:image:secure_url`, `twitter:url`, and `twitter:image` in `index.html`. If you edit `og-image.svg`, re-rasterize the PNG.

## Design conventions

`.agents/skills/festival-static-site/` holds the reusable blueprint for this family of sites. Follow its `SKILL.md` for layout, fonts and tone. The one deliberate exception is the **colour scheme**: this site uses a dark "Himalayan night" palette instead of the skill's light ivory/cream surfaces.
- Use warm darks only (`--bg` is `#0D0806`). Don't use cold blacks or slate (`#000`, `#0f172a`, …). Text is `--text`/`--text-2`. Accents are crimson `#E0533D`, saffron `#FF8A3D`, gold `#F6C453` and the `--ember` gradient (used on the primary buttons and the nav CTA).
- Anything filled with gold or ember must use `color: var(--on-accent)` (dark ink). Light text on gold fails contrast.
- Use a deliberately asymmetric "indie zine" look: tilted cards, organic uneven border radii, hard offset shadows (`Npx Mpx 0 var(--shadow-c)`), section headers that alternate between `.sec-head` and `.sec-head.flip`, and staggered or bento grids. Avoid symmetrical template layouts.
- Fonts each have a role: `Syne` for display and index badges, `Playfair Display` italic for spliced editorial words, `Caveat` for handwritten notes and captions, `Tiro Devanagari Hindi` for native script, and `Plus Jakarta Sans` for body text.
- The canvas PNG keeps the original layout and fonts but uses the dark palette. Keep it visually in step with the live `#card`.
- When generating `og-image.png` with PowerShell `System.Drawing`, write Devanagari strings as `[regex]::Unescape("\uXXXX")` so that Windows PowerShell 5.1 parses the script correctly.

`README.md` and `GEMINI.md` are part of the required file set that the verify script checks. Keep them accurate when you change features.
