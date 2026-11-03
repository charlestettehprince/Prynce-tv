# PRYNCE TV — tester distribution runbook

Status: prepared, not activated  
Last reviewed: 3 November 2026

## Recommended route

Use Firebase App Distribution for controlled pre-release testing. It supports APK uploads, tester groups, email invitations and tester-access links. This is a distribution workflow, not a public unrestricted download page.

Official guides:
- Console distribution: https://firebase.google.com/docs/app-distribution/android/distribute-console
- CLI distribution: https://firebase.google.com/docs/app-distribution/android/distribute-cli
- Android app registration: https://firebase.google.com/docs/android/setup
- Tester onboarding: https://firebase.google.com/docs/app-distribution/get-set-up-as-a-tester

## Do not register the current package prematurely

Build #100 uses application ID `app.opentv.debug`. The project still needs an explicit final application ID decision. Firebase warns that the Android package name entered during app registration is case-sensitive and cannot be changed for that Firebase Android app later.

Therefore:
1. Confirm the intended long-term package/application ID first.
2. If the team deliberately wants a separate QA-only identity, define and document that identity separately from production.
3. Register the exact chosen package name in Firebase.
4. Create/select the Firebase project and obtain its Firebase Android App ID.
5. Upload a reviewed APK using Firebase Console or the Firebase CLI.
6. Invite only the intended testers or tester group and include version, known limitations and feedback instructions.
7. Verify that invited testers can accept the invitation and download/install the build.
8. Record the release link, build commit, checksum, signer certificate fingerprint, tester group and expiry in the project status log.

## Required owner-side setup

The Firebase project owner or authorised project member must perform the console sign-in and project registration. For CLI automation, the release operator must authenticate Firebase CLI or configure a protected service-account credential. Never put refresh tokens, service-account JSON, keystore files or signing passwords in Git, issue comments, chat, or public workflow logs.

Required values after setup:
- Firebase project ID (non-secret identifier)
- Firebase Android App ID (non-secret identifier)
- Exact Android application ID registered
- Approved tester emails or tester-group name
- Authenticated release operator or protected CI credential

Do not send secrets into chat. Configure credentials directly in the relevant provider console or repository secret store.

## Build and safety checks before upload

- Confirm the build is intentionally a test build and is labelled accordingly.
- Confirm package ID and version match the Firebase app registration.
- Verify APK SHA-256 and signing certificate.
- Keep Android's system installer confirmation and Play Protect enabled.
- Investigate any device security warning; never tell testers to disable protections.
- Do not distribute the debug-signed Build #100 APK as a production/stable release.
- Keep GPL-3.0-or-later notices and corresponding source available for the exact modified build.
- Do not include private provider credentials, API keys or signing secrets in the app or build logs.

## Tester feedback plan

Ask testers to report:
- Device model and Android/Fire TV version
- Install/startup result
- Navigation and remote-control behaviour
- Ghana directory link behaviour
- Local media playback result
- Playback issues with a concise description of the file/provider format (do not share account passwords)
- Crash steps and approximate time
- Suggestions

Do not request passwords, private provider credentials, or unnecessary personal information.

## Current state

No Firebase project/app registration, Firebase App ID, authenticated CLI session, tester group, upload, or tester link has been verified for PRYNCE TV. This runbook is preparation only; it does not claim distribution has occurred.

The public application ID, production signing identity, physical-device acceptance and release approval remain separate gates tracked in:
- https://github.com/charlestettehprince/Prynce-tv/issues/3
- https://github.com/charlestettehprince/Prynce-tv/issues/4
- https://github.com/charlestettehprince/Prynce-tv/issues/5


## Latest available test package — Build #107

- Workflow run: [41629319388](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41629319388) — completed successfully.
- Commit: `eb7af7bcb8892ccde353dc6ac7c966c6543501a2`.
- Artifact: `prynce-tv-v0.11.10-test-packages` (artifact ID `13228535438`).
- APK application ID: `app.opentv.debug`; version `0.11.10`, versionCode `22`; min SDK `23`, target/compile SDK `36`.
- APK SHA-256: `2c653ce3ff06e8a9fe32ca2eb53395b3f2b352c6fdc1cdb74aab57bae796a9c1`.
- The APK uses the Android Debug certificate. It is for controlled testing only, not a production release.
- CI tests/build, package integrity, checksum and APK signature checks passed. Android Lint completed with 187 findings (184 warnings, 3 informational; zero errors/fatal).
- Artifact expiry: 1 February 2027. Confirm availability before distributing.

## Device acceptance checklist

Record a result for each target form factor separately; do not infer Android TV or Fire TV acceptance from a phone test.

### Android phone/tablet
1. Install the debug APK using Android's normal installer flow; keep Play Protect and system security protections enabled.
2. Launch PRYNCE TV and confirm startup, app identity and navigation.
3. Open the Ghana TV directory and verify that a selected official HTTPS destination opens in the expected browser/app.
4. Test local video by selecting a user-owned sample through the system file picker; note whether audio/video and seeking work.
5. Exercise search, favourites, history, guide, audio/subtitle selection where available, background/resume and network loss/recovery.
6. Record crashes, blank screens, excessive heat/battery use, and exact reproduction steps.

### Android TV / Google TV
1. Install only through an authorised test route and launch from the TV home screen.
2. Navigate using the physical remote only: D-pad, Select, Back and playback keys.
3. Confirm visible focus at every step, sensible focus restoration, no keyboard/touch-only dead ends, and readable text at normal viewing distance.
4. Open an official broadcaster destination and verify the TV's browser/app handoff.
5. Test authorised media playback, pause/resume, channel navigation and network recovery.

### Fire TV (separate acceptance)
1. Test only on a Fire TV device and record Fire OS version.
2. Verify remote-only focus, app launch, browser handoff and authorised media playback.
3. Do not assume Google Play services or Play in-app updates are available.

### Tester report template
- Device model:
- OS / Android TV / Fire OS version:
- App version and build:
- Install and launch: Pass / Fail
- Remote/touch navigation: Pass / Fail / N/A
- Official channel link handoff: Pass / Fail
- User-owned local video: Pass / Fail / N/A
- Playback, audio and subtitles: Pass / Fail / N/A
- Network recovery: Pass / Fail
- Crash or issue reproduction steps:
- Screenshot/video evidence (remove personal data first):

Do not include passwords, provider credentials, personal account details or private playlist URLs in reports.
