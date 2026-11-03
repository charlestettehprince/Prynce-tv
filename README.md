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
- CI renders Android launcher artwork directly from these SVG sources.
- Branding integration and CI installation: [Branding asset integration guide](docs/BRANDING_ASSET_INTEGRATION.md).

The committed artwork is derived from the original assets supplied by the project owner. It is resized/compressed for Android use, not redrawn or recoloured.

## Build status

The GitHub Actions workflow checks out the pinned OpenTV submodule, installs the PRYNCE icon/banner into the Android drawable resources, applies the PRYNCE TV app label and theme, runs automated tests, builds a debug APK and uploads the artifact.

- [Latest workflow runs](https://github.com/charlestettehprince/Prynce-tv/actions)
- [Latest confirmed successful branded build](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41616019564)
- Recovery build commit: `cec03131f17111f5cf990b1b17f3aba7b94da2ea`.
- Artifact: `prynce-tv-v0.11.10-test-packages` (APK + AAB; GitHub Actions retention is temporary; artifact expires 1 February 2027).
- Verified APK SHA-256: `82eae4d7fdc22aa6907e0e49c7462761da99c480f283ff233a1c4e614877c020`. Verified AAB SHA-256: `2c4d987cf3745423aa16c72c5055125c5251d4a491f23b6a752257fe5015929a`.
- The latest APK and AAB passed archive-integrity and SHA-256 checks against the workflow checksum file. The debug APK report confirms package `app.opentv.debug`, version `0.11.10` (code 22), min SDK 23 and target SDK 35; it is signed with the Android Debug certificate, not a production key. **API 36 migration in progress:** CI run [#96](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41617047320) on commit `29dbd77d28bf8180558d5f45166d76059965badc` has passed the AGP 8.9.1 / compileSdk 36 / targetSdk 36 configuration step, Android SDK 36 installation, Ghana directory validation, launcher validation, updater integration, branding and navigation integration. The automated tests and APK/AAB compilation are still running; this is not yet a verified API 36 package. New phone/tablet Google Play submissions require target API 36 from 31 August 2026. Do not submit until the build, device checks, privacy/licence review and production signing pass.

**CI success is not device acceptance.** Physical Android phone, Android TV and Fire TV testing, authorised-source playback, launcher visual inspection, privacy/licence review and production signing remain required before public release.

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

