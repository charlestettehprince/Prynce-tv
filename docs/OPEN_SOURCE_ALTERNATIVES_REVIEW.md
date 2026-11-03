# PRYNCE TV — Open-source alternatives review

**Reviewed:** 3 November 2026  
**Decision:** Keep the pinned OpenTV v0.11.10 engine. Do not replace the working Android foundation for a speculative speed gain.

## Requirements that control the decision

- One Android app for phones/tablets and Android TV/Fire TV.
- Preserve the existing PRYNCE branding and current working build pipeline.
- Keep the project maintainable with a reproducible open-source build.
- Do not bundle channels or credentials. Viewers supply sources they are authorised to use.
- No DRM, authentication, subscription, regional, or broadcaster-control circumvention.

## Options reviewed

| Project | Strengths visible in public project information | Fit / trade-off |
|---|---|---|
| OpenTV (current) | Kotlin Android app; phone, tablet, Android TV and Fire TV; M3U/M3U8, Xtream, XMLTV; remote-first; GPL-3.0-or-later | Best fit: already pinned, branded and building in this repository. Lowest migration risk. |
| OpenIPTV | Flutter; phone and Android TV; M3U/Xtream, XMLTV, Media3-based playback; GPL-3.0 | Plausible future alternative, but replacing the current engine means redoing branding, build, acceptance and migration work. No demonstrated requirement currently justifies it. |
| OwnTV | Native Kotlin/Compose for TV; Media3 plus mpv; M3U/Xtream/Stalker features; GPLv3 | TV-focused, so it does not meet the single phone + TV app requirement as directly. |
| Prysm | Publicly describes Android + Android TV, dual playback engines and MIT licensing | Interesting candidate, but its claims and repository/build maturity have not been independently validated in this project. Not selected. |

## Fresh review — phone-first fork and current Android media stack

**Checked:** 3 November 2026

- OpenTV Mobile is a phone-oriented fork based on OpenTV. Its own project description says it reworks the interface around portrait browsing and touch controls. It is a useful reference for phone UX, but adopting it as the main codebase would not remove the need for TV-specific D-pad work and regression testing.
- Android's official Media3 1.11 announcement describes Compose player controls with FocusRequester support for D-pad and keyboard navigation. Android's current TV playback guidance also recommends MediaSession integration and explains how to delegate remote key events to the player.
- This is a technology review only. The current PRYNCE build is already compiling; there is no verified evidence yet that swapping engines or upgrading dependencies would improve playback on the user's actual devices. Do not make a dependency upgrade solely from a version announcement.

**Updated recommendation:** Keep the pinned OpenTV base. Borrow phone-first interaction ideas from OpenTV Mobile only where they can be implemented as a small, separately tested UI improvement. Audit the current Media3 dependency version in the upstream submodule before planning any upgrade; do not assume it is already on 1.11.

## Quick alternative / best decision

The quick, low-risk alternative is **not an engine migration**. Continue with OpenTV and improve the existing build and acceptance path:

1. Keep the exact pinned OpenTV submodule; only update it after a reviewed upstream release and a passing regression build.
2. Run automated tests and APK build on every relevant change.
3. Validate the Android TV banner (320×180), launcher icon, app launch, D-pad focus and remote-only operation.
4. Test installation and playback on real Android 11+ phone hardware and a real Android TV/Fire TV device.
5. Test only a source the tester is authorised to access.
6. Complete release signing, privacy disclosures, and GPL-3.0-or-later corresponding-source and notice obligations before distribution.

## Quality reference

Google's Android TV quality guidance distinguishes TV Ready, TV Optimized and TV Differentiated. The immediate baseline is to pass TV Ready requirements, including launcher icon/banner and reliable operation. A successful CI build alone does not prove those device-level requirements.

## Evidence and limitations

This is a desk review of public project descriptions and Android documentation, not a benchmark. No comparative performance tests were run. Claims such as "zero lag" or broad codec compatibility should not be treated as verified without controlled device tests.

## Sources

- OpenTV project: https://github.com/opentvproject/opentv
- OpenTV Mobile phone-first fork: https://github.com/opentv-mobile
- Android Media3 1.11 announcement: https://android-developers.googleblog.com/2026/08/media3-1-11-whats-new.html
- Android TV Media3 playback guidance: https://developer.android.com/media/media3/ui/androidtv
- OpenIPTV project: https://github.com/Hunter-Clipper/OpenIPTV
- OwnTV project: https://github.com/ahXN00/OwnTV
- Prysm project site: https://www.prysmplayer.com/
- Android TV app quality: https://developer.android.com/docs/quality-guidelines/tv-app-quality

## Reconsider migration only if

A reproducible blocker is found in OpenTV that cannot reasonably be fixed upstream or locally; a candidate passes a clean build and licence review; and it demonstrates better phone + TV compatibility on the actual target devices. Any migration must preserve the user's branding and be approved before replacing the current engine.
