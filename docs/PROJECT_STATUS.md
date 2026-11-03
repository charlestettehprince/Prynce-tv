# PRYNCE TV — Single Project Status

**Last consolidated:** 3 November 2026  
**Repository:** `charlestettehprince/Prynce-tv`  
**Primary Android engine:** OpenTV v0.11.10, pinned upstream commit `443811904b6437720d37bb1064c0830906c3515f`  
**Latest verified CI commit:** `29dbd77d28bf8180558d5f45166d76059965badc`  
**Latest status-documentation commits:** `5455814a30fdbed4af3bdef359b83941f2762aec`  
**Project estimate:** **92%** (rough planning estimate, not a measured completion score)

## Current Android 16 migration — authoritative latest status

- Latest migration commit: `29dbd77d28bf8180558d5f45166d76059965badc` (CI workflow run [41617047320](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41617047320)).
- **Build completed successfully:** automated tests, APK/AAB compilation, package metadata/signing report, checksums and artifact upload all passed.
- Artifact: `prynce-tv-v0.11.10-test-packages`, ID `13222900025`, expires 1 February 2027.
- APK metadata: `app.opentv.debug`, version `0.11.10` / code `22`, min SDK `23`, compile SDK `36`, target SDK `36`.
- APK SHA-256: `db59de9f5e7ac6157dd934b0e127366cb75b34b674e3b6ee6e11489bc766f731`; AAB SHA-256: `d5a537f900acfb8f23d1a10c1e9a06aeb4b039f5de641286c7cdbc27d742e257`. Archive integrity and APK signature verification passed.
- Both the APK and AAB use the Android Debug certificate (AAB JAR signature also inspected with `jarsigner`). These are test/preparation artifacts, not production-signed public release packages.
- The workflow log endpoint returned BlobNotFound during follow-up, but the completed run, uploaded artifact, metadata report and checksum file were available and independently inspected.
- Independent follow-up verification: APK and AAB ZIP integrity passed; all 8 native libraries in each package have ELF PT_LOAD alignment of 16 KB; all 8 uncompressed native libraries inside the APK also start at 16 KB-aligned ZIP data offsets. APK/AAB checksums match the CI checksum manifest.
- Physical phone/TV testing, production signing and privacy/licence review remain open.

## Executive summary

PRYNCE TV is a single Android media-player project for compatible phones/tablets and Android TV/Fire TV devices. The branded debug APK and release AAB have been built successfully by CI. The latest workflow artifact was downloaded and independently checked: both archives pass ZIP integrity checks and both package checksums match the workflow checksum file. The latest API 36 workflow package report confirms debug package `app.opentv.debug`, version `0.11.10` (code 22), min SDK 23, compile SDK 36 and target SDK 36. APK signature verification passed, but the signer is the standard Android Debug certificate, not a production signing identity. The combined phone/TV Play target API requirement is met by this test build; public submission is still blocked by production signing, physical-device acceptance, privacy and licence review. Physical-device acceptance, production signing and release compliance remain outstanding.

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
- Latest API 36 package follow-up: all eight native libraries in the APK and all eight embedded in the AAB have ELF PT_LOAD segment alignment of 16,384 bytes. All eight uncompressed APK native-library ZIP data offsets are also 16,384-byte aligned.
- APK contains ARM64, ARMv7, x86 and x86_64 native libraries. The APK's native LOAD segments were inspected and use 16 KB alignment. The AAB's embedded native libraries were also extracted and inspected; all LOAD segments across ARM64, ARMv7, x86 and x86_64 libraries use 16 KB alignment.
- CI checks both standard `LAUNCHER` and `LEANBACK_LAUNCHER` categories and validates launcher artwork resources.
- The debug APK is for controlled testing, not production distribution. The AAB is for Play submission preparation, not direct installation.

## Open-source engine decision

The current OpenTV foundation remains the best fit for the stated one-app phone + TV requirement and the lowest-risk path because it is already integrated and building. OpenIPTV and OwnTV remain reference alternatives only; neither has demonstrated a reason to replace the current engine. The current decision and trade-offs are documented in `docs/OPEN_SOURCE_ALTERNATIVES_REVIEW.md`.

