# PRYNCE TV — latest verified handoff update
**Updated: 3 November 2026**

## Latest verified build: #107
- Workflow: https://github.com/charlestettehprince/Prynce-tv/actions/runs/41629319388
- Commit: `eb7af7bcb8892ccde353dc6ac7c966c6543501a2`
- Build completed successfully: automated tests, APK/AAB build, metadata/signing capture, checksums, artifact uploads and Android Gradle Lint.
- Build artifact ID: `13228535438`; Lint report artifact ID: `13227652811`.
- APK package: `app.opentv.debug`; version `0.11.10`; versionCode `22`; min SDK 23; target/compile SDK 36.
- APK SHA-256: `2c653ce3ff06e8a9fe32ca2eb53395b3f2b352c6fdc1dcb74aab57bae796a9c1`.
- AAB SHA-256: `e3f0411fbed5e6d98736b58ebc5282a3fa8a5609ef0be8076846235798ec907e`.
- Both artifact ZIPs passed integrity checks. APK signature verification passed for v1/v2, but the signer is the Android Debug certificate, not a production signing identity.
- Lint report: 187 findings (184 warnings, 3 informational), zero errors/fatal findings.
- PR #8 remains open and draft; it has not been merged.
- Release/security issues #3, #4 and #5 remain open. Issue #7 now records Build #107 as the current Lint baseline.

## What this proves — and what it does not
The CI build proves that the source compiles and the automated build pipeline completes. It does **not** prove that live streams or movies play on a physical phone/TV, that a broadcaster has authorised a stream, that a public movie catalogue exists, or that the app is ready for public distribution.

## Next implementation and verification sequence
1. Review safe Build #107 Lint findings; fix correctness issues before cosmetic or dependency churn.
2. Inspect provider credential storage, backup/restore behavior and cleartext-network compatibility; do not weaken provider security silently.
3. Test local media playback and one explicitly authorised test stream on a physical Android phone.
4. Test Android TV remote navigation and playback separately; test Fire TV separately.
5. Verify update discovery, Android installer handoff, cancel/decline and in-place update using a production-signed test build.
6. Confirm permanent package identity and production signing with the authorised release owner.
7. Add only licensed/authorised channels and movie sources, with age-appropriate family controls.
8. Prepare a stable download/distribution route and user-facing privacy/support information.

## Current readiness statement
- Engineering build: **CI passed**.
- Physical-device playback: **not yet verified**.
- Live TV/content rights: **not yet verified**.
- Production signing/public release: **not complete**.
- Do not distribute the debug APK as a production installer.

---

# PRYNCE TV — consolidated handoff and release readiness

Last verified: 3 November 2026  
Repository: https://github.com/charlestettehprince/Prynce-tv  
Branch: `main`  
Engine baseline: OpenTV v0.11.10, pinned upstream commit `443811904b6437720d37bb1064c0830906c3515f`

## Executive status

**Build 105 is a successful CI test build, not a production release.** The latest workflow completed tests, APK/AAB compilation, adaptive and monochrome icon generation, notification icon integration, metadata/checksum capture, Android Gradle Lint and report upload.

Build run: https://github.com/charlestettehprince/Prynce-tv/actions/runs/41625818584  
Build commit: `f7c58dfe0520644151266d158b26b17aae11659a`  
Artifact: `prynce-tv-v0.11.10-test-packages`, ID `13226525916`.

## Verified Build 105 outputs

- APK: `app.opentv.debug`, version `0.11.10`, versionCode `22`.
- Minimum Android: API 23 (Android 6.0); compile/target API 36.
- APK SHA-256: `5fac9671ee89d245f50e5deb924c74a4e3a1fa64f766f8fd011767279ba7be88`.
- AAB SHA-256: `05c9a557ddd2daa422945d9440a502a1065725913294954d65fffec0be562abc`.
- Artifact ZIP SHA-256: `04da2dce25fd3e85696f0d8108786d5ed2ea3ba49bd069a033cc2cf562b77b60`.
- APK and AAB archive integrity passed; APK signature verification passed with v1/v2. Signer is the Android Debug certificate, not a permanent production key.
- Lint: 0 errors, 188 warnings and 3 informational findings. Reports artifact ID `13225353950`.
- Adaptive launcher foreground/background, monochrome themed icon, legacy density fallbacks and dedicated notification glyph are generated and wired in the successful CI build.

The GitHub Actions artifacts are temporary and may require repository access. They are not anonymous permanent download links. The APK is a controlled test artifact, not a production installer; the AAB is a Play submission preparation artifact, not directly installable by ordinary users.

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


## 3 November 2026 — Adaptive and notification icon follow-up

- The Android CI workflow now generates adaptive launcher icon layers, a monochrome themed layer, legacy density fallbacks and a separate white notification glyph from the committed PRYNCE icon source.
- The manifest is patched to reference the adaptive launcher icon and round-icon alias. Notification builders use the dedicated PRYNCE small icon.
- Workflow commit: `f7c58dfe0520644151266d158b26b17aae11659a`.
- Build run `41625818584` was pending/queued at the time of this handoff update. Treat these additions as source-integrated but not build-verified until the run succeeds.
- Device screenshot checks, store artwork, production signing, package identity decision and public tester distribution remain release gates.

## 3 November 2026 — Master founder brand standard

- Added `docs/PRYNCE_MASTER_BRAND_STANDARD.md` as the reusable identity guide for PRYNCE-owned websites, apps, media, documents and presentations.
- It requires the original Prynce logo/wordmark on primary brand surfaces, accurate `Prince Charles Tetteh` founder credit where relevant, the “Beyond ordinary.” tagline, and the navy/white/restrained-gold system.
- The private Library portrait set was located: `1000114846.png` (executive headshot), `1000118820.jpg` (navy-suit portrait), `1000119037.jpg` (seated casual professional portrait). No portrait has been copied into this public repo or app binary. The correct app placement is an About/Founder surface, not the launcher icon or playback screens; public embedding awaits confirmation of the specific image and destination.
- README and branding guide now link to the master standard and record Build 105 as verified.
