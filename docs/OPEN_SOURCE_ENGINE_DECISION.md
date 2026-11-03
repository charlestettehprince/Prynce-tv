# PRYNCE TV Open-Source Engine Decision

Last reviewed: 2026-11-03

## Decision

Keep **OpenTV v0.11.10** as the primary Android foundation for PRYNCE TV. It is the best fit for the current target because its upstream project explicitly supports one Android APK across phones, tablets, Android TV and Fire TV, and it already includes remote-first navigation and a broad playback/library feature set.

- Upstream: https://github.com/opentvproject/opentv
- Install and build documentation: https://opentvproject.github.io/opentv/
- Pinned baseline: tag v0.11.10
- License: GPL-3.0-or-later. Any redistributed modified build must comply with GPL source and notice obligations.

## Evaluated fallback

**OpenIPTV** is the practical fallback if the OpenTV build cannot be stabilized or if a Flutter-based shared UI becomes a priority.

- Upstream: https://github.com/Hunter-Clipper/OpenIPTV
- Stack: Flutter/Dart with native Android Media3 playback integration.
- The project describes Android phone/tablet and Android TV support.
- Its published setup requires Flutter 3.22+, Dart 3.4+, Java 17, Android SDK and code generation.
- License: GPL-3.0. Review its current dependency/licence notices before redistribution.

OpenIPTV is not being substituted now: changing foundations during an active build would add migration work and delay a reproducible APK.

## Other references

- OwnTV: https://github.com/ahXN00/OwnTV — Android TV-focused native Kotlin/Compose reference; not selected as the universal phone + TV baseline.
- Prysm: https://www.prysmplayer.com/ — useful UI and playback-engine reference; verify the linked source repository and licence before adopting any code.

## Engineering guardrails

1. Do not bypass authentication, licensing, repository permissions, platform security, or provider access controls. Resolve build and integration limits through supported configuration and open-source alternatives.
2. The player must ship without bundled channel lists, subscriptions, or media streams. Users are responsible for sources they are authorised to access.
3. Keep the upstream licence, copyright notices and corresponding-source obligations intact.
4. Preserve the current application ID until package migration and update-signature consequences are deliberately planned.
5. Require a passing CI build and an uploaded APK artifact before reporting a build milestone as complete.
6. Do not claim Android 11/TV device compatibility from compilation alone; verify on physical devices or emulators.

## Current integration state

The GitHub repository currently contains project documentation and workflow automation. The upstream Android source is checked out temporarily by CI; it has not yet been permanently committed into this repository. Build-time branding is a proof-of-concept, not a finished visual rebrand.
