# PRYNCE TV

PRYNCE TV is being developed as a premium Android media-player app for Android phones, Android TV, and Fire TV.

**Design direction:** near-black interface, restrained gold accents, clear touch controls, and remote-friendly TV navigation.

## Verified development status

- OpenTV v0.11.10 is pinned as a Git submodule at `android/upstream`, source commit `443811904b6437720d37bb1064c0830906c3515f`.
- GitHub Actions checks out the repository recursively, applies the current proof-of-concept PRYNCE TV branding, runs Gradle tests, and builds a debug APK.
- Latest verified build: [GitHub Actions run 41565825331](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41565825331) — **success**.
- Uploaded artifact: `prynce-tv-v0.11.10-debug` (about 28.9 MB); artifact retention ends 17 November 2026.
- CI success confirms tests/build completed and the APK artifact uploaded. It does **not** establish physical-device playback, Android TV/Fire TV compatibility, or final brand-asset correctness.
- Exact website/app logo and icon still require source-asset verification. Current upstream-derived launcher mark is provisional and must not be represented as the user's confirmed logo.

The selected foundation is [OpenTV](https://github.com/opentvproject/opentv). It is a media-player foundation, not a source of TV channels or subscriptions. Use only media sources you are authorised to access.

## Project documentation

- [Android build plan](docs/PRYNCE_TV_BUILD_PLAN.md)
- [Open-source engine decision and fallback](docs/OPEN_SOURCE_ENGINE_DECISION.md)
- [Channel source guide and reliability checklist](docs/CHANNEL_SOURCE_GUIDE.md)

## Licensing

OpenTV is distributed under GPL-3.0-or-later. Preserve applicable notices and comply with the licence's corresponding-source requirements before distributing modified builds. Include applicable licence and attribution materials with any distribution.
