# PRYNCE TV — Brand asset integration

## Approved visual direction
- Product name: **PRYNCE TV**
- Visual system: deep navy / near-black surfaces with restrained gold accents.
- Brand artwork: use the supplied PRYNCE icon and wordmark as the source of truth. Do not trace, redraw, replace, or recolour the artwork.

## Prepared artwork
The current working session contains these user-supplied assets:
- `prynce_icon.png` — original square icon artwork (300 × 300 source).
- `prynce_wordmark_white.png` — original white wordmark.
- `branding/prynce_tv_icon.jpg` — committed 128 × 128 launcher icon derivative.
- `branding/prynce_tv_banner.jpg` — committed 320 × 180 Android TV banner composition, using the supplied icon and wordmark on a dark navy field with a restrained gold border.

The source artwork was not redrawn or recoloured; the derivatives were resized, composited and JPEG-compressed for Android resource compatibility. The original supplied PNG assets remain the artwork source of truth.

## Android integration targets
1. Launcher icon: CI installs `branding/prynce_tv_icon.jpg` as `app/src/main/res/drawable/ic_launcher.jpg`, replacing the upstream default drawable for the branded build.
2. Android TV / Fire TV launcher banner: CI installs `branding/prynce_tv_banner.jpg` as `app/src/main/res/drawable/banner.jpg` in the existing `@drawable/banner` slot.
3. In-app brand surface: use the supplied wordmark in the app's About / Settings / welcome surface, without obstructing playback controls or source setup.
4. Store / sharing thumbnails: use the approved icon and banner artwork consistently; do not invent broadcaster logos, channel marks, or programme artwork.

## Acceptance checks
- [x] Compressed icon and banner derivatives committed to `branding/` with clear filenames.
- [x] CI replaces the upstream launcher icon and TV banner resources for the branded build; manifest references validated.
- [ ] Inspect actual phone and Android TV / Fire TV launcher screenshots.
- [ ] In-app wordmark placement verified at phone and TV viewing distances.
- [x] CI tests and debug APK build pass (run 41589026255).
- [ ] Real Android phone launcher and Android TV / Fire TV launcher screenshots reviewed.
- [ ] Final screenshots show PRYNCE TV clearly and do not imply affiliation with another broadcaster or TV service.

## Release and rights
PRYNCE TV is a media player. It must not bundle channels or copyrighted programme thumbnails without permission. Use only artwork owned by the project or licensed for the intended use. Preserve OpenTV GPL-3.0-or-later notices and corresponding-source obligations for redistributed modified builds.
