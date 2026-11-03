# PRYNCE TV — repository operations map

Last reviewed: 2026-11-03

## Repository layout

| Path | Purpose | Change policy |
|---|---|---|
| `.github/workflows/` | CI automation: checkout, artwork preparation, Android validation, build and artifact upload | Keep workflow steps deterministic; validate source assets before transforming them |
| `android/upstream/` | Pinned OpenTV Android source submodule | Do not casually fork/replace; preserve upstream notices and record any pin changes |
| `branding/` | Owner-supplied original PRYNCE icon and wordmark assets | Treat originals as source-of-truth; never redraw or recolour |
| `docs/` | Build, brand, source, licence, QA and project-status documentation | Update status whenever evidence changes |
| `.gitmodules` | Upstream engine source mapping | Keep pinned upstream repository explicit |
| `README.md` | Project entry point and navigation to key documentation | Keep build state and source-asset names accurate |

## Current technical baseline

- Product: PRYNCE TV, a media player for supported Android phones/tablets and Android TV devices.
- Engine: OpenTV v0.11.10, pinned through `android/upstream`.
- Upstream commit: `443811904b6437720d37bb1064c0830906c3515f`.
- Branding direction: near-black/navy with gold accents; use the exact owner-provided artwork.
- Content rule: no bundled channel lists. Users connect only sources they are authorised to access.
- Build outputs: debug APK for controlled testing and AAB for a future Google Play submission. A debug APK is not a production release.

## Latest verified CI evidence

- Workflow run: [41600670820](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41600670820)
- Commit: `8ea86e1a1221ca74a24dd6488457fe127be3d51b`
- Job: `125798380153`
- Result: all workflow steps succeeded, including original artwork rendering, Android resource/launcher checks, automated tests, APK/AAB build, checksums and artifact upload.
- Artifact: `prynce-tv-v0.11.10-test-packages` (38,763,553 bytes); GitHub artifact retention is temporary.
- APK SHA-256: `99b787f280ea885a26df193072d00defbf352c3774b1155b2df56afdd4cffa6a`.
- AAB SHA-256: `40275243402a52288cf9d6f96f44c902cba7c337ab07d92d350ede725e335a44`.
- Independent checks: APK and AAB ZIP integrity passed; checksums match; APK native libraries inspected for 16 KB LOAD-segment alignment; APK includes ARM64, ARMv7, x86 and x86_64 native libraries.
- APK is a debug build for controlled testing. AAB is a Play submission package, not an installable APK.

## Service and feature health — evidence-based

| Service / capability | Current evidence | Status |
|---|---|---|
| Source checkout and pinned engine | CI checks out the pinned submodule | Verified in CI |
| Original artwork rendering | CI rendered launcher resources from owner-supplied SVG assets | Verified in CI |
| Android build and automated tests | Latest workflow completed successfully | Verified in CI |
| APK artifact delivery | Latest workflow uploaded APK/AAB test package | Verified in CI |
| APK integrity and checksum | ZIP integrity and SHA-256 independently checked | Verified |
| AAB integrity and checksum | ZIP integrity and SHA-256 independently checked | Verified |
| APK native library 16 KB alignment | APK LOAD segments inspected with readelf | Verified for APK only |
| Phone launcher | Manifest/resource validation passed in CI | CI check only; physical install pending |
| Android TV launcher/banner | Launcher category and artwork resource checks passed in CI | CI check only; TV visual test pending |
| Fire TV | Android compatibility is intended | Not device-verified |
| Playlist/provider connection | Upstream supports supported playlist/provider formats | Must test with a lawful user-authorised source |
| EPG/program guide | Upstream supports XMLTV | Must test with a valid guide source |
| Playback, seeking, audio and subtitles | Depends on stream format, provider and device decoder | Not end-to-end verified |
| Favourites, history, search and categories | Upstream product capabilities | Feature-by-feature regression test pending |
| DVR/catch-up/reminders/PiP | Conditional on upstream implementation, provider and device | Do not advertise as universally available |
| Privacy, analytics, crash reporting, cloud sync | No separate PRYNCE service integration confirmed | Not configured/verified; do not imply enabled |
| Release signing and distribution | Production signing setup not verified | Pending; never commit signing keys |
| AAB native library alignment | Not independently inspected in this validation pass | Pending |

## Next execution order

1. Install the debug APK on a physical Android 11+ phone/tablet and record startup, navigation, stability and playback results using an authorised test source.
2. Test Android TV remote navigation, launcher artwork and playback on actual TV hardware; test Fire TV separately if supported hardware is available.
3. Test playlist import, provider sign-in, XMLTV guide, favourites, history, search, audio/subtitle selection and error handling.
4. Inspect package ID, min/target SDK, permissions and debug signing metadata from the installed package/build outputs.
5. Complete privacy, support, licence notices, source-distribution and production-signing review before public release.
6. Inspect AAB native libraries separately before making any AAB 16 KB compatibility claim.

## Definition of done

A feature is marked working only when there is reproducible evidence: automated test output, build artifact inspection, or a recorded physical-device test. A workflow containing a task is not proof that the service works. Keep untested items labelled pending.

## Security and open-source policy

- OpenTV is GPL-3.0-or-later. Preserve upstream copyright and licence notices, review all bundled dependency licences, and meet corresponding-source obligations when distributing modified binaries.
- Confirm the exact source and licence package to distribute with each release; do not assume the repository's top-level documentation alone fulfils every distribution obligation.
- Do not store provider credentials, signing keys, passwords or private API tokens in source control.
- Use Gradle dependency verification after a reviewed baseline is generated; never blindly trust generated checksums.
- Preserve authentication, DRM, subscription, broadcaster and regional restrictions. The app is a player, not a source of free access to paid content.
