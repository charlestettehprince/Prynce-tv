# PRYNCE TV — Single Project Status

**Last consolidated:** 3 November 2026  
**Repository:** `charlestettehprince/Prynce-tv`  
**Primary Android engine:** OpenTV v0.11.10, pinned upstream commit `443811904b6437720d37bb1064c0830906c3515f`  
**Latest verified CI commit:** `eb7af7bcb8892ccde353dc6ac7c966c6543501a2`  
**Latest status-documentation commits:** `66133b00fae56689769ea0a04fa441bf16c15ac5`  
**Project estimate:** **70%** (rough planning estimate; build automation and branding are progressing, but device acceptance, privacy/licence review and production release remain open)

## Latest startup benchmark correction — 3 November 2026

- Corrected workflow run `41682368813` successfully checked out the repository and pinned OpenTV submodule, configured Java 17 and Android SDK, installed API 35/build tools/emulator, and built `:app:assembleDebug`.
- The emulator booted successfully, but the measurement script failed before installing/running the app. Root cause: the emulator action invokes its supplied script through POSIX `/usr/bin/sh`; the script used Bash-only `set -o pipefail`, which POSIX sh rejects.
- No startup samples or timing artifact were produced by run `41682368813`.
- Fixed the script to use POSIX-compatible `set -eu`, renamed the workflow job from “first-frame launch timing” to “activity launch timing,” and clarified that `am start -W TotalTime` is not a first-rendered-frame measurement.
- Fix commit: `b2000d08d10e53e56b17c55d18217f0abded568c`. Workflow file read-after-write verified.
- The push should trigger a fresh workflow run. Await that run before reporting timings. If it fails, inspect the new logs and fix the specific failure; do not report a timing result without a valid artifact.
- Baseline Profiles/Macrobenchmark are still not integrated. Official Android guidance confirms a supported toolchain exists (AGP 8.0+, Macrobenchmark 1.5.0+, Profile Installer 1.4.1+), but the repository's actual AGP/Kotlin versions must be inspected before adding modules or changing dependencies. A generated profile must be benchmarked on physical hardware before claiming speed gains.
- Current project estimate remains **70%**. No app runtime source, authentication, provider access, website or release signing was changed.

## Latest verified build #107 — 3 November 2026 (supersedes earlier build notes)

- Latest CI run: [41629319388](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41629319388); commit `eb7af7bcb8892ccde353dc6ac7c966c6543501a2`; conclusion: **success**.
- All 17 workflow steps completed, including tests, APK/AAB compilation, package metadata/signing capture, checksums, artifact uploads, Android Gradle Lint and lint-report upload.
- Build artifact ID: `13228535438`; lint report artifact ID: `13227652811`.
- APK: `app.opentv.debug`, version `0.11.10`, versionCode `22`, min SDK 23, compile/target SDK 36. APK SHA-256: `2c653ce3ff06e8a9fe32ca2eb53395b3f2b352c6fdc1db74aab57bae796a9c1`.
- AAB SHA-256: `e3f0411fbed5e6d98736b58ebc5282a3fa8a5609ef0be8076846235798ec907e`.
- Both downloaded ZIP artifacts passed integrity checks. APK signature verifies with v1/v2; signer is the Android Debug certificate, not a production key.
- Android Lint: 187 findings total — 184 warnings and 3 informational, zero errors/fatal. Dependency/KTX, translations, unused resources and other quality warnings still need triage.
- PR #8 (`fix/locale-formatting-lint`) remains an open draft; do not treat it as merged.
- This is a successful CI test build, not a production release. No physical phone/TV playback or updater test is claimed.

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

## 4 November 2026 — PRYNCE yellow/black theme CI verification

- Theme validation workflow run [41845244555](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41845244555) completed with **success** on commit `8faeae1c93b330880b89a34b5c010f857b17308a`.
- All workflow steps succeeded: checkout, pinned OpenTV revision verification, Java/Android SDK setup, theme patch validation/application, themed debug APK build, lint diagnostic/report step and artifact upload.
- The patch applies successfully to the pinned OpenTV v0.11.10 source at `443811904b6437720d37bb1064c0830906c3515f` during CI. It remains a separate patch artifact; the upstream submodule pointer and upstream source are not rewritten in the repository.
- Artifact: `prynce-tv-yellow-black-theme-test`, ID `13331431176`, 28,927,830 bytes, expires 18 November 2026. Artifact ZIP SHA-256: `72141645959b95b0d8da5cb9c88b2cbdd880c5e8b9ffce51224e0d1e41d20e0f`.
- Downloaded artifact ZIP passed `unzip -t`. It contains `outputs/apk/debug/app-debug.apk` (30,589,383 bytes) and `reports/lint-results-debug.html`.
- Debug APK SHA-256: `a99291e6ee176fc5530d6c318644e7348f2ecd6d70f9d3f774c9a935fac01a22`. APK ZIP integrity check passed. This is a **debug test APK**, not a production-signed release.
- Lint diagnostic report still contains **18 errors and 121 warnings** (including 2 MissingPermission and 16 MissingTranslation errors). Lint is deliberately non-blocking in this theme build workflow so the separately successful APK build and diagnostic report remain available. This does not mean lint is clean or release-ready.
- PR #10 remains open and draft. No merge, release, production signing or public distribution has occurred.
- The actual screen layout, contrast, accessibility and D-pad focus behavior still require visual inspection and physical phone/Android TV testing. CI compilation alone does not prove the theme is usable on hardware.

## Immediate next steps after theme build

1. Inspect the lint report and resolve permission findings only with correct runtime permission/state checks; do not suppress errors blindly.
2. Review missing translations and add accurate translations or a documented fallback without changing app behavior unexpectedly.
3. Validate yellow/black contrast, focus indicators, selection states and light/dark modes on phone and Android TV hardware.
4. Continue the security review tracked in issue #4: credential-bearing provider URLs, local sync/NAS exports, backup/device-transfer behavior and cleartext HTTP compatibility. Do not change backup exclusions or storage formats until data-preservation behavior is tested.
5. Keep issue #3 updater signing/release identity and issue #5 public installer checks blocked until a stable production signing identity, release assets and device installation tests are available.

## 4 November 2026 — Android 13+ notification-permission safety patch (CI pending)

- Added `branding/patches/prynce-notification-permission.patch` against the exact pinned OpenTV v0.11.10 source. It checks the Android 13+ `POST_NOTIFICATIONS` runtime permission before the scheduled-recording and programme-reminder receivers attempt to post notifications. If permission is not granted, the background receiver safely skips the notification instead of relying on a call that may throw; it does not prompt from a background receiver.
- The patch is kept outside the upstream submodule and is applied only inside the isolated validation workflow. No upstream submodule pointer or user data was changed.
- Updated `.github/workflows/prynce-theme-validation.yml` to validate/apply this additional patch and trigger validation when the patch changes.
- New validation run for the current branch head `da17f40d7e83ade6cd7bbea09f8f6f674fdd2cb4`: [41846359542](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41846359542). At the time of this status update, its result is not yet available. An earlier push run is also in progress; do not claim the permission patch compiles until the current-head run completes.
- The previous successful themed debug APK does not include this new permission patch. It must not be described as containing this fix.
- The 16 MissingTranslation lint errors are deliberately not silenced or marked non-translatable. They require accurate translations/fallback decisions; bulk copying English into other languages would mislead users. The current patch addresses only the two MissingPermission findings.