## Earlier API 35 build metadata and signing report — superseded by API 36

- Workflow run `41614656611` completed successfully; artifact ID `13221765019` (`prynce-tv-v0.11.10-test-packages`), 38,796,617 bytes, expires 1 February 2027.
- APK: `app.opentv.debug`, version `0.11.10` / code `22`, min SDK `23`, target SDK `35`, launch activity `app.opentv.MainActivity`.
- APK signature verifies with v1 and v2 schemes. Signer is `C=US, O=Android, CN=Android Debug`; this is a test/debug certificate, not a production signing certificate.
- APK SHA-256: `3132ca5e4bfac11b726d40f1908214ea47de106a968984ed563193b48a091a90`.
- AAB SHA-256: `0cac469acb142b6267c223c0ee9636a154405e28702804ecabd92ac8a7197c14`.
- Both package hashes match the checksum file in the artifact.
- **Store submission blocker:** the current build targets API 35. Google Play requires new phone/tablet apps and updates to target API 36 or higher from 31 August 2026. Android TV's minimum is API 34; the current API 35 meets that TV minimum but does not meet the combined phone/tablet Play requirement. Raise compile/target SDK to 36, rebuild and re-test before a combined phone/TV Play submission.

## Build metadata and signing report — CI implementation verified

- The workflow runs Android `aapt dump badging` and `apksigner verify --verbose --print-certs`; the resulting report is included in the artifact.
- This is debug-build inspection only; production signing remains pending.

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
| AAB native 16 KB alignment | Not independently inspected | Pending |
| Phone sideload update integration | Existing updater configured in CI for PRYNCE releases; build/device test pending | In progress |
| Android TV store update path | Store-managed architecture documented; store/device validation pending | Pending |
| Fire TV store update path | Architecture documented; store/device validation pending | Pending |
| Remote content/config manifest | Architecture documented; client/server not integrated | Pending |
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
4. Review the archived package ID, SDK, permission and debug-signing report once the new CI run succeeds; the AAB's embedded native libraries pass 16 KB LOAD alignment inspection.
5. Review package ID, min/target SDK, permissions, privacy disclosures, support route and store requirements.
6. Complete GPL-3.0-or-later notices and corresponding-source obligations, dependency licence review and secure production signing before any public distribution.

## Definition of done

A feature is complete only with reproducible evidence: automated test output, artifact inspection or a recorded physical-device test. Keep untested items labelled pending. Never describe a CI-only result as device-tested.

## Security and open-source policy

- OpenTV is GPL-3.0-or-later. Preserve upstream notices, review all bundled dependency licences and meet corresponding-source obligations when distributing modified binaries.
- Do not store provider credentials, signing keys, passwords or private API tokens in source control.
- Keep signing keys outside the repository and use a secure release process.
- Preserve authentication, DRM, subscription, broadcaster and regional restrictions.


## 3 November 2026 — TV navigation source audit

- Inspected the pinned upstream Kotlin files for main navigation, Live TV, guide grid, search and player controls at commit `443811904b6437720d37bb1064c0830906c3515f`.
- Static inspection found existing Compose focus groups, FocusRequesters, focus restoration for the Live TV category rail, player-root focus handling, D-pad channel zapping, guide-cell focusability, and a custom on-screen search keyboard.
- This is source inspection only; it does not prove focus behavior on physical TV hardware.
- Decision: do not add Media3 Compose UI or upgrade Media3 merely to introduce focus support. Keep the existing Media3 1.5.0 baseline while device acceptance is pending.
- Findings recorded in GitHub Issue #2. No source changes or new APK build resulted from this audit.


## 3 November 2026 — Ghana directory and local-video integration audit

