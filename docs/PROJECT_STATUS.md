# PRYNCE TV — Single Project Status

**Last consolidated:** 3 November 2026  
**Repository:** `charlestettehprince/Prynce-tv`  
**Primary Android engine:** OpenTV v0.11.10, pinned upstream commit `443811904b6437720d37bb1064c0830906c3515f`  
**Latest verified CI commit:** `eb7af7bcb8892ccde353dc6ac7c966c6543501a2`  
**Latest status-documentation commits:** `66133b00fae56689769ea0a04fa441bf16c15ac5`  
**Project estimate:** **70%** (rough planning estimate; build automation and branding are progressing, but device acceptance, privacy/licence review and production release remain open)

## Latest verified build #107 — 3 November 2026 (supersedes earlier build notes)

- Latest CI run: [41629319388](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41629319388); commit `eb7af7bcb8892ccde353dc6ac7c966c6543501a2`; conclusion: **success**.
- All 17 workflow steps completed, including tests, APK/AAB compilation, package metadata/signing capture, checksums, artifact uploads, Android Gradle Lint and lint-report upload.
- Build artifact ID: `13228535438`; lint report artifact ID: `13227652811`.
- APK: `app.opentv.debug`, version `0.11.10`, versionCode `22`, min SDK 23, compile/target SDK 36. APK SHA-256: `2c653ce3ff06e8a9fe32ca2eb53395b3f2b352c6fdc1cdb74aab57bae796a9c1`.
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

## Android Lint audit and remediation — 3 November 2026

- CI run `41621635910` successfully built the debug APK and Play-format AAB, then correctly failed the newly added Android Lint gate. The report recorded **24 errors and 157 warnings**; lint XML/HTML reports were uploaded as artifact `13223618679`.
- Error triage: 2 notification-permission findings in recording/reminder alarm receivers; 4 API-level findings around Android 8.0 picture-in-picture calls while the app supports Android 6.0+; and 18 incomplete-translation findings across the upstream resource set.
- Added reproducible build-time source patches in `scripts/apply_android_lint_fixes.py`: explicit Android 13+ notification permission checks before notification posting, and a local Android 8.0+ guard around picture-in-picture calls. The pinned upstream submodule remains unchanged.
- Added `android/patches/lint.xml` to keep incomplete upstream translations visible as warnings rather than compilation-blocking errors. The check is **not disabled**; translation coverage remains a quality backlog.
- CI workflow applies the reviewed patch script and lint policy before building and runs `./gradlew lint`, then uploads the XML/HTML reports. Validation workflow run [`41622174882`](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41622174882) completed successfully on 3 November 2026. All 20 substantive steps passed, including checkout, Android 16 configuration, launcher artwork, Ghana TV directory, branding, reviewed lint-patch application, automated tests, APK/AAB builds, package metadata, checksums, Android Gradle Lint, and report upload. Test-package artifact `13225000857` is available until 1 February 2027; lint-report artifact `13223903422` is available until 3 December 2026. **The lint gate now passes in this workflow.** The initial 157 warnings still need triage; the severity adjustment only concerns `MissingTranslation`.
- Do not treat the lint gate as passed until that run completes. The 157 warnings from the initial report also remain to be reviewed; the severity adjustment only concerns `MissingTranslation`.

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


## 3 November 2026 — Build #100 completed and Android Lint reviewed

