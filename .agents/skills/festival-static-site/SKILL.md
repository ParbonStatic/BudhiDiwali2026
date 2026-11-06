---
name: festival-static-site
description: >-
  Use this skill when the user wants to create, scaffold, or customize a zero-build
  cultural or festival tribute static website (e.g., Bhai Phonta, Diwali, Durga Puja,
  Holi, Navratri, Eid, Christmas, Onam, Pongal, Ganesh Chaturthi, Lunar New Year)
  complete with bespoke translucent SVG background artwork, warm welcoming color
  palettes, human-crafted Gen Z asymmetric zine layouts, interactive rituals, a
  downloadable 1200x800 Canvas PNG greeting card generator, Open Graph social preview
  assets (og-image.png + og-image.svg), GitHub Pages CI/CD, README.md, and GEMINI.md.
---

# Festival Static Website Generator Skill (`festival-static-site`)

This skill provides a complete, plug-and-play blueprint for building rich, zero-build, single-page cultural and festival tribute websites following the **ParbonStatic** architecture—combining deep cultural authenticity with a warm, human-crafted **Gen Z Indie-Zine aesthetic**.

---

## 1. Required Inputs & Discovery

When triggered, identify the following parameters from the user's request (or infer sensible defaults using [Theme Presets](./references/theme-presets.md)):

1. **Festival Name & Subtitle**: e.g., *"ভাই ফোঁটা | Bhai Phonta – Bhratri Dwitiya Tribute"*, *"Deepavali | Festival of Lights"*, *"Sharadotsav | Durga Puja Tribute"*.
2. **Production Base URL**: e.g., `https://parbonstatic.github.io/<RepoName>/` (used for canonical and Open Graph absolute links).
3. **Welcoming Color Palette (Warm & Hospitable Tokens)**:
   - Avoid harsh blood-reds (`#B71C1C`) or cold charcoal/black (`#212121`, `#1b1b1b`) that make family/cultural sites feel stark.
   - Prefer warm, sunlit hospitality tones:
     - `ivory` (`#FFFBF2` sandalwood silk) & `cream` (`#FDF3DF` chandan cream)
     - `crimson` (`#B83B2A` warm terracotta-sindoor) & `crimson-d` (`#8E281B` rust-maroon)
     - `saffron` (`#E07A2E` marigold amber) & `gold` (`#D99B26` / `#F6C453` honey gold)
     - `kajal` (`#3B231A` deep Nolen Gur / roasted espresso brown instead of pure black) & `muted` (`#6E4F41` cinnamon brown)
4. **Interactive Centerpiece Ritual**:
   - Examples: *Apply Virtual Phonta / Tilak*, *Light a Virtual Diya*, *Offer Pushpanjali Flowers*, *Play Virtual Gulal/Colors*, *Hang a Festive Lantern*.

---

## 2. Target Repository Structure

Generate or maintain a zero-build repository layout:

```text
<FestivalRepo>/
├── .github/
│   └── workflows/
│       └── static.yml    # GitHub Actions workflow for GitHub Pages deployment
├── favicon.svg           # Custom 64×64 vector emblem matching the festival centerpiece
├── og-image.svg          # 1200×630 editable vector source for the Open Graph banner
├── og-image.png          # 1200×630 rasterized PNG banner (REQUIRED for social crawlers)
├── index.html            # Self-contained single-page app (HTML5 + CSS + inline SVG + ES6 JS)
├── LICENSE               # The Unlicense (Public Domain dedication)
├── GEMINI.md             # AI assistant context, architecture, and OG link guide
└── README.md             # User-facing documentation, features, and OG customization guide
```

---

## 3. Core Visual & Anti-AI-Template Design Principles

To ensure the website feels **warm, Gen Z-friendly, and handcrafted by a human indie designer** rather than a generic symmetrical AI template:

### A. Relevant Translucent Background Artwork (`body::before` + Section Watermarks)
- **Full-Viewport Translucent Backdrop (`body::before`)**:
  - Use a fixed (`position: fixed; inset: 0; z-index: 0; pointer-events: none; opacity: 0.11–0.13`) multi-layer `background-image` using inline `data:image/svg+xml` URLs:
    1. **Primary Cultural Mandala / Emblem**: Positioned off-center (e.g., `background-position: 78% 22%`) depicting iconic festival motifs (e.g., Bengali *Alpana* lotus mandala, *Baran Dala* thali, *Mangal Pradip*, *Dhan-Durba* paddy stalks, *Shankha*, and *Chandan Tilak*).
    2. **Seamless Repeating Motif Tile**: A `160×160` delicate repeating lattice of cultural symbols.
- **Section & Card Translucency**:
  - Keep light sections (`rgba(253, 243, 223, 0.65)`) and cards (`rgba(255, 253, 248, 0.92)` with `backdrop-filter: blur(8px)`) slightly translucent so the background artwork subtly shows through.
  - Layer soft gold/ivory translucent SVG watermarks inside dark/accent sections (`.hero`, `.gen`).

### B. Asymmetric Mixed-Font Stack
Load and mix 4–5 complementary font voices in headings and callouts:
- **Asymmetric Display (`Syne`)**: Bold, wide-proportioned geometric headlines, index tags (`01 // THE SACRED LORE`), and sticker pills.
- **Editorial Italic Serif (`Playfair Display` italic)**: Spliced mid-headline (`Bhai *Phonta*, but make it...`) with wavy underlines (`text-decoration: underline wavy`).
- **Handwritten Scribble (`Caveat`)**: Tilted margin annotations (`✎ memorized by every bong kid ever`, `← takes 10 secs!`), Polaroid captions, and personal card sign-offs.
- **Native Cultural Script (`Tiro Bangla`, `Noto Serif Devanagari`, etc.)**: Authentic verses, chants, and bilingual titles.
- **Clean Body Sans (`Plus Jakarta Sans`)**: High-legibility body copy and form controls.

