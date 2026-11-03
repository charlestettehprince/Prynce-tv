# PRYNCE TV Channel Sources

## Goal

PRYNCE TV is a player. It should make it easy to organise channel sources that the viewer is authorised to use. The app does not bundle paid subscriptions, decrypt protected streams, or guarantee that a broadcaster is available in every country.

## Supported source types in the OpenTV foundation

- M3U / M3U8 playlists supplied by a broadcaster, network operator, or other authorised provider.
- Xtream-compatible account details supplied by an authorised IPTV provider.
- XMLTV / EPG guide data where supplied by the provider.
- Catch-up or archive playback only where the provider exposes it and the viewer is entitled to use it.

Exact feature availability depends on the pinned OpenTV version, provider format, and stream capabilities. Do not advertise a feature as working until it has been tested with a real permitted source.

## Recommended source catalogue

Organise sources into clear groups:

1. **Free-to-air** — official terrestrial or satellite broadcaster streams that are openly published for online playback, where available.
2. **Official broadcaster apps and websites** — link out when the broadcaster requires its own player or account.
3. **Provider playlists** — users enter a playlist URL or provider credentials they have permission to use.
4. **Personal media** — private streams or local network sources owned or administered by the user.

For every source, store its display name, source type, provider/owner, country or region, last checked time, and a short availability note. Never store passwords in logs or analytics.

## User experience requirements

- Provide separate actions for adding an M3U URL and an authorised provider account.
- Validate input and show a useful error without exposing credentials.
- Keep channel groups, favourites, search, and EPG data separate from the source connection itself.
- Show a clear state for loading, available, temporarily offline, unsupported, or access denied.
- Let the viewer remove a source and its locally cached guide data.
- Do not silently substitute an unrelated stream when a channel fails.
- Do not promise unrestricted geographic access. Display the broadcaster's own availability terms.

## Reliability checklist

- Test valid and malformed M3U files, empty playlists, duplicate channel names, missing logos, and long channel lists.
- Test missing, stale, and timezone-shifted EPG data.
- Test slow networks, DNS failures, expired provider sessions, and unavailable streams.
- Ensure network failures do not crash the app or freeze remote navigation.
- Keep secrets out of crash reports, debug output, screenshots, and analytics.
- Use HTTPS sources where the provider supports them.

## Legal and safety boundary

Only add streams that are openly offered for the intended use or that the user is authorised to access. Do not circumvent DRM, subscription checks, account controls, or geographic restrictions. A television or media player does not grant rights to third-party broadcasts.

## Current implementation status

This guide records the intended source experience. It is not proof that every source type has been implemented or tested in PRYNCE TV. The current CI workflow builds the pinned OpenTV foundation with provisional PRYNCE TV text and colour changes. Exact website/app logo verification and physical-device playback testing remain outstanding.
