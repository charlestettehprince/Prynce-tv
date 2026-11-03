# PRYNCE TV Open-Source Engine Decision

Last reviewed: 2026-11-03

## Decision

Keep **OpenTV v0.11.10** as the primary Android foundation for PRYNCE TV. It is the current best fit because the upstream project targets Android phones/tablets and Android TV/Fire TV and provides an existing media-player feature set.

- Upstream: https://github.com/opentvproject/opentv
- Documentation: https://opentvproject.github.io/opentv/
- Pinned source commit: `443811904b6437720d37bb1064c0830906c3515f`
- Repository path: `android/upstream` (Git submodule)
- License: GPL-3.0-or-later. Any redistributed modified build must comply with source and notice obligations.

## Build verification

GitHub Actions run [41565825331](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41565825331) completed successfully on 2026-11-03. It checked out the pinned submodule, set up Java 17 and Android SDK 35, applied build-time branding, ran `./gradlew test assembleDebug --no-daemon`, and uploaded `prynce-tv-v0.11.10-debug`.

This is a successful CI build, not proof of physical-device or streaming-provider compatibility.

## Evaluated fallback

**OpenIPTV** is the practical fallback if OpenTV cannot be stabilized or a Flutter-based shared UI becomes a priority.

- Upstream: https://github.com/Hunter-Clipper/OpenIPTV
- Stack: Flutter/Dart with native Android Media3 playback integration.
- License: GPL-3.0. Review current dependency and licence notices before redistribution.

Do not migrate during a successful build cycle without a demonstrated technical reason; migration would add risk and delay device validation.

## Other references

- OwnTV: https://github.com/ahXN00/OwnTV — Android TV-focused native Kotlin/Compose reference.
- Prysm: https://www.prysmplayer.com/ — UI and playback-engine reference; verify source availability and licence before adopting code.

## Engineering guardrails

1. Do not bypass authentication, licensing, repository permissions, platform security, or provider access controls. Resolve limitations through supported configuration and open-source alternatives.
2. Do not bundle channel lists, subscriptions, or media streams. Users must use sources they are authorised to access.
3. Preserve upstream licence, copyright notices and corresponding-source obligations.
4. Keep the current application ID until package migration and update-signature consequences are deliberately planned.
5. Require passing CI and an uploaded APK before reporting a build milestone complete.
6. Do not claim Android 11/TV device compatibility from compilation alone; verify on physical devices or emulators.
7. Treat the current upstream-derived launcher mark as provisional until the exact website/app logo and icon are verified.

## Current integration state

The upstream Android source is permanently tracked as a pinned Git submodule at `android/upstream`. CI builds from that source. The current black-and-gold changes are applied at build time and are a proof-of-concept, not a finished visual rebrand.