### C. Asymmetric Layouts, Zine Collage & Tactile Craft
1. **Floating Off-Beat Navbar**:
   - Sticky glassmorphic pill bar with organic asymmetric border radii (`border-radius: 20px 28px 18px 26px`), hard offset shadow (`4px 5px 0 rgba(59,35,26,.9)`), and a slightly tilted CTA button (`transform: rotate(1.2deg)`).
2. **Asymmetric Split Hero + Multi-Layer Polaroid Collage (`.hero-grid` & `.hero-collage`)**:
   - Use a `1.25fr / 0.75fr` split instead of a centered vertical stack.
   - **Left column**: Tilted zine sticker badge, mixed-font headline, relatable subcopy, tactile offset buttons, and a handwritten scribble pointer.
   - **Right column (`.hero-collage`)**:
     - Constrain with `width: 100%; max-width: 350px; padding: 14px 16px; position: relative;` so rotated child elements never clip on mobile.
     - **Layer 1 (`.collage-back`, `z-index: 1`)**: Tilted (`-6.5deg`) backing postcard peeking behind the Polaroid with native script.
     - **Layer 2 (`.polaroid`, `z-index: 2`)**: Main tilted (`+2.6deg`) Polaroid frame with centered top Washi tape (`::before`), a rich multi-element SVG stage (`140×120` viewBox showing the full ceremonial thali/lamp/tilak), handwritten caption, and `FIG. 01` label.
     - **Layer 3 (`.floating-tag`, `z-index: 4`)**: Place floating sticker pills (`🧿 Yama-Proof`, `🎁 Gift Tax Due`) at `z-index: 4` (and after `.polaroid` in DOM) with `left: 0` / `right: 0` so they always render cleanly **above** the Polaroid's stacking context without clipping.
3. **Diagonal Kinetic Marquee (`.marquee`)**:
   - Tilt the scrolling ticker strip (`transform: rotate(-1.1deg) scale(1.02)`) between the hero and main content, mixing native script blessings with Gen Z phrases (`✦ YAMA'S DOOR = BLOCKED 🛡️`, `✦ MISHTI OVERLOAD 🍥`, `✦ NO KALESH TODAY ✌️`).
4. **Alternating Headers & Staggered Bento Grids**:
   - Alternate section headers between left-aligned (`.sec-head`) and right-flipped (`.sec-head.flip`), pairing numbered index badges (`01 //`, `02 //`) with tilted `.scribble-note` annotations.
   - Use asymmetric splits (`1.2fr / 0.85fr` for verse + origin lore), staggered 3-column ritual grids (`.stagger-3` where card 2 is nudged down `1.8rem` and cards have `-1.1deg` / `+0.9deg` rotations), and **12-column asymmetric Bento grids** (`.bento-mishti` where top cards span `7` + `5` columns and bottom cards span `4 + 4 + 4` with organic corner radii `24px 10px 22px 12px` and tactile offset shadows `5px 6px 0 var(--kajal)`).

---

## 4. Interactive Modules & Greeting Card Studio (`#phota` / `#virtual-diya`)

1. **Vibe Preset Chips**:
   - Include both traditional blessings and relatable Gen Z sibling/festive presets (`✨ Classic Blessing`, `🤝 Partner in Crime`, `🎁 Gift Tax Due`, `💛 100 Years`), each updating both the textarea wish and a dynamic `.card-vibe-tag` sticker on the preview card.
2. **Stamp-Style Live DOM Card + Confetti Burst**:
   - Submitting the form triggers a warm-palette canvas confetti burst, reveals the tilted stamp-bordered card (`border: 2px dashed var(--crimson)`), and animates the SVG centerpiece/tilak.
3. **4-Action Export Bar**:
   - **Copy Text**: Copies formatted plain text (including the vibe badge and native script verse) to clipboard with `<textarea>` fallback.
   - **Share 📲**: Invokes `navigator.share` on mobile/supported browsers with automatic clipboard fallback.
   - **Save PNG 📸**: Renders a high-resolution `1200×800` PNG greeting card on an offscreen HTML5 2D Canvas with warm ivory fill, radial golden glow, solid + dashed stamp borders, drawn vector emblem, uppercase `Syne` vibe header, `Tiro Bangla` title, `Playfair Display` italic wrapped message, and `Caveat` handwritten sign-off.
   - **Print**: Clean `@media print` stylesheet isolating `#card`.

---

## 5. Verification Checklist

Run [verify-festival-site.ps1](./scripts/verify-festival-site.ps1) or manually verify:
- [ ] Opening `index.html` directly requires zero build tools and produces no console errors.
- [ ] Translucent cultural background SVG (`body::before`) is visible across light sections and cards without reducing text contrast.
- [ ] Colour scheme uses warm, welcoming hospitality tones (sandalwood ivory, terracotta vermilion, marigold saffron, honey gold, espresso brown) with no harsh cold blacks.
- [ ] Hero Collage stickers (`.floating-tag`) have `z-index: 4` above `.polaroid` (`z-index: 2`) and do not clip on mobile or desktop viewports.
- [ ] Asymmetric typography (`Syne` + `Playfair Display` italic + `Caveat` scribble + native script) and staggered Bento/zine layouts are applied consistently.
- [ ] All interactive features work: mobile menu drawer, expandable Bento cards, vibe preset chips, confetti burst, `1200×800` PNG card download, native share, and one-tap quick-copy wishes.