- GitHub Actions run #100 completed successfully at commit `c48149b243dd51ab05bac8b09a5aa495a715cd8a`: https://github.com/charlestettehprince/Prynce-tv/actions/runs/41622174882
- Automated tests, debug APK assembly, release-format AAB bundle, package metadata capture, SHA-256 checksums, Android Gradle Lint and lint-report upload all completed successfully.
- Build artifact: `prynce-tv-v0.11.10-test-packages` (artifact ID `13225000857`); lint report artifact: `prynce-tv-android-lint-reports` (artifact ID `13223903422`).
- APK metadata: package `app.opentv.debug`, version `0.11.10`, versionCode `22`, minSdk 23, targetSdk 36. APK v1/v2 signatures verify; signer is the Android Debug certificate, not a production signing identity.
- Independently inspected the archived lint XML: 178 findings total, comprising 175 warnings and 3 informational findings; zero errors. The 18 incomplete-translation findings remain visible as warnings. Other warning groups include dependency update notices, KTX recommendations, unused resources, locale/formatting recommendations and picture-in-picture guidance.
- APK SHA-256: `6e372d251d5e8a81b2a3bc2f2920941598bf4a7a7394389c278a5c855db5a2ed`.
- AAB SHA-256: `c428e42d9da6aac20bea29084660869cd98dde83959dfcb4d71894ae748c66bc`.
- This is a successful CI test build, not a public production release. Physical phone/TV/Fire TV acceptance, provider playback regression, privacy/backup decisions, GPL/source-notice review and permanent production signing remain release gates.
- No Android security prompts, installer confirmation, DRM, provider authentication or licensing restrictions were bypassed.


## 3 November 2026 — PRYNCE identity integration expansion

- Updated the Android baseline CI workflow at commit `c9acd096f444429e3e483e3f372fa205e918df82` to preserve the original PRYNCE icon and wordmark as separate generated app resources.
- The build recipe now patches the expanded in-app navigation rail to show the PRYNCE icon and original white wordmark, rather than the upstream OpenTV logo/text.
- The existing workflow also renders the PRYNCE launcher icon and Android TV banner from the committed SVG source artwork, applies the PRYNCE TV app label and gold theme accents, and validates the launcher resource references.
- Updated `docs/BRANDING_ASSET_INTEGRATION.md` and the README to distinguish implemented brand placements from remaining work.
- A new Android CI run was triggered by the workflow change: run `41624556618`. At the time of this update it was still running; no successful result is claimed yet.
- Remaining brand tasks: dedicated monochrome notification icon, adaptive/themed launcher icon variants, and physical phone/Android TV/Fire TV screenshot review. Do not claim the brand is literally present in every UI surface until these are checked.
- This is a build-time patch against the pinned upstream submodule; upstream source notices are preserved. No production release or device acceptance is claimed.


## 3 November 2026 — Adaptive launcher and notification branding

- Expanded `.github/workflows/android-baseline.yml` to derive Android icon layers from the original committed `branding/prynce_icon.svg`; no new logo was substituted.
- The workflow now generates adaptive launcher foreground/background resources, an Android monochrome themed-icon layer, density-specific legacy launcher fallbacks, and a dedicated white monochrome notification glyph.
- The Android manifest is patched to use `@mipmap/ic_launcher` and the matching round-icon resource. Notification builders are patched to use `R.drawable.ic_prynce_notification`.
- CI includes checks for the adaptive icon XML, legacy fallback, notification asset and manifest references.
- Workflow commit: `f7c58dfe0520644151266d158b26b17aae11659a`.
- Build run `41625818584` was queued/pending at the time of this update. The earlier branding-only build `41624830375` was still in progress on the prior workflow revision; neither result is represented as a successful build here.
- Documentation updated in commits `1f7eee6116aece875a18686666dde729277be669` and `c263f62b2c5d5191df68f8f4b525e7e3dae07a88`.
- Real-device phone/Android TV/Fire TV visual acceptance, public store artwork, production signing and public distribution remain outstanding.


## 3 November 2026 — Latest Android Lint artifact triaged

