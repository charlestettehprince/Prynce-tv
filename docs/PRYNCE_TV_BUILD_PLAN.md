# PRYNCE TV — Consolidated Build Plan

Last verified: 3 November 2026

## Current Android 16 migration status — 3 November 2026

- Migration commit: `29dbd77d28bf8180558d5f45166d76059965badc`; [GitHub Actions run 41617047320](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41617047320).
- Passed in CI: AGP 8.9.1 / compileSdk 36 / targetSdk 36 migration step, Android SDK 36 installation, Ghana directory validation, phone/TV launcher checks, updater configuration, branding and navigation integration.
- The automated test and APK/AAB build step remains in progress. There is no verified API 36 artifact yet.
- Previous API 35 test APK remains available as fallback only; it is not a Play-ready phone/tablet package.
- Next action: recheck workflow and artifacts, diagnose only from actual build logs, then independently verify package metadata, signature, checksums and 16 KB native alignment. Physical-device acceptance remains separate.

## Product direction

A premium media-player experience for Android phones, Android TV and Fire TV. Design direction: near-black surfaces, restrained gold accents, readable typography, accessible touch targets and reliable remote navigation.

## Technical baseline

- Primary engine: OpenTV v0.11.10.
- Pinned upstream commit: `443811904b6437720d37bb1064c0830906c3515f`.
- Tracked at `android/upstream` as a Git submodule.
- Upstream licence: GPL-3.0-or-later. Preserve notices and comply with corresponding-source obligations for distributed modifications.
- Upstream minimum SDK: 23. The first physical-device target is Android 11+.
- Current deliverable: CI-built debug APK for controlled testing. This is not a production-signed release.
- Keep the upstream application ID until a deliberate package migration and signing/update plan is approved.

## Verified work completed

1. **Source foundation:** pinned OpenTV submodule is tracked in the PRYNCE TV repository.
2. **Build automation:** GitHub Actions checks out the submodule, configures Java 17 and Android SDK 35, applies current black/gold build-time changes, runs Gradle tests and builds a debug APK.
3. **Channel-source groundwork:** source guide documents authorised M3U/M3U8 and provider sources, EPG, error states, credential handling and reliability checks.
4. **Engine evaluation:** reviewed OpenTV, OpenIPTV, OwnTV and OpenTV Mobile. OpenTV remains the best current single foundation for phone + TV; no migration is justified while it builds.
5. **CI verification:** latest confirmed successful baseline is run 41567118208 (commit `d34010c`); Gradle tests, debug APK build and artifact upload passed. Artifact: `prynce-tv-v0.11.10-debug`, approximately 28.9 MB. The two documentation-only runs for the device checklist (41567633078 and README link update 41567642427) were still in progress at the last check on 3 November 2026. CI success proves the configured tests/build/artifact upload only.
6. **Acceptance documentation:** added `docs/DEVICE_ACCEPTANCE_CHECKLIST.md` (commit `e923583`) and linked it from README (commit `ad9bf63`). It defines phone, TV, authorized-source playback, branding and release checks.

## Android TV launcher audit (source-verified)

The pinned OpenTV source already declares:
- `android:banner="@drawable/banner"` and `android:icon="@drawable/ic_launcher"` on the application.
- Both `LEANBACK_LAUNCHER` and standard `LAUNCHER` intent categories.
- `android.software.leanback` and `android.hardware.touchscreen` as optional features, supporting a shared phone/TV APK.
- PNG launcher and banner assets in drawable density folders.

This means the Android TV banner plumbing is already present in the pinned source; a new manifest implementation is not needed. The remaining branding task is to replace the upstream artwork with the user's exact approved PRYNCE icon and wordmark, retaining the required Android TV banner dimensions and launcher resource paths. This source audit does not prove the artwork renders correctly on a physical TV.

## Work still open — acceptance gates

### A. Exact brand assets
- Use the original icon and horizontal logo supplied by the user; do not redraw, trace, generate or substitute them.
- Integrate the exact icon into Android adaptive and legacy launcher resources.
- Prepare a separate Android TV banner using the same original brand artwork.
- Inspect the resulting launcher, splash and in-app brand on actual device screenshots.
- Current status: **not complete**. The current upstream-derived launcher mark is provisional.

### B. Phone validation
- Install on an Android 11+ phone.
- Verify first launch, add-source flow, M3U import, permitted provider login, channel playback, search, favourites, EPG, back navigation and recovery from network failures.
- Record device model, Android version, test source type (no passwords), outcome and reproducible issues.
- Current status: **not tested on physical hardware**.

### C. TV validation
- Install on Android TV or Fire TV hardware.
- Test remote focus order, visible focus states, back/exit behaviour, readable distance, overscan/layout, source setup and playback.
- Current status: **not tested on physical hardware**.

### D. Release readiness
- Create a secure persistent release-signing key; never commit the key or passwords.
- Set versioning and upgrade strategy.
- Prepare privacy disclosures and a support route.
- Package GPL notices and corresponding source for any distributed modified build.
- Current status: **not release-ready**.

## Content and security boundary

PRYNCE TV is a player, not a channel supplier. It must not bundle unauthorised playlists or bypass DRM, subscriptions, provider authentication, account controls or geographic restrictions. Use official free-to-air streams or other sources the viewer is entitled to access. Keep provider credentials out of logs and analytics.

## Project status reporting rules

- CI success is not physical-device success.
- A feature in upstream source is not proof it has been tested in the PRYNCE TV branded build.
- A written plan is not an implemented feature.
- Report each acceptance gate as complete only when its evidence exists.
- Do not claim universal channel availability.
- Current user-supplied rough progress estimate: **68%**. This is a planning estimate, not a measured completion score.
