# PRYNCE TV yellow / black / white theme patch

This patch is an original PRYNCE theme inspired by MTN Ghana's public yellow and black palette. It does not copy the MTN logo, proprietary artwork, typography, slogans, or page layouts, and does not imply MTN endorsement.

- Reference yellow: #FFCC00 (MTN MoMo developer brand guidance).
- PRYNCE dark surfaces: #090909 / #171717 / #222222.
- White text and restrained yellow for action, selection and TV focus.
- Light mode: white surfaces, black primary controls and yellow supporting highlights.
- Existing TV-first typography sizes remain unchanged in this first pass.

Target: OpenTV submodule commit 443811904b6437720d37bb1064c0830906c3515f
File: app/src/main/java/app/opentv/ui/theme/Theme.kt

The patch is intentionally kept outside the upstream submodule. It is not applied to the app yet. Apply and validate only in a separate PR after confirming patch compatibility and testing contrast/focus on TV and phone.
