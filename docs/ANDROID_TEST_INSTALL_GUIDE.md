# PRYNCE TV — Simple Android test instructions

This guide is for the **debug-signed API 36 test APK**, not a public production release.

## Install on an Android phone

1. Download the file named `PRYNCE-TV-api36-test.apk` from the test-build link supplied in the project conversation.
2. Open the phone's **Files** app (or Downloads) and tap the downloaded APK.
3. If Android displays its normal warning, check that the file is the PRYNCE TV test APK you intentionally downloaded. Android may ask you to allow the Files app or browser to install this one file. Only grant that permission if you trust the file and understand the prompt.
4. Return to the installer and tap **Install**.
5. Open **PRYNCE TV** from the app list.

Android's security prompts are expected for a sideloaded test APK. Do not try to disable Android security protections or install files from unknown sources.

## Record your test result

Use the [device test report template](DEVICE_TEST_REPORT_TEMPLATE.md) to record phone and TV results separately.

## First-launch checks

- [ ] Installation completes without an error.
- [ ] PRYNCE TV opens and does not immediately close.
- [ ] App name and approved icon display correctly.
- [ ] Main screen loads without a blank or endless loading state.
- [ ] Back navigation behaves normally.
- [ ] Search, favourites and menus respond.
- [ ] Add only a playlist/provider source you are authorised to use.
- [ ] Test playback only with an authorised source.
- [ ] Close and reopen the app; confirm it starts normally.

## Report a result

Record only non-sensitive details:

- Device model:
- Android version:
- PRYNCE TV version: 0.11.10 (code 22)
- Result: Pass / Failed / Blocked
- Where it stopped:
- Error wording (remove personal details):
- Optional screenshot with account names, URLs, passwords and personal information hidden:

Never send playlist passwords, provider credentials, private URLs, account tokens or other secrets in a bug report.

## Important limitations

- This is a test package signed with the Android Debug certificate. It is not a production-signed public release.
- The test package is built for API 36 and supports ARM64, ARMv7, x86 and x86_64 ABIs.
- Phone installation does not prove Android TV or Fire TV compatibility. Those platforms need separate physical-device tests with a remote.
- A successful install does not prove every provider or stream works. Availability depends on the authorised provider, device and network.
