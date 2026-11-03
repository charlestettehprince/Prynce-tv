# PRYNCE TV — Single Project Status

**Last consolidated:** 3 November 2026  
**Repository:** `charlestettehprince/Prynce-tv`  
**Primary Android engine:** OpenTV v0.11.10, pinned upstream commit `443811904b6437720d37bb1064c0830906c3515f`  
**Project estimate:** **78%** (rough planning estimate; not a measured completion score)

## Executive summary

PRYNCE TV is being developed as one Android app for phones, Android TV and Fire TV. The project uses the existing OpenTV open-source Android foundation rather than migrating to a second engine without a technical reason. The app is a media player, not a channel provider: viewers must supply sources they are entitled to use.

## Decisions — keep these stable

1. Keep OpenTV as the primary engine. It already supports Android TV/Fire TV and phone/tablet form factors, M3U/M3U8 and Xtream sources, XMLTV guide data, playback and TV remote navigation.
2. Do not migrate to OpenIPTV, OwnTV or OpenTV Mobile unless a reproducible requirement cannot be met by the current foundation.
3. Preserve the exact original PRYNCE icon and wordmark. Do not trace, redraw, generate or recolour the supplied artwork.
4. Reuse the existing Android TV manifest/banner plumbing; PRYNCE launcher icon and 320×180 TV banner are now committed and injected by CI.
5. Use CI to build and test; use physical devices to prove phone and TV behaviour. Never treat CI success as hardware acceptance.
6. Use only free-to-air/public streams or playlists and provider accounts the viewer is authorised to access. Do not bypass DRM, authentication, subscriptions, geographic restrictions or broadcaster controls.

## Verified implementation

- OpenTV is pinned as a Git submodule at `android/upstream`.
- Android build workflow: `.github/workflows/android-baseline.yml`.
- Workflow configures Java 17 and Android SDK 35, installs the committed PRYNCE TV JPEG icon/banner into the upstream drawable slots, applies app-name and black/gold theme substitutions, runs `./gradlew test assembleDebug --no-daemon`, and uploads a debug APK.
- Upstream manifest has both standard `LAUNCHER` and `LEANBACK_LAUNCHER` activities, optional leanback/touchscreen features, `android:icon="@drawable/ic_launcher"`, and `android:banner="@drawable/banner"`.
- Upstream v0.11.9+ changelog records a 320×180 TV banner and density-specific PNG launcher icons to improve Android TV/Fire TV launcher visibility. Our pinned v0.11.10 source includes the corresponding drawable resource paths.
- Added `docs/CHANNEL_SOURCE_GUIDE.md`.
- Added `docs/DEVICE_ACCEPTANCE_CHECKLIST.md`.
- Added this consolidated status file.
- CI workflow now uses a concurrency group to cancel superseded runs on the same ref; verify each run's final result rather than assuming it was cancelled.
- Committed exact-source-derived launcher artwork: `branding/prynce_tv_icon.jpg` (128×128) and `branding/prynce_tv_banner.jpg` (320×180). These are resized/compressed derivatives; the original artwork itself was not redrawn or recoloured.
- The CI copies the committed artwork into `app/src/main/res/drawable/ic_launcher.jpg` and `banner.jpg`, removes conflicting upstream defaults, then validates both manifest references and builds.

## CI evidence

Latest confirmed successful build:
- Run `41589652107`, commit `1bc57ca62e9b74a97e842f6dd49f7cc17ecff0f2`.
- All workflow steps passed: launcher artwork install, launcher resource validation, tests, debug APK build and artifact upload.
- Artifact: `prynce-tv-v0.11.10-debug`, 28,885,356 bytes (about 28.9 MB), retained by GitHub Actions for 14 days.
- [Open successful GitHub Actions run](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41589026255).

Earlier unsuccessful branding experiments were diagnosed and corrected; the latest run above is the passing build. CI success is not proof of physical-device playback or launcher appearance.

## Remaining acceptance gates

### A. PRYNCE launcher branding — CI INTEGRATED; DEVICE VISUAL CHECK PENDING
- Committed original-derived icon and TV banner in `branding/`.
- CI copies them into the exact drawable resources referenced by the upstream manifest and removes conflicting default assets.
- Latest CI build passes with both launcher resource checks.
- In-app wordmark placement and real launcher screenshots still need review.

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

Only mark a task complete when its implementation or test evidence exists. Distinguish source inspection, CI success, emulator testing and physical-device testing. Keep the estimate as a rough planning figure; raise it only when implementation or acceptance evidence justifies the change.
