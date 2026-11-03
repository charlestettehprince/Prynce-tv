# PRYNCE TV

PRYNCE TV is being developed as a premium Android media-player app for Android phones, Android TV, and Fire TV.

**Design direction:** near-black interface, restrained gold accents, clear touch controls, and remote-friendly TV navigation.

## Verified development status

- The OpenTV v0.11.10 upstream baseline passed GitHub Actions tests and debug APK compilation in run 41562771381.
- The pinned upstream source is now tracked permanently as a Git submodule at `android/upstream`, with its source commit fixed at `443811904b6437720d37bb1064c0830906c3515f`.
- GitHub Actions now checks out the repository recursively and builds from that pinned submodule, rather than fetching a separate temporary copy.
- The PRYNCE TV branded build using this new source layout is awaiting CI verification.
- No physical Android phone, Android TV, or Fire TV testing has been completed.

The selected foundation is [OpenTV](https://github.com/opentvproject/opentv). It is a media-player foundation, not a source of TV channels or subscriptions. Use only media sources you are authorised to access.

## Project documentation

- [Android build plan](docs/PRYNCE_TV_BUILD_PLAN.md)
- [Open-source engine decision and fallback](docs/OPEN_SOURCE_ENGINE_DECISION.md)

## Licensing

OpenTV is distributed under GPL-3.0-or-later. The upstream source remains separately identifiable as a pinned submodule. Before redistributing a modified build, preserve applicable notices and comply with the licence's corresponding-source requirements. The final distribution must include the applicable licence and attribution materials.
