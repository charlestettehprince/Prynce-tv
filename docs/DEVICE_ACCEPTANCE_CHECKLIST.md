# PRYNCE TV — Device Acceptance Checklist

This checklist separates automated build evidence from real-device acceptance. A green CI run proves that the configured Gradle tests and APK build completed; it does not prove playback, remote-control usability, or compatibility on a physical device.

## 1. Build and package checks

- [ ] Confirm the latest GitHub Actions run uses the current `main` commit.
- [ ] Confirm unit tests pass.
- [ ] Confirm the debug APK artifact was uploaded and has not expired.
- [ ] Install the APK on a test device running Android 11 or later.
- [ ] Confirm the app launches without a crash.
- [ ] Confirm the displayed app name is PRYNCE TV.
- [ ] Confirm the launcher icon is the approved original PRYNCE asset. Do not accept a traced, recolored, or substitute mark as final branding.

## 2. Phone acceptance

- [ ] Add a test M3U/M3U8 source that the tester is authorized to use.
- [ ] Add an XMLTV guide only when a matching guide source is available.
- [ ] Confirm invalid or empty source input produces a clear message.
- [ ] Confirm the source can be edited or removed.
- [ ] Confirm channel categories, search, favourites, and recent history behave sensibly.
- [ ] Confirm playback starts and stops reliably with the authorized test source.
- [ ] Test portrait and landscape layouts.
- [ ] Test app background/foreground and device rotation.
- [ ] Confirm network loss produces a recoverable error rather than a crash.

## 3. Android TV / Fire TV acceptance

- [ ] Install and launch on a real Android TV or Fire TV device.
- [ ] Navigate all primary screens using only the D-pad and Select/Back buttons.
- [ ] Confirm focus is always visible and moves in a predictable order.
- [ ] Confirm focus does not become trapped in menus or dialogs.
- [ ] Confirm channel lists and player controls are readable at normal TV distance.
- [ ] Confirm Back returns to the expected previous screen.
- [ ] Confirm playback controls can be reached without a touchscreen.
- [ ] Verify the TV launcher banner and icon after approved brand assets are integrated.

## 4. Playback and source rules

- Use only free-to-air sources, public streams, or subscriptions and playlists the tester is authorized to access.
- Do not bundle third-party channel lists, paid channel credentials, or streams without redistribution permission.
- A successful source import is not proof that every channel is available; stream uptime, account entitlement, network quality, and regional availability remain provider-dependent.
- Do not attempt to bypass DRM, authentication, subscription checks, geo-restrictions, or broadcaster access controls.

## 5. Release blockers

A release candidate is not ready until:
1. The exact approved PRYNCE icon and wordmark are integrated without redesign.
2. Phone testing passes on at least one physical Android 11+ device.
3. TV navigation passes on at least one physical Android TV/Fire TV device.
4. Playback passes with at least one authorized test source.
5. GPL-3.0-or-later notices and corresponding-source obligations for redistributed modified OpenTV builds are reviewed.

## 6. Test record

Record each test with:
- Date and tester
- Device model and Android/Fire OS version
- App version / Git commit
- Source type (do not record passwords or private credentials)
- Steps performed
- Expected result and actual result
- Screenshot or short screen recording, with credentials and personal information hidden
- Pass / Fail / Blocked and a concise issue description
