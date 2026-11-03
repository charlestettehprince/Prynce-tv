# PRYNCE TV — Brand asset integration

## Brand source of truth
- Product: **PRYNCE TV**
- Tagline: **Beyond ordinary.**
- Visual system: deep navy / near-black with restrained gold accents.
- Artwork source: `branding/prynce_icon.svg` and `branding/prynce_wordmark.svg`.
- Preserve the supplied artwork. Do not redraw, replace, distort or recolour it.

## Where the brand is integrated by CI

The Android build workflow renders the committed original SVG artwork during every branded build and installs these assets into the pinned OpenTV Android project:

1. **Phone/tablet launcher:** `@drawable/ic_launcher` uses the PRYNCE icon.
2. **Android TV / Fire TV launcher banner:** `@drawable/banner` combines the PRYNCE icon and wordmark on the approved dark navy/gold background.
3. **In-app navigation rail mark:** `R.drawable.ic_prynce_brand` uses the original PRYNCE icon.
4. **Expanded in-app navigation rail wordmark:** `R.drawable.ic_prynce_wordmark` uses the original white PRYNCE wordmark, rather than generic upstream text.
5. **App identity:** Android app label and exit prompt use **PRYNCE TV**.
6. **Theme accents:** primary brand accents are changed to the approved gold palette.
7. **Repository/store/share artwork source:** the original SVG assets remain committed under `branding/` for consistent reuse.

The source SVGs are rendered to PNG during CI. Generated files are build outputs and do not overwrite the source artwork.

## Brand placement still requiring separate work

- Notification small icons still use the upstream notification glyph. Android notification icons need a purpose-built simple monochrome asset; do not reuse the full-colour launcher tile as a notification glyph.
- Adaptive launcher icon layers and monochrome themed-icon variant have not yet been implemented. The current launcher artwork is wired through the app's existing drawable reference; do not claim adaptive/themed icon support until implemented and checked.
- Store listing artwork and a public download page have not been published.
- Actual screenshots from a physical Android phone and Android TV / Fire TV device have not yet been reviewed.

## CI validation

The workflow validates the launcher icon and banner dimensions, checks the Android manifest's phone and Leanback launcher declarations and referenced drawable resources, and compiles the branded app. The new in-app navigation patch also fails the build if the PRYNCE icon or wordmark references are missing.

A passing CI build verifies compilation and static resource wiring. It does not prove how the assets look on every launcher, screen density, remote-control interface or device. Physical-device screenshots remain required.

## Acceptance checklist

- [x] Original PRYNCE icon and wordmark committed in vector form.
- [x] CI renders original artwork into Android build resources.
- [x] Launcher icon uses PRYNCE artwork.
- [x] Android TV banner uses PRYNCE icon and wordmark.
- [x] In-app navigation rail uses PRYNCE icon and original wordmark.
- [x] App label and gold theme accents use PRYNCE identity.
- [ ] Add a purpose-built monochrome PRYNCE notification icon.
- [ ] Add and validate adaptive launcher and themed monochrome icon assets.
- [ ] Review phone, Android TV and Fire TV screenshots.
- [ ] Publish approved store artwork and a public tester/release landing page.

## Release and rights
PRYNCE TV is a media player, not a broadcaster. Use only artwork owned by the project or licensed for the intended use. Do not imply affiliation with broadcasters or TV services. Preserve OpenTV GPL-3.0-or-later notices and corresponding-source obligations for redistributed modified builds.
