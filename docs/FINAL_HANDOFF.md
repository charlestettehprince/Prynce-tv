# PRYNCE TV — consolidated handoff and release readiness

Last verified: 3 November 2026  
Repository: https://github.com/charlestettehprince/Prynce-tv  
Branch: `main`  
Engine baseline: OpenTV v0.11.10, pinned upstream commit `443811904b6437720d37bb1064c0830906c3515f`

## Executive status

**Build #100 is a successful CI test build, not a production release.** Automated tests, APK/AAB compilation, package metadata and checksum capture, Android Gradle Lint, and report upload completed. The APK is debug-signed. There is no verified public installer page or public share button yet.

Build run: https://github.com/charlestettehprince/Prynce-tv/actions/runs/41622174882  
Build commit: `c48149b243dd51ab05bac8b09a5aa495a715cd8a`

## Verified build outputs

- APK: `app.opentv.debug`, version `0.11.10`, versionCode `22`
- Minimum Android: API 23 (Android 6.0); target API 36
- ABIs: `arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`
- APK SHA-256: `6e372d251d5e8a81b2a3bc2f2920941598bf4a7a7394389c278a5c855db5a2ed`
- AAB SHA-256: `c428e42d9da6aac20bea29084660869cd98dde83959dfcb4d71894ae748c66bc`
- Build artifact: `prynce-tv-v0.11.10-test-packages`, ID `13225000857`
- Lint artifact: `prynce-tv-android-lint-reports`, ID `13223903422`
- APK signature checks and ZIP integrity passed; signer is the Android Debug certificate, not a permanent production key.
- Native 16 KB alignment was checked.
- Lint: 178 findings (175 warnings, 3 informational), zero errors. Warnings remain and should be triaged rather than hidden.

Workflow artifacts are temporary and may require GitHub access. The build artifact expires 1 February 2027; the Lint artifact expires 3 December 2026. These are not anonymous permanent download links.

## App integration reviewed

- Ghana TV directory is bundled JSON; destinations are filtered to HTTPS and opened through Android's normal link handler. No extracted broadcaster streams are embedded.
- Local media selection uses Android's Storage Access Framework with a video MIME filter; no broad storage permission is requested by that flow.
- Phone and Android TV launcher entries are present; touchscreen and Leanback hardware features are not mandatory.
- The updater checks GitHub latest releases and passes APK installation to Android's system installer. It does not silently install.
- Static review is not a substitute for physical-device testing.

## Consolidated remaining release gates

### A. Public app identity and signing — BLOCKING
- Choose and confirm the permanent application ID; current `app.opentv.debug` is a test identity.
- A responsible adult/eligible release owner must control the store/distribution accounts and approve publication.
- Establish a permanent production signing identity, protect its keystore and passwords outside source control, and document secure recovery.
- Verify signing continuity and package ID before any production update. Do not publish the debug-signed APK as a stable installer.

### B. Real-device acceptance — BLOCKING
- Test install, first launch, navigation, rotation, audio/video, and uninstall on supported Android phones/tablets.
- Test D-pad focus, remote navigation, playback and browser handoff on Android TV.
- Test Fire TV separately; do not assume Android TV results prove Fire TV compatibility.
- Test Ghana broadcaster destination availability and local-file playback across representative codecs.
- Test updater discovery, download, installer handoff, cancel/decline, offline recovery, and in-place upgrade using a production-signed test build.

### C. Privacy and security — BLOCKING
- Inspect credential persistence and database code.
- Verify backup, restore and device-transfer behavior; choose and test explicit exclusions or a safer storage approach for provider credentials.
- Review the broad `usesCleartextTraffic=true` compatibility setting. Narrow it only after regression testing legitimate HTTP-only provider panels; disclose that credentials sent over HTTP are not encrypted in transit.
- Audit requested permissions and exported components against actual features; remove only demonstrably unused items after tests.
- Verify update metadata/downloads remain HTTPS-only and authenticate release binaries through the release/signing design.
- Review privacy disclosures and avoid embedding secrets.

### D. Distribution and tester sharing — NOT PUBLISHED
- No permanent public download page or share button has been created.
- GitHub Actions artifacts are temporary and may require repository access; do not treat them as public anonymous downloads.
- Firebase App Distribution is a practical tester route, but setup requires a registered Firebase Android app with the exact package name, a Firebase App ID, authorized Firebase account/CLI authentication, and an approved tester list or group. The current debug package name must not be assumed to be the final production app identity.
- After setup, upload the reviewed test build, invite approved testers, and use the generated tester link. Firebase's direct binary link is temporary; its tester experience is access-controlled.
- A public landing page should only point to an approved, stable release asset after the above release gates are met.

### E. Open-source obligations — BLOCKING
- Preserve OpenTV GPL-3.0-or-later notices and provide the corresponding source for the exact modified binary distributed.
- Include source commit, release notes, checksums, signer fingerprint, supported Android range, permissions summary, privacy notice and known limitations with the release.

## Existing tracked work

- Issue #3 — updater/release identity and signing: https://github.com/charlestettehprince/Prynce-tv/issues/3
- Issue #4 — credential backup and cleartext provider connections: https://github.com/charlestettehprince/Prynce-tv/issues/4
- Issue #5 — safe public installer gate: https://github.com/charlestettehprince/Prynce-tv/issues/5

Keep these issues open until their evidence-based acceptance criteria are satisfied.

## Safe test-build access

Use the Build #100 Actions page above to inspect and download the temporary test artifact if you have repository access. Verify the APK SHA-256 against the value in this document after download. Keep Android's normal installer confirmation and Play Protect enabled; investigate warnings rather than bypassing them.

## Completion statement

Completed: CI test build, build metadata/checksum capture, lint report capture, source-level integration review, source-level manifest/privacy review, updater-flow review, and consolidated release checklist.

Not completed and not claimed: production signing, permanent public app ID, physical-device acceptance, production privacy hardening, Firebase/Play distribution setup, public landing page/share button, stable public release, or store publication.

This handoff intentionally records blockers instead of marking unverified work complete. No safety prompt, age gate, DRM, licensing rule, installer confirmation, or platform security check should be bypassed.


## 3 November 2026 — PRYNCE brand coverage update

- Original brand artwork is present in `branding/prynce_icon.svg` and `branding/prynce_wordmark.svg`; these source files are preserved.
- Updated CI to generate separate in-app icon and wordmark resources from the original SVG artwork.
- Intended branded surfaces now include the phone/tablet launcher icon, Android TV / Fire TV banner, in-app navigation rail icon, expanded navigation wordmark, app label, and gold theme accents.
- Updated `README.md`, `docs/BRANDING_ASSET_INTEGRATION.md`, and `docs/PROJECT_STATUS.md` to record what is implemented and what remains.
- Branding workflow commit: `c9acd096f444429e3e483e3f372fa205e918df82`. Its first CI attempt failed in the new navigation patch due to a script-pattern issue; the patch was corrected in commit `cffe1c52db8daab3a4ff480c0083698e38240ab6`.
- Corrected CI run: `41624830375`, currently queued/pending at the time this note was written. Do not claim the new build passed until that run completes successfully.
- Notification small icon remains upstream; a dedicated monochrome PRYNCE glyph is still needed. Adaptive/themed launcher variants and physical phone/TV screenshots also remain outstanding.
