# PRYNCE TV — Device Acceptance Checklist

This checklist separates automated build evidence from real-device acceptance. A green CI run proves that configured Gradle tests and the APK build completed; it does not prove launcher appearance, playback, remote-control usability, or physical-device compatibility.

## 1. Build and package checks

- [ ] Confirm the latest GitHub Actions run uses the current `main` commit.
- [ ] Confirm unit tests pass and the debug APK artifact was uploaded.
- [ ] Confirm the artifact is current; GitHub Actions artifacts expire according to workflow retention.
- [ ] Install on a physical Android 11+ phone and confirm clean launch.
- [ ] Confirm the displayed app name is PRYNCE TV.
- [ ] Confirm the launcher uses the exact approved PRYNCE artwork; do not accept a traced, recoloured, or substitute mark.
- [ ] Record the package/application ID, version name, version code, APK size and SHA-256 for each candidate.

## 2. Phone acceptance

- [ ] Add a test M3U/M3U8 source the tester is authorised to use.
- [ ] Add XMLTV guide data only when a matching guide source is available.
- [ ] Confirm invalid or empty source input produces a clear, recoverable message.
- [ ] Confirm a source can be edited and removed.
- [ ] Confirm categories, search, favourites and recent history behave sensibly.
- [ ] Confirm playback starts, pauses, resumes and stops with the authorised test source.
- [ ] Test portrait and landscape layouts.
- [ ] Test app background/foreground, rotation and network loss/recovery.
- [ ] Confirm errors do not crash the app or leave an indefinite blank/loading screen.

## 3. Android TV / Fire TV acceptance

- [ ] Install and launch on physical Android TV hardware; record device model and OS version.
- [ ] Confirm the app appears in the TV launcher.
- [ ] Confirm the banner is exactly 320×180 px, opaque, and visibly says PRYNCE TV.
- [ ] Confirm the TV launcher icon meets current Android TV guidance (at least 160×160 px at xhdpi); prepare a high-resolution 512×512 store icon for Play listing assets.
- [ ] Navigate every primary screen using only D-pad, Select and Back.
- [ ] Confirm focus is always visible, predictable and never trapped.
- [ ] Confirm no controls or text are clipped by screen edges/overscan.
- [ ] Confirm text and controls are readable from normal TV viewing distance.
- [ ] Confirm Back returns to the expected previous screen and ultimately exits to the TV launcher.
- [ ] Confirm playback controls work without touch input.
- [ ] Test pause/resume, seek, subtitles/audio options where supported, and return from the TV home screen.
- [ ] Test both 1080p and 4K display modes where available.

## 4. Google Play / release compatibility checks

Before any Google Play submission, re-check the live Play Console and Android requirements for the target release date.

- [ ] Produce an Android App Bundle (AAB) for Play distribution; the current CI debug APK is not a Play release package.
- [ ] Verify 32-bit and 64-bit ABI support and 16 KB page-size compatibility for native libraries. Google Play has required 16 KB page-size support for new apps and updates targeting Android 15+ since 1 November 2025.
- [ ] Verify the manifest declares TV launcher support and does not require touchscreen hardware for TV use.\n- [ ] Verify the TV launcher icon/banner resources are correctly referenced and visible on-device; the current 320×180 banner is the expected TV banner size.
- [ ] Capture genuine, unaltered, high-resolution 16:9 screenshots from the actual TV app.
- [ ] Confirm app title, launcher banner title and store listing name match exactly.
- [ ] Complete privacy disclosures, support contact, content-source explanation and policy review.
- [ ] Configure secure release signing; never commit keystores, signing passwords or private credentials.

## 5. Playback and source rules

- Use only public/free-to-air sources or subscriptions and playlists the tester is authorised to access.
- Do not bundle third-party channel lists, paid channel credentials or streams without redistribution permission.
- A successful source import is not proof that every channel is available; uptime, entitlement, network quality and regional availability remain provider-dependent.
- Do not bypass DRM, authentication, subscriptions, geographic restrictions or broadcaster access controls.

## 6. Release blockers

A public release candidate is not ready until:
1. Exact approved PRYNCE icon and wordmark assets are integrated and visually approved.
2. Phone testing passes on at least one physical Android 11+ device.
3. TV navigation passes on at least one physical Android TV/Fire TV device.
4. Playback passes with at least one authorised test source.
5. The icon/banner meet current platform asset requirements.
6. AAB, ABI and 16 KB page-size checks pass for the intended Play release.
7. GPL-3.0-or-later notices and corresponding-source obligations for redistributed modified OpenTV builds are reviewed.
8. Release signing, privacy disclosures and support information are ready.

## 7. Test record

For every test, record:
- Date and tester
- Device model and Android/Fire OS version
- App version, package ID and Git commit
- Source type only (never record passwords or private credentials)
- Steps performed
- Expected result and actual result
- Screenshot or short recording, with credentials and personal information hidden
- Pass / Fail / Blocked and concise issue description

## Official platform references

- [Android TV app quality guidelines](https://developer.android.com/docs/quality-guidelines/tv-app-quality)
- [Google Play multi-platform app quality guidelines](https://support.google.com/googleplay/android-developer/answer/18058043)
