# PRYNCE TV — Brand asset integration

## Approved visual direction
- Product name: **PRYNCE TV**
- Visual system: deep navy / near-black surfaces with restrained gold accents.
- Brand artwork: use the supplied PRYNCE icon and wordmark as the source of truth. Do not trace, redraw, replace, or recolour the artwork.

## Prepared artwork
The current working session contains these user-supplied assets:
- `prynce_icon.png` — original square icon artwork (300 × 300 source).
- `prynce_wordmark_white.png` — original white wordmark.
- `prynce_tv_icon.png` — 256 × 256 launcher-sized derivative of the supplied icon.
- `prynce_tv_banner_320x180.png` — 320 × 180 Android TV banner composition. The original icon and wordmark are placed on a dark navy field with a restrained gold border; the logo artwork itself is not redrawn.
- `prynce_tv_banner.png` — 640 × 360 high-resolution preview of the same banner.

The prepared icon and banner are working files, not yet verified as committed repository assets. Do not mark branding integration complete until the exact files are committed, wired into Android resources, rebuilt, and visually inspected on a phone and TV launcher.

## Android integration targets
1. Launcher icon: replace the provisional upstream-derived launcher artwork using the supplied icon in the appropriate Android density/adaptive icon resources. Preserve a safe foreground/background treatment and verify crop/mask behaviour.
2. Android TV / Fire TV launcher banner: use the prepared 320 × 180 banner in the existing `@drawable/banner` resource slot referenced by the manifest.
3. In-app brand surface: use the supplied wordmark in the app's About / Settings / welcome surface, without obstructing playback controls or source setup.
4. Store / sharing thumbnails: use the approved icon and banner artwork consistently; do not invent broadcaster logos, channel marks, or programme artwork.

## Acceptance checks
- [ ] Binary source artwork committed to `branding/` with clear filenames and provenance.
- [ ] Launcher icon resource paths updated; no provisional upstream artwork remains in PRYNCE-branded surfaces.
- [ ] TV banner resource updated and manifest reference verified.
- [ ] In-app wordmark placement verified at phone and TV viewing distances.
- [ ] CI tests and debug APK build pass.
- [ ] Real Android phone launcher and Android TV / Fire TV launcher screenshots reviewed.
- [ ] Final screenshots show PRYNCE TV clearly and do not imply affiliation with another broadcaster or TV service.

## Release and rights
PRYNCE TV is a media player. It must not bundle channels or copyrighted programme thumbnails without permission. Use only artwork owned by the project or licensed for the intended use. Preserve OpenTV GPL-3.0-or-later notices and corresponding-source obligations for redistributed modified builds.
