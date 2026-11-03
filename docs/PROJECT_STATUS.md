# PRYNCE TV — Single Project Status

**Last consolidated:** 3 November 2026  
**Repository:** `charlestettehprince/Prynce-tv`  
**Primary Android engine:** OpenTV v0.11.10, pinned upstream commit `443811904b6437720d37bb1064c0830906c3515f`  
**Latest verified CI commit:** `85755852ecb5dbb285578bf4ce7d42469b7c33cb`  
**Project estimate:** **90%** (rough planning estimate, not a measured completion score)

## Executive summary

PRYNCE TV is a single Android media-player project for compatible phones/tablets and Android TV/Fire TV devices. The branded debug APK and release AAB have been built successfully by CI. The current workflow artifact was downloaded and independently checked: both archives pass ZIP integrity checks, both checksums match the workflow checksum file, and native LOAD segments in both APK and AAB use 16 KB alignment. Physical-device acceptance, production signing and release compliance remain outstanding.

PRYNCE TV is a player, not a broadcaster or channel subscription service. Users must supply sources they are authorised to access. The app must not circumvent DRM, authentication, subscriptions, geographic restrictions or broadcaster controls.

## Stable technical decisions

1. Keep OpenTV v0.11.10 as the primary engine. It already targets phone/tablet and Android TV/Fire TV form factors and is integrated into the existing branded repository.
2. Do not migrate to another engine for a speculative speed gain. Reconsider only for a reproducible blocker that cannot reasonably be fixed, after build, device and licence evaluation.
3. Preserve the exact original PRYNCE icon and wordmark supplied by the project owner. Do not trace, redraw, generate or recolour the artwork.
4. Keep the pinned upstream submodule and record any reviewed pin changes.
5. Use CI for reproducible build/test evidence and physical devices for acceptance. CI success is not hardware acceptance.
6. Use only sources the viewer is authorised to access.

## Verified implementation and build

- OpenTV is pinned as a Git submodule at `android/upstream`.
- Upstream commit: `443811904b6437720d37bb1064c0830906c3515f`.
- CI workflow: `.github/workflows/android-baseline.yml`.
- Latest successful workflow run: [41608997572](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41608997572).
- Workflow job: Build PRYNCE TV branded Android app (all steps succeeded).
- Build commit: `85755852ecb5dbb285578bf4ce7d42469b7c33cb`.
- All workflow steps succeeded, including original SVG artwork rendering, Android resource/launcher validation, tests, debug APK and release AAB builds, checksum generation and artifact upload.
- Artifact: `prynce-tv-v0.11.10-test-packages` (ID `13218217574`), 38,794,916 bytes; created 3 November 2026 and expires 1 February 2027. Artifact SHA-256: `b0c83c219468987e36caf9a20901d54770b6dfcbd98a29177d7bf9b40394ef2e`.
- APK SHA-256: `259ff4b0ae159061990d8a6e42d9f419e20ec3994e3c44e4d03983feabf898b0`.
- AAB SHA-256: `be554bca6a2efd57d1ea4cf1c529c6a8a82d857c6f285d06ea3e97dc152bb39e`.
- APK and AAB ZIP integrity checks passed; computed checksums match the included workflow checksum file.
- APK contains ARM64, ARMv7, x86 and x86_64 native libraries. The APK's native LOAD segments were inspected and use 16 KB alignment. The AAB's embedded native libraries were also extracted and inspected; all LOAD segments across ARM64, ARMv7, x86 and x86_64 libraries use 16 KB alignment.
- CI checks both standard `LAUNCHER` and `LEANBACK_LAUNCHER` categories and validates launcher artwork resources.
- The debug APK is for controlled testing, not production distribution. The AAB is for Play submission preparation, not direct installation.

## Open-source engine decision

The current OpenTV foundation remains the best fit for the stated one-app phone + TV requirement and the lowest-risk path because it is already integrated and building. OpenIPTV and OwnTV remain reference alternatives only; neither has demonstrated a reason to replace the current engine. The current decision and trade-offs are documented in `docs/OPEN_SOURCE_ALTERNATIVES_REVIEW.md`.

