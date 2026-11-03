# PRYNCE TV

PRYNCE TV is a premium Android media-player project for Android phones, Android TV and Fire TV.

**Visual direction:** near-black interface, restrained gold accents, clear touch controls and remote-first TV navigation.

## Verified build status — 3 November 2026

- Primary foundation: OpenTV v0.11.10, pinned as a Git submodule at `android/upstream`.
- Pinned upstream commit: `443811904b6437720d37bb1064c0830906c3515f`.
- Two latest documentation-triggered CI builds completed successfully:
  - [Run 41566614327](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41566614327) — tests, debug APK build and artifact upload passed.
  - [Run 41566629123](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41566629123) — tests, debug APK build and artifact upload passed.
- Both produced `prynce-tv-v0.11.10-debug`, approximately 28.9 MB. The artifacts expire on 17 November 2026.
- CI verifies compilation, automated tests and artifact upload. It does **not** verify physical-device installation, live-stream playback, Android TV/Fire TV behaviour, production signing or final logo correctness.
- Exact website/app logo and icon still need to be installed and visually verified. The current upstream-derived launcher mark remains provisional.

## Engine decision

Keep OpenTV as the primary foundation. It already supports the combined phone and TV target and provides source setup, M3U/M3U8 and provider login flows, guide data and playback features. Do not migrate just to try another engine while the current foundation builds.

Alternatives reviewed:
- [OpenIPTV](https://github.com/Hunter-Clipper/OpenIPTV) — Flutter-based player; a possible future option if a cross-platform UI becomes a real requirement.
- [OwnTV](https://github.com/ahXN00/OwnTV) — Android-TV-focused Kotlin player; useful as a TV UX reference, but not a better single foundation for the current phone-plus-TV target.
- [OpenTV Mobile](https://github.com/opentv-mobile) — phone-oriented derivative; not a replacement for the combined Android TV target.

All are player foundations, not entitlements to broadcast content. PRYNCE TV must only play streams the viewer is authorised to access. No DRM, subscription, account or geographic restriction circumvention.

## Project documentation

- [Consolidated build plan and acceptance gates](docs/PRYNCE_TV_BUILD_PLAN.md)
- [Open-source engine decision](docs/OPEN_SOURCE_ENGINE_DECISION.md)
- [Channel source guide and reliability checklist](docs/CHANNEL_SOURCE_GUIDE.md)

## Next acceptance gates

1. Confirm the exact original logo/icon assets and integrate them without redrawing or substituting them.
2. Install the debug APK on an Android 11+ phone and record the result.
3. Test source setup, permitted stream playback, EPG, search, favourites and network-error recovery.
4. Test remote focus/navigation on Android TV or Fire TV hardware.
5. Complete release signing, versioning, privacy disclosures and GPL source/notice packaging before public distribution.

## Licensing

OpenTV is GPL-3.0-or-later. Preserve upstream notices and meet the licence's corresponding-source requirements before distributing modified builds. Include applicable licence and attribution materials.

## Device acceptance

Use the [phone and TV device acceptance checklist](docs/DEVICE_ACCEPTANCE_CHECKLIST.md) before calling a release candidate ready. CI success alone does not establish physical-device compatibility or real-stream playback.

## Project status

See [the consolidated PRYNCE TV project status](docs/PROJECT_STATUS.md) for the current technical decisions, verified CI evidence, remaining acceptance gates and project estimate.
