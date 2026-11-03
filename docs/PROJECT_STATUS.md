# PRYNCE TV — Single Project Status

**Last consolidated:** 3 November 2026  
**Repository:** `charlestettehprince/Prynce-tv`  
**Primary Android engine:** OpenTV v0.11.10, pinned upstream commit `443811904b6437720d37bb1064c0830906c3515f`  
**Project estimate:** **68%** (user-requested rough planning estimate; not a measured completion score)

## Executive summary

PRYNCE TV is being developed as one Android app for phones, Android TV and Fire TV. The project uses the existing OpenTV open-source Android foundation rather than migrating to a second engine without a technical reason. The app is a media player, not a channel provider: viewers must supply sources they are entitled to use.

## Decisions — keep these stable

1. Keep OpenTV as the primary engine. It already supports Android TV/Fire TV and phone/tablet form factors, M3U/M3U8 and Xtream sources, XMLTV guide data, playback and TV remote navigation.
2. Do not migrate to OpenIPTV, OwnTV or OpenTV Mobile unless a reproducible requirement cannot be met by the current foundation.
3. Preserve the exact original PRYNCE icon and wordmark. Do not trace, redraw, generate or recolour the supplied artwork.
4. Reuse the existing Android TV manifest/banner plumbing and replace only the artwork/resources after the approved original files are safely committed.
5. Use CI to build and test; use physical devices to prove phone and TV behaviour. Never treat CI success as hardware acceptance.
6. Use only free-to-air/public streams or playlists and provider accounts the viewer is authorised to access. Do not bypass DRM, authentication, subscriptions, geographic restrictions or broadcaster controls.

## Verified implementation

- OpenTV is pinned as a Git submodule at `android/upstream`.
- Android build workflow: `.github/workflows/android-baseline.yml`.
- Workflow configures Java 17 and Android SDK 35, applies PRYNCE TV app-name and black/gold theme substitutions, runs `./gradlew test assembleDebug --no-daemon`, and uploads a debug APK.
- Upstream manifest has both standard `LAUNCHER` and `LEANBACK_LAUNCHER` activities, optional leanback/touchscreen features, `android:icon="@drawable/ic_launcher"`, and `android:banner="@drawable/banner"`.
- Upstream v0.11.9+ changelog records a 320×180 TV banner and density-specific PNG launcher icons to improve Android TV/Fire TV launcher visibility. Our pinned v0.11.10 source includes the corresponding drawable resource paths.
- Added `docs/CHANNEL_SOURCE_GUIDE.md`.
- Added `docs/DEVICE_ACCEPTANCE_CHECKLIST.md`.
- Added this consolidated status file.
- CI workflow now uses a concurrency group to cancel superseded runs on the same ref; verify each run's final result rather than assuming it was cancelled.

## CI evidence

Latest confirmed successful build at the time of consolidation:
- Run `41567118208`, commit `d34010c161d35753ae0817b16c79a0b785317fcd`.
- Gradle test/build and artifact upload passed.
- Artifact name: `prynce-tv-v0.11.10-debug`, approximately 28.9 MB.

Documentation/build runs:
- `41567633078` — passed.
- `41567642427` — passed.
- `41567720241` — passed.
- `41567826490` — in progress at last check.
- `41567935481` — in progress at last check.
  
CI results prove only the configured automated test/build/artifact steps. They do not prove installation, playback, remote navigation, or visual correctness on real devices.

## Remaining acceptance gates

### A. Exact PRYNCE branding — BLOCKED
- Original square icon and horizontal wordmark have been supplied in the conversation.
- They are not yet verified as binary assets in this repository.
- Commit exact files without modifying their artwork.
- Map the icon to Android launcher drawable density resources and the wordmark to a suitable app-brand surface.
- Use the existing 320×180 banner slot for a separately composed TV banner using the exact logo artwork; preserve source artwork.
- Rebuild and inspect actual launcher screenshots.

### B. Physical phone test — NOT TESTED
- Install on Android 11+ phone.
- Check launch, source add/edit/remove, valid/invalid playlist handling, playback from an authorised test source, guide, search, favourites, rotation and network recovery.

### C. Android TV / Fire TV test — NOT TESTED
- Install on physical hardware.
- Check launcher tile/banner visibility, D-pad focus order, Back behaviour, readable UI at viewing distance and playback controls without touch.

### D. Release readiness — NOT READY
- Decide application ID/package migration only with an update/signing plan.
- Set up secure release signing; never commit keystores or passwords.
- Review privacy disclosures, support route and GPL-3.0-or-later notice/source obligations.
- Run the complete acceptance checklist and record device/source test evidence.

## Project file map

- `README.md` — project entry point and links.
- `docs/PROJECT_STATUS.md` — single consolidated status (this file).
- `docs/PRYNCE_TV_BUILD_PLAN.md` — technical direction and release gates.
- `docs/DEVICE_ACCEPTANCE_CHECKLIST.md` — phone/TV test steps.
- `docs/CHANNEL_SOURCE_GUIDE.md` — permitted source setup and troubleshooting.
- `.github/workflows/android-baseline.yml` — CI build.

## Reporting standard

Only mark a task complete when its implementation or test evidence exists. Distinguish source inspection, CI success, emulator testing and physical-device testing. Keep the user-requested estimate at 68% until meaningful implementation or acceptance evidence justifies changing it.
