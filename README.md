# PRYNCE TV

PRYNCE TV is being developed as a premium Android media-player app for Android phones, Android TV, and Fire TV.

**Design direction:** near-black interface, restrained gold accents, clear touch controls, and remote-friendly TV navigation.

## Verified development status

- The OpenTV v0.11.10 upstream baseline has passed GitHub Actions tests and debug APK compilation.
- A baseline debug APK was uploaded as a GitHub Actions artifact (run 41562771381).
- A separate PRYNCE TV branding build is being validated; do not treat it as complete until its own build and artifact upload pass.
- The upstream Android source is currently checked out temporarily during CI. It has not yet been permanently imported into this repository.
- No physical Android phone, Android TV, or Fire TV testing has been completed.

The selected foundation is [OpenTV](https://github.com/opentvproject/opentv). It is a media-player foundation, not a source of TV channels or subscriptions. Use only media sources you are authorised to access.

## Project documentation

- [Android build plan](docs/PRYNCE_TV_BUILD_PLAN.md)
- [Open-source engine decision and fallback](docs/OPEN_SOURCE_ENGINE_DECISION.md)

## Licensing

OpenTV is distributed under GPL-3.0-or-later. Before redistributing a modified build, preserve applicable notices and comply with the licence's corresponding-source requirements. The final repository must include the applicable licence and attribution materials.
