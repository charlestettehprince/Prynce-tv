# PRYNCE TV

**Beyond ordinary.** A branded Android media player for Android phones, Android TV and Fire TV, built on the pinned OpenTV v0.11.10 open-source foundation.

## Product scope

PRYNCE TV is a player, not a broadcaster or channel subscription service. Viewers add playlists or provider details they are authorised to use. The app must not circumvent DRM, authentication, subscriptions, geographic restrictions or broadcaster controls.

Core upstream capabilities include M3U/M3U8 playlists, Xtream-compatible provider connections, XMLTV programme guides, search, favourites, history and remote-friendly navigation. Availability of individual playback features depends on the provider and device.

## PRYNCE branding

- App name: **PRYNCE TV**
- Visual direction: near-black/navy with restrained gold accents.
- Launcher icon: `branding/prynce_tv_icon.png`
- Android TV banner: `branding/prynce_tv_banner.png`
- Branding integration and CI installation: [Branding asset integration guide](docs/BRANDING_ASSET_INTEGRATION.md).

The committed artwork is derived from the original assets supplied by the project owner. It is resized/compressed for Android use, not redrawn or recoloured.

## Build status

The GitHub Actions workflow checks out the pinned OpenTV submodule, installs the PRYNCE icon/banner into the Android drawable resources, applies the PRYNCE TV app label and theme, runs automated tests, builds a debug APK and uploads the artifact.

- [Latest workflow runs](https://github.com/charlestettehprince/Prynce-tv/actions)
- [Latest confirmed successful branded build](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41589652107)
- Artifact name: `prynce-tv-v0.11.10-debug` (approximately 28.9 MB; GitHub Actions retention is limited).

**CI success is not device acceptance.** Physical Android phone, Android TV and Fire TV testing, actual authorised-source playback, launcher visual inspection and release signing remain required before public release.

## Project documentation

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

