# PRYNCE TV — repository operations map

Last reviewed: 2026-11-03

## Repository layout

| Path | Purpose | Change policy |
|---|---|---|
| `.github/workflows/` | CI automation: checkout, artwork preparation, Android validation, build and artifact upload | Keep workflow steps deterministic; validate source assets before transforming them |
| `android/upstream/` | Pinned OpenTV Android source submodule | Do not casually fork/replace; preserve upstream notices and record any pin changes |
| `branding/` | Owner-supplied original PRYNCE icon, banner and wordmark assets | Treat originals as source-of-truth; never redraw or recolour |
| `docs/` | Build, brand, source, licence, QA and project-status documentation | Update status whenever evidence changes |
| `README.md` | Project entry point and navigation to key documentation | Keep build state and source-asset names accurate |
| `.gitmodules` | Upstream engine source mapping | Keep pinned upstream repository explicit |

## Current technical baseline

- Product: PRYNCE TV, a media player for supported Android phones/tablets and Android TV devices.
- Engine: OpenTV v0.11.10, pinned through `android/upstream`.
- Upstream commit: `443811904b6437720d37bb1064c0830906c3515f`.
- Branding direction: near-black/navy with gold accents; use the exact owner-provided artwork.
- Content rule: no bundled channel lists. Users connect only sources they are authorised to access.
- Build outputs: debug APK for controlled testing and AAB for a future Google Play submission. A debug APK is not a production release.

## Service and feature health — evidence-based

| Service / capability | Current evidence | Status |
|---|---|---|
| Source checkout and pinned engine | Earlier CI run checked out the pinned submodule | Verified in CI history |
| Artwork preparation | Earlier JPEG source caused image decode failure; workflow now references existing PNG files | Pending fresh CI validation |
| Android build and automated tests | Earlier branded debug build succeeded before recent artwork workflow edits | Prior success only; latest commit unverified |
| APK artifact delivery | Previous run uploaded a debug APK artifact | Prior success only |
| AAB generation | Workflow requests `bundleRelease` | Not yet confirmed for current commit |
| Phone launcher | Manifest check exists in CI | CI declaration check only; physical install pending |
| Android TV launcher/banner | Manifest and image-dimension checks exist in CI | CI checks pending; TV visual test pending |
| Fire TV | Android compatibility is intended | Not device-verified |
| Playlist/provider connection | Upstream engine supports supported playlist/provider formats | Must test with a lawful user-authorised source |
| EPG/program guide | Upstream supports XMLTV | Must test with a valid guide source |
| Playback, seeking, audio and subtitles | Depends on stream format, provider and device decoder | Not end-to-end verified |
| Favourites, history, search and categories | Upstream product capabilities | Feature-by-feature regression test pending |
| DVR/catch-up/reminders/PiP | Conditional on upstream implementation, provider and device | Do not advertise as universally available |
| Privacy, analytics, crash reporting, cloud sync | No separate PRYNCE service integration confirmed in this repository review | Not configured/verified; do not imply enabled |
| Release signing and distribution | No production signing setup verified | Pending; never commit signing keys |

## Next execution order

1. Run CI on the latest commit and inspect the first failing step, if any.
2. Validate the PNG source files themselves before generating launcher resources. Fail with a clear message if either source cannot be decoded.
3. Build debug APK and release AAB; record SHA-256 checksums and artifact sizes.
4. Inspect APK/AAB metadata, package ID, min/target SDK, permissions, supported ABIs and signing state.
5. Test on a physical Android 11+ phone/tablet and Android TV/Fire TV hardware. Use a lawful test playlist/provider and test EPG separately.
6. Complete privacy, support, licence notices, source-distribution and production-signing review before public release.

## Definition of done

A feature is marked working only when there is reproducible evidence: automated test output, build artifact inspection, or a recorded physical-device test. A workflow containing a task is not proof that the service works. Keep untested items labelled pending.

## Security and open-source policy

- Keep the OpenTV upstream licence and copyright notices intact.
- Review the exact upstream and dependency licences before distributing modified binaries.
- Do not store provider credentials, signing keys, passwords or private API tokens in source control.
- Use Gradle dependency verification after a reviewed baseline is generated; never blindly trust generated checksums.
- Preserve authentication, DRM, subscription, broadcaster and regional restrictions. The app is a player, not a source of free access to paid content.