## Universal update workstream — architecture selected, implementation pending

- Added `docs/UNIVERSAL_UPDATE_ARCHITECTURE.md` and linked it from the README.
- Phones/tablets: plan official Google Play flexible updates for routine releases and immediate updates only for critical releases when allowed.
- Android TV: use Google Play store-managed delivery; the official Play in-app update API is documented for phones, tablets and ChromeOS, not Android TV.
- Fire TV: use the store channel through which the app is distributed; do not assume Google Play services are present.
- All devices: remotely refresh only validated, non-executable content/configuration; native player changes still require a signed app release.
- **Initial source integration:** the pinned OpenTV source already includes a release checker, APK downloader, system-installer handoff and update gate. CI now configures the checker to read releases from `charlestettehprince/Prynce-tv` and uses PRYNCE TV prompt branding. The PRYNCE release-repository configuration and branded updater prompts passed the latest successful CI build; actual update installation and platform store flows remain untested on physical devices.
- **Still pending:** signed PRYNCE releases, Play/Amazon store release configuration, remote non-executable configuration manifest, and separate phone/Android TV/Fire TV acceptance tests.

## Acceptance status

| Area | Evidence | Status |
|---|---|---|
| Source checkout and pinned engine | CI checks out the pinned submodule | Verified in CI |
| Original artwork rendering | CI rendered launcher assets from owner-supplied SVG sources | Verified in CI |
| Android automated tests/build | Latest workflow succeeded | Verified in CI |
| APK and AAB archive integrity | Independent ZIP checks passed | Verified |
| APK/AAB checksums | Match recorded SHA-256 values | Verified |
| APK native 16 KB alignment | Native LOAD segments inspected | Verified for APK |
| AAB native 16 KB alignment | Not independently inspected | Pending |\n| Phone sideload update integration | Existing updater configured in CI for PRYNCE releases; build/device test pending | In progress |\n| Android TV store update path | Store-managed architecture documented; store/device validation pending | Pending |\n| Fire TV store update path | Architecture documented; store/device validation pending | Pending |\n| Remote content/config manifest | Architecture documented; client/server not integrated | Pending |
| Phone launcher declaration/resources | CI manifest/resource checks passed | CI only; device pending |
| Android TV launcher declaration/banner resources | CI checks passed | CI only; visual device check pending |
| Physical Android phone installation | No recorded device result | Pending |
| Physical Android TV / Fire TV navigation | No recorded device result | Pending |
| Authorised playlist/provider playback | No end-to-end device result | Pending |
| EPG, favourites, history, search, audio/subtitles | Requires feature regression testing | Pending |
| Privacy disclosures and support information | Not fully release-reviewed | Pending |
| GPL notices and corresponding-source package | Review required before binary distribution | Pending |
| Production signing and store submission | Not configured/verified | Pending |

## Next execution order

1. Install the debug APK on a physical Android 11+ phone/tablet. Record device model, Android version, app launch, navigation, stability and authorised-source playback.
2. Test Android TV D-pad navigation, launcher icon/banner visibility and playback on real TV hardware; test Fire TV separately if intended.
3. Exercise source import, invalid-source handling, XMLTV guide, favourites, history, search, audio/subtitle selection and network recovery.
4. Complete package ID, SDK, permission and signing inspection; the AAB's embedded native libraries now pass 16 KB LOAD alignment inspection.
5. Review package ID, min/target SDK, permissions, privacy disclosures, support route and store requirements.
6. Complete GPL-3.0-or-later notices and corresponding-source obligations, dependency licence review and secure production signing before any public distribution.

## Definition of done

A feature is complete only with reproducible evidence: automated test output, artifact inspection or a recorded physical-device test. Keep untested items labelled pending. Never describe a CI-only result as device-tested.

## Security and open-source policy

- OpenTV is GPL-3.0-or-later. Preserve upstream notices, review all bundled dependency licences and meet corresponding-source obligations when distributing modified binaries.
- Do not store provider credentials, signing keys, passwords or private API tokens in source control.
- Keep signing keys outside the repository and use a secure release process.
- Preserve authentication, DRM, subscription, broadcaster and regional restrictions.
