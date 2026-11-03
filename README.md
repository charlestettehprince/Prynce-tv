# PRYNCE TV

**Beyond ordinary.** A branded Android media player for Android phones, Android TV and Fire TV, built on the pinned OpenTV v0.11.10 open-source foundation.

## Product scope

PRYNCE TV is a player, not a broadcaster or channel subscription service. Viewers add playlists or provider details they are authorised to use. The app must not circumvent DRM, authentication, subscriptions, geographic restrictions or broadcaster controls.

Core upstream capabilities include M3U/M3U8 playlists, Xtream-compatible provider connections, XMLTV programme guides, search, favourites, history and remote-friendly navigation. Availability of individual playback features depends on the provider and device.

## PRYNCE branding

- App name: **PRYNCE TV**
- Visual direction: near-black/navy with restrained gold accents.
- Original vector icon: `branding/prynce_icon.svg`
- Original vector wordmark: `branding/prynce_wordmark.svg`
- CI renders the launcher icon, Android TV banner, in-app navigation icon and in-app wordmark directly from these original SVG sources.
- The app label and theme accents also use the PRYNCE TV identity.
- CI generates PRYNCE adaptive and legacy launcher icon resources, including a monochrome themed layer, plus a dedicated white notification glyph.
- The adaptive icon, round icon, monochrome layer and notification glyph are wired through the manifest and notification builders; this integration passed CI run [41625818584](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41625818584).
- Physical phone/TV screenshot checks and store/public download artwork remain outstanding.
- Master identity rules: [PRYNCE Master Brand & Founder Identity Standard](docs/PRYNCE_MASTER_BRAND_STANDARD.md).
- Branding integration and CI installation: [Branding asset integration guide](docs/BRANDING_ASSET_INTEGRATION.md).

The committed artwork is derived from the original assets supplied by the project owner. It is resized/compressed for Android use, not redrawn or recoloured.

## Build status

The GitHub Actions workflow checks out the pinned OpenTV submodule, installs the PRYNCE icon/banner into the Android drawable resources, applies the PRYNCE TV app label and theme, runs automated tests, builds a debug APK and uploads the artifact.

- [Latest workflow runs](https://github.com/charlestettehprince/Prynce-tv/actions)
- Latest successful branded adaptive-icon build: [CI run 41625818584](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41625818584), commit `f7c58dfe0520644151266d158b26b17aae11659a`.
- Artifact: `prynce-tv-v0.11.10-test-packages`, ID `13226525916`, expires 1 February 2027.
- APK: `app.opentv.debug`, version `0.11.10` / code `22`, min SDK `23`, compile SDK `36`, target SDK `36`.
- APK SHA-256: `5fac9671ee89d245f50e5deb924c74a4e3a1fa64f766f8fd011767279ba7be88`; AAB SHA-256: `05c9a557ddd2daa422945d9440a502a1065725913294954d65fffec0be562abc`.
- Artifact ZIP SHA-256: `04da2dce25fd3e85696f0d8108786d5ed2ea3ba49bd069a033cc2cf562b77b60`. APK/AAB ZIP integrity and checksums passed; APK signature verified using v1/v2. The signer is the Android Debug certificate, not a production signing identity.
- Android Lint completed with 0 errors, 188 warnings and 3 informational findings. Reports are in artifact `13225353950`.
- Both APK and AAB use the Android Debug certificate. They are controlled test/preparation artifacts, not production-signed release packages.

**CI success is not device acceptance.** Physical Android phone, Android TV and Fire TV testing, authorised-source playback, launcher visual inspection, privacy/licence review and production signing remain required before public release.

## Safe installation and release status

**There is not yet a production-ready public installer.** The available API 36 APK is a debug-signed test build for controlled testing only. Do not treat it as a verified stable release or install a copy from an unofficial mirror.

The intended public experience is one clearly labelled APK download from this repository's official Releases page, with its version, source commit, production signing-certificate fingerprint and SHA-256 checksum shown beside it. A ZIP, third-party installer, device cleaner or download manager should not be required.

PRYNCE TV will not ask users to disable Google Play Protect, turn off Android security checks, grant broad storage/accessibility/SMS permissions for installation, or approve silent installs. Android's normal package-installer confirmation must remain enabled. If Android or Play Protect raises a warning, stop and investigate the exact build rather than bypassing the warning.

A public release is blocked until production signing, source/dependency review, security checks, GPL source/notice publication and physical-device installation tests are complete. Track this gate in [Safe public installer checklist](https://github.com/charlestettehprince/Prynce-tv/issues/5).

## Test the Android build

For straightforward phone installation and a short first-launch checklist, see the [Android test installation guide](docs/ANDROID_TEST_INSTALL_GUIDE.md). This is a debug-signed test build; Android's normal installation security prompts remain in effect.

## Updates across phone and TV

The selected update architecture is documented in [Universal update architecture](docs/UNIVERSAL_UPDATE_ARCHITECTURE.md). The intended design uses Play in-app updates on supported phones/tablets, store-managed updates for Android TV and Fire TV, and a secure remote manifest for non-executable feature/content configuration. The pinned OpenTV updater is configured by CI to check the PRYNCE TV GitHub release repository and uses PRYNCE TV update prompts. This source integration has passed a CI build; actual update installation and platform-specific store flows still require physical-device and store testing.

## Project documentation

- [Universal update architecture](docs/UNIVERSAL_UPDATE_ARCHITECTURE.md)
- [Project status and remaining acceptance gates](docs/PROJECT_STATUS.md)
- [Build plan](docs/PRYNCE_TV_BUILD_PLAN.md)
- [Device acceptance checklist](docs/DEVICE_ACCEPTANCE_CHECKLIST.md)
- [Channel source setup and troubleshooting](docs/CHANNEL_SOURCE_GUIDE.md)
- [Open-source engine decision](docs/OPEN_SOURCE_ENGINE_DECISION.md)
- [Open-source alternatives review](docs/OPEN_SOURCE_ALTERNATIVES_REVIEW.md)
- [Branding integration guide](docs/BRANDING_ASSET_INTEGRATION.md)
- [PRYNCE Master Brand & Founder Identity Standard](docs/PRYNCE_MASTER_BRAND_STANDARD.md)

## Build locally

The Android source is pinned as a Git submodule at `android/upstream`.

```bash
git clone --recurse-submodules https://github.com/charlestettehprince/Prynce-tv.git
cd Prynce-tv/android/upstream
./gradlew test assembleDebug
```

Use Java 17 and the Android SDK versions specified in the CI workflow.

## Licensing and distribution

The OpenTV upstream foundation is GPL-3.0-or-later. Preserve all upstream notices and comply with the licence, including providing corresponding source and required notices when distributing modified binaries. Review the upstream licence and all bundled dependency licences before release. Do not publish a modified APK as a finished release until the source, notices, privacy information and signing process are ready.

