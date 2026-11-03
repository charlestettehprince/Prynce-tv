# PRYNCE TV — Consolidated Build Plan

Last verified: 3 November 2026

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
5. **CI verification:** both latest runs completed successfully:
   - Run 41566614327: all steps passed; artifact `prynce-tv-v0.11.10-debug`, 28,885,069 bytes.
   - Run 41566629123: all steps passed; artifact `prynce-tv-v0.11.10-debug`, 28,885,068 bytes.
   - Both artifacts expire 17 November 2026.
   - The successful run proves tests/build/artifact upload in CI only.

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