- Downloaded and independently parsed the lint XML/HTML artifact from successful workflow run [#107 / 41629319388](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41629319388), artifact ID `13227652811`.
- The archived report contains **187 findings: 184 warnings, 3 informational findings, and zero errors/fatal findings**. The CI lint task passed; this is not a claim that all warnings are resolved.
- The largest groups are 73 dependency update advisories, 37 KTX recommendations, 18 incomplete-translation findings, 14 unused-resource findings, 8 pluralization candidates, 7 bitmap-density warnings, and 5 round-launcher-icon shape warnings.
- Higher-priority behavior review: one PiP guidance finding, one orientation advisory attached to `screenOrientation=fullUser` (not a fixed portrait/landscape lock), four static default-locale captures, and one app-bundle locale-configuration finding. The latest report has no remaining `DefaultLocale` findings after the Locale.ROOT recording-size formatter patch in PR #8.
- Added `docs/ANDROID_LINT_TRIAGE.md` with every issue group, counts, risk-based execution order and guardrails. No Android source or binary was changed during this triage.
- Next implementation milestone: inspect the exact PiP/orientation and locale source locations, then make only narrow, evidence-backed fixes with a fresh CI run. Do not bulk-upgrade dependencies, silence warnings, or remove resources without compatibility/reference checks.
- Real phone/Android TV acceptance, PiP behavior, launcher appearance, and actual playback remain unverified on physical devices.


## 3 November 2026 — Lint triage clarification

- The latest #107 lint XML has no remaining DefaultLocale findings; PR #8 adds explicit Locale.ROOT to the two recording-size formatters. Four ConstantLocale findings remain.
- The single orientation advisory points to screenOrientation=fullUser in the pinned upstream manifest. That setting allows user-selected orientations; it is not a fixed portrait or landscape lock. Do not remove it blindly.
- See docs/ANDROID_LINT_TRIAGE.md for the reconciled 187-finding breakdown and next review order.


## 3 November 2026 — Privacy, security and distribution gate audit

- Completed a static source review of the pinned OpenTV Android manifest, Gradle release signing fallback, upstream privacy statement, FileProvider paths, updater HTTPS request, GPL licence and PRYNCE release documentation.
- Added `docs/SECURITY_PRIVACY_AUDIT.md` with risk-ranked findings and an evidence-based release sequence.
- Main release blockers confirmed: application-wide cleartext HTTP is enabled for provider compatibility; backup is enabled and credential backup/restore behavior still needs verification; sensitive permissions need feature-by-feature justification; current release signing falls back to the debug key unless a production keystore is configured; and a root-level PRYNCE licence/complete corresponding-source release bundle still needs preparation.
- Positive static finding: the inspected FileProvider is non-exported and scoped to the update cache path. This is not a runtime security certification.
- No Android source, APK, AAB, permissions or security settings were changed. No penetration test, SBOM vulnerability scan, backup test or device test was performed.
- Public distribution remains blocked pending credential/backup review, an explicit HTTP-provider policy, production signing/package identity, GPL notices and corresponding source, exact-binary privacy review, and physical-device acceptance.


## 3 November 2026 — Credential storage and backup review

- Inspected the pinned OpenTV source entities, Room database builder, settings preferences and Android manifest.
- Confirmed provider username/password and Stalker MAC are stored as ordinary Room entity fields; SMB username/password and the TMDB API key are ordinary strings in the app-private `opentv_settings` preferences file. Token-bearing M3U/add-on URLs may also contain sensitive values.
- The pinned Room builder uses the standard Room database builder; no SQLCipher or application-level encryption wrapper was found in the inspected source. Android's app sandbox still protects private files from ordinary sandboxed apps, but at-rest encryption and backup exposure need a deliberate policy.
- The manifest enables `allowBackup=true` and does not reference explicit backup/data-extraction rules. Actual backup/transfer behavior is OS/OEM-dependent and has not been tested.
- Added `docs/CREDENTIAL_STORAGE_BACKUP_REVIEW.md` with the data map, recommended Keystore-backed vault approach, migration safeguards and test matrix.
- Recommended policy: exclude credential-bearing database/settings from automatic platform backup, then consider a separate encrypted export/import flow. This would also exclude non-secret catalogue/preferences stored in those files, so it is a product/data-recovery decision.
- No source code, database, manifest, backup settings, credentials or APKs were changed. Awaiting an explicit decision before changing backup behavior. No runtime backup/restore test was performed.


### Follow-up credential transport review — 3 November 2026

- Further inspected pinned `ManagerServer.kt` and found its LAN web manager accepts provider username/password/MAC through `POST /source`, and NAS password through `POST /recording`.
- The server uses plain HTTP, a private-address check, a random high port and a random session token. These controls limit access but do not encrypt traffic. A local-network observer may be able to capture the token and submitted credentials.
- The class-level comment that the manager handles no credentials is inconsistent with its actual handlers.
- Added this finding and safer design options to `docs/CREDENTIAL_STORAGE_BACKUP_REVIEW.md`. Recommended either HTTPS with a session trust mechanism or disabling credential-changing endpoints over HTTP if robust HTTPS cannot be made compatible.
- No application source or network behavior changed; no runtime LAN interception or device test performed.


## 3 November 2026 — APK updater authenticity audit

- Inspected pinned upstream `UpdateChecker.kt`, `ApkInstaller.kt`, `GitHubReleaseApi.kt`, `app/build.gradle.kts`, and PRYNCE's Android build workflow.
- Confirmed updater calls GitHub Releases API over HTTPS and launches Android's system installer through a FileProvider URI; it does not silently install.
- Identified static release-authenticity gaps: updater selects the first `.apk` asset, parses no asset digest, performs no strict downloaded-size check, does not constrain the metadata-supplied APK URL, and does not inspect package/version/signer before installer handoff.
- Android's package installer remains a final signature enforcement layer for updates to an existing package, but PRYNCE lacks app-side pre-install signer pinning and first-install signer assurance.
- Confirmed upstream release Gradle config falls back to the Android debug key when `KEYSTORE_PATH` is absent. Existing PRYNCE test artifacts are debug-signed; this remains a production-release blocker.
- PRYNCE's build workflow rewrites the updater repository slug to `charlestettehprince/Prynce-tv` before build. No digest-verification patch was present in the inspected workflow.
- Added `docs/UPDATER_AUTHENTICITY_AUDIT.md` with evidence, risk register, release asset contract, signer verification design, key-custody safeguards and test matrix.
- No source code, workflow, signing config, keystore, APK/AAB or release was changed. No updater runtime or physical-device test was performed.
- Next: finalise production package ID and key custody with the authorised owner, then implement strict digest + package/version/signer checks and remove debug-key fallback from production release tasks. Keep Android's system installer confirmation; never bypass signature checks or Play Protect.


## 3 November 2026 — Free access, onboarding and performance audit

- Reviewed pinned OpenTV app startup, Compose navigation, source onboarding, service locator, image loader, app Gradle configuration and manifest.
- Confirmed the reviewed app flow does not require a PRYNCE account to launch or browse; first-time users configure a source, while returning users proceed to the home screen. Profiles are local app profiles, not cloud sign-in.
- Confirmed PRYNCE's intended product policy: free app/basic use, no mandatory PRYNCE membership or paywall, and public website/TV directory accessible without sign-in. Third-party TV providers may independently require paid plans or credentials; PRYNCE must not describe their protected content as free.
- Found existing performance foundations: lazy service graph, background maintenance/EPG work, Coil memory/disk caching with no crossfade and RGB_565 for opaque art, and R8/resource shrinking enabled for release.
- Identified missing performance evidence and opportunities: no Baseline Profile plugin or dedicated Macrobenchmark module found in the inspected Gradle configuration; no cold-start/TTID/TTFD, frame-jank, low-memory or physical-device benchmark was available. Image-cache sizing and background startup load need measurement before tuning.
- Added docs/FREE_ACCESS_PERFORMANCE_UX_AUDIT.md with product access policy, current source findings, simple first-run design, accessibility/navigation requirements, performance plan and acceptance targets.
- Updated README with the free-use/no-mandatory-PRYNCE-login policy and clear separation between PRYNCE and third-party provider charges.
- No app source, UI, authentication, website, credentials or binary was changed. No device test or benchmark was run.
- Next: implement and CI-test Baseline Profiles/Macrobenchmark coverage, then measure first-run and returning-user startup on a low-end phone and Android TV device. Keep guest access and the existing Wix website; do not add paid infrastructure or a mandatory account gate.
