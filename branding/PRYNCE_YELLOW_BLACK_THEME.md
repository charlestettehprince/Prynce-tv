# PRYNCE TV yellow / black / white theme patch

This patch is an original PRYNCE theme inspired by MTN Ghana's public yellow and black palette. It does not copy the MTN logo, proprietary artwork, typography, slogans, or page layouts, and does not imply MTN endorsement.

- Reference yellow: #FFCC00 (MTN MoMo developer brand guidance).
- PRYNCE dark surfaces: #090909 / #171717 / #222222.
- White text and restrained yellow for action, selection and TV focus.
- Light mode: white surfaces, black primary controls and yellow supporting highlights.
- Existing TV-first typography sizes remain unchanged in this first pass.

Target: OpenTV submodule commit 443811904b6437720d37bb1064c0830906c3515f
File: app/src/main/java/app/opentv/ui/theme/Theme.kt

The patch remains outside the upstream submodule and is applied only in the CI workspace before the debug build. The pinned OpenTV source and submodule pointer remain unchanged. CI run #31 successfully applied the patch and compiled the themed debug APK. This confirms patch compatibility and compilation, not visual contrast, focus navigation, playback or device acceptance; those still require phone and Android TV testing.