- Inspected the committed `android/patches/GhanaTvScreen.kt` and `android/patches/LocalMediaScreen.kt` source files and the packaged `catalog/ghana-tv-directory.json`.
- Ghana TV directory reads its bundled JSON asset and filters destinations to HTTPS before opening the broadcaster destination through Android's normal link handler. The directory explicitly describes broadcaster availability and access as provider-dependent; it does not embed extracted stream URLs.
- Local video selection uses Android's Storage Access Framework (`OpenDocument`) with the `video/*` MIME filter. The screen does not request broad storage access and only opens a file selected by the user.
- The workflow copies both screens into the pinned upstream app and compiles them as part of the successful API 36 build.
- Static review confirms the intended integration paths are present. It does not yet prove D-pad focus quality, browser handoff, local-file playback across codecs, or persistence of URI grants on real devices; those remain acceptance tests.
- No source or binary changes were made during this audit.


## 3 November 2026 — Android manifest and privacy/security review

- Inspected the pinned OpenTV manifest and its upstream privacy/release documentation at the project's pinned engine baseline.
- Confirmed manifest declares both phone LAUNCHER and TV LEANBACK_LAUNCHER; Leanback and touchscreen hardware features are both marked not required. This supports one APK being offered to phone and TV form factors; it does not guarantee every device supports every codec or feature.
- Manifest declares INTERNET, network state, wake lock, foreground media playback, notifications, boot reception, exact-alarm, battery-optimisation exemption request, full-screen-intent and package-install request permissions. Several relate to optional recording, reminders and self-update functionality. Before public release, confirm each feature is required, user-facing and explained in store disclosures; remove unused capabilities only after source-level dependency checks and regression tests.
- Manifest has android:allowBackup=true and android:usesCleartextTraffic=true. Upstream privacy documentation explains that provider credentials and traffic sent to HTTP-only provider endpoints are not encrypted in transit. Recommend HTTPS provider endpoints wherever offered. Public release review should decide whether backup exclusions are needed for sensitive provider credentials and validate the resulting restore behaviour.
- The self-updater requests package-install permission and uses the Android system installer flow; it does not silently install updates. Keep Android's normal security prompts and user confirmation.
- Upstream release documentation confirms the current fallback signing key is the Android debug key. A production signing identity must be configured before public distribution; changing signing identity later can prevent in-place upgrades from debug-signed installs.
- No permission or manifest change was made in this audit. No new build was produced. These findings are release-review items, not proof of a vulnerability or of physical-device behaviour.


## 3 November 2026 — updater and release identity audit

- Inspected the pinned updater source: it queries GitHub's latest-release API, ignores drafts/prereleases, selects a release APK asset, compares dotted version tags against the installed versionName, downloads the APK and hands installation to Android's system installer.
- The PRYNCE build workflow rewrites the upstream repository slug and user-facing update text during CI. This confirms configuration in the build recipe, not an end-to-end release update.
- Created GitHub Issue #3 to track the release workflow, exact APK asset naming, tag/versionCode consistency, stable application ID, permanent signing identity, recovery cases and separate phone/TV/Fire TV update tests.
- Current API 36 APK/AAB remain debug-signed. No production release or real-device update test is claimed.
- No application source code or binary was changed in this audit.


## 3 November 2026 — privacy configuration review

- Reviewed pinned upstream Android manifest and privacy documentation. Manifest declares `android:allowBackup="true"` and does not specify `android:fullBackupContent` or `android:dataExtractionRules`.
- Upstream privacy documentation states provider address, username and password are stored in the app's private SQLite database. Backup and device-transfer behavior therefore needs explicit verification and a tested exclusion policy before public release.
- Manifest declares `android:usesCleartextTraffic="true"`. Upstream documentation describes this as a compatibility choice for HTTP-only provider panels and warns that credentials sent over HTTP are unencrypted. Preserve compatibility only with clear user disclosure while evaluating narrower network security controls.
- Reviewed FileProvider configuration: access is scoped to the app cache `updates/` directory for the installer handoff.
- No source code, manifest, permissions or binaries were changed. This was a source-level review, not a device backup/restore test.
- Follow-up tracked in GitHub Issue #4: privacy hardening, credential backup and cleartext provider connections.
