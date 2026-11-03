# PRYNCE TV — Simple Home, Ghana TV and Offline Viewing

## Product decision

Keep the existing OpenTV v0.11.10 engine pinned at its current commit. Do not replace the engine with a TV-only fork: the selected upstream already targets Android phones, tablets, Android TV and Fire TV in one APK. The separate OpenTV Mobile fork is phone-focused and would create a second product line; OwnTV is Android-TV-only. The migration cost is not justified.

## Experience goal

A first-time viewer should be able to open PRYNCE TV and understand the first action immediately, with large touch targets on phones and clear D-pad focus on televisions. Do not promise literal independent use by a three-year-old; use a supervised, age-appropriate Kids profile for young viewers.

### Home screen hierarchy

1. **Watch Live** — primary large button.
2. **Ghana TV** — curated directory of official broadcaster destinations and verified streams.
3. **Movies & Shows** — content from the viewer's authorised source.
4. **My Downloads** — locally stored, playable files and any provider-permitted offline downloads.
5. **Continue Watching** — resume supported titles.
6. **Settings** — secondary, not on the primary action path.

Keep the supplied PRYNCE logo/wordmark unchanged. Use the existing black/navy and gold brand palette, readable labels, high contrast, large controls, short onboarding and visible Back/Home behaviour.

## First-run flow

- Launch directly into the home screen; no account wall.
- Show one clear action: **Add TV source**.
- Offer two understandable routes: **Official free channels** and **Add my TV service**.
- Explain that PRYNCE TV is a player and does not itself provide paid channels, movie rights or subscriptions.
- Support QR/phone-assisted setup where already supported by the upstream app.
- Include a demo/local sample mode only with synthetic or properly licensed sample media.
- Never bundle private playlists, scraped streams, paid-channel restreams or unlicensed movie files.

## Ghana and international channels

- Build a maintained catalogue of broadcaster-owned official websites/apps/streams, with channel name, country, language, category, official destination, source owner, verification date and availability status.
- Start Ghana catalogue research with Ghana Broadcasting Corporation channels (GTV, GTV 24, GTV Govern, GTV Life and GTV Sports+), then add other broadcasters only after confirming their official distribution and reuse permissions.
- Add international public broadcasters only through their own official streaming endpoints or an authorised provider.
- If a broadcaster offers only an official web player, open that official destination in a safe in-app browser or external browser rather than extracting or proxying its stream.
- Do not assume that an NCA-licensed terrestrial channel automatically grants online retransmission rights.
- Do not hard-code unstable third-party stream URLs. Do not promise every channel is available in every country.

## Offline and online behaviour

- **Online:** live channels, EPG, authorised VOD and provider content.
- **Offline:** play files selected/imported by the user, plus downloads explicitly permitted by the content owner/provider and supported by the app.
- Live TV cannot play without a network or a local broadcast tuner. Clearly label live channels as online.
- Show download progress, storage use, retry and delete controls. Respect DRM and provider download restrictions; do not capture protected streams.

## Child-friendly safeguards

- Offer a parent-managed Kids profile with age-appropriate catalogue filtering where metadata exists.
- Keep external links, source editing and advanced settings behind a parent PIN.
- No autoplay by default; show clear pause/stop controls and a simple sleep timer.
- Do not claim perfect age ratings where metadata is absent. Show a neutral warning and let the parent decide.

## Engineering acceptance checklist

- One application ID and signing identity across compatible Android phone/TV/Fire TV builds.
- No first-launch crash; home screen loads without a provider.
- Phone touch and TV D-pad flows both tested.
- Ghana catalogue entries are official, checked and labelled by source type.
- No stream bundled unless written permission/licence is recorded.
- Offline local-file playback tested in airplane mode.
- Provider-authorised downloads tested separately from ordinary local files.
- Live playback, reconnect, slow-network and unavailable-channel states tested.
- APK install, upgrade signature, app data retention and rollback tested on real devices.
- Release APK must be production-signed; debug-signed builds are test-only.
- GPL-3.0-or-later notices and corresponding source obligations are preserved.

## Evidence and alternatives reviewed

- OpenTV upstream: https://github.com/opentvproject/opentv — one app for phones/tablets/Android TV/Fire TV; M3U/Xtream, EPG, VOD, DVR and player features.
- OpenTV Mobile: https://github.com/opentv-mobile — phone-focused fork; not selected because it creates a second device-specific product line.
- OwnTV: https://github.com/ahXN00/OwnTV — Android TV-only; not selected because PRYNCE TV needs one cross-device APK.
- Ghana NCA authorised-station data: https://nca.org.gh/ — use as a broadcaster verification source, not as permission to retransmit streams.
- GBC official website: https://www.gbcghanaonline.com/
- Joy News official channel page: https://www.multitvworld.com/joynews/
- Joy live page: https://www.myjoyonline.com/live/
- Max TV live page: https://max.com.gh/tv/
- DStv Ghana official streaming information: https://www.dstv.com/en-gh/

## Status

This document records the implementation target and source-selection rules. It does not mean the simplified home screen, Ghana channel catalogue, offline downloads or child profile have already been implemented. Each requires code changes and device testing before it can be marked complete.
