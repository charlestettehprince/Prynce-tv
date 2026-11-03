# PRYNCE TV — Android App Build Plan

## Product direction
PRYNCE TV is a premium, simple-to-use media player for Android phones, Android TV, and Fire TV. The visual direction is near-black with restrained gold accents, a gold TV/play launcher mark, clear typography, and remote-friendly navigation on television.

## Technical baseline
- Starting point: OpenTV v0.11.10, pinned as a Git submodule at `android/upstream`.
- Upstream source commit: `443811904b6437720d37bb1064c0830906c3515f`.
- License: GPL-3.0-or-later. Preserve upstream notices and meet source-availability obligations for any redistributed modified build.
- Android compatibility baseline: upstream minSdk 23; target user-device testing starts at Android 11 and newer.
- Initial build target: debug APK for controlled testing; production signing is a separate release task.
- Keep upstream application ID `app.opentv` for now. The debug variant adds upstream's `.debug` suffix. A package rename requires a deliberate migration and update-signature plan.

## Product requirements
- One app experience that adapts to touch devices and TV remotes.
- Keep playback, search, categories, favourites, guide, history, and other useful upstream capabilities intact.
- Premium black/gold branding, app name, launcher icon, and TV banner.
- Clear first-run setup and accessible navigation.
- Use only media sources the user is authorised to access; the app does not bundle or provide channel content.

## Delivery phases and acceptance checks
1. **Repository baseline — complete:** pin and track the reviewed upstream source; record source tag and licence.
2. **CI source integration — implemented, validating:** checkout the repository recursively and build from the pinned submodule.
3. **Branding — partial:** app name and initial black/gold theme substitutions are applied in CI. Launcher icon, TV banner, and detailed homepage polish remain.
4. **Build automation — baseline passed; submodule build validating:** unit tests and debug APK artifact generation are configured. Confirm the current submodule-based run succeeds before treating this as complete.
5. **Functional verification — pending:** test startup, source setup, playback, search, favourites, guide, remote navigation, and error handling.
6. **Device verification — pending:** install and test on Android 11 phone, a newer Android phone, and Android TV/Fire TV where available.
7. **Release readiness — pending:** configure a persistent release signing key securely, versioning, privacy disclosures, and GPL source distribution.

## Current verified status
- GitHub repository write access: working.
- Pinned Android source: committed as a Git submodule at `android/upstream`.
- CI successfully checked out the repository and submodule and completed Java/SDK setup and branding on run `41563754758`.
- The submodule-based Gradle test/build step is still running; APK upload has not yet completed for that run.
- A prior temporary-checkout upstream baseline build passed and produced a debug artifact. That is not proof that the new submodule-based workflow has passed.
- No physical-device testing has been completed.
- Launcher artwork and final branded homepage are not complete.

## Important constraints
- Do not claim an APK or working app until the relevant build succeeds and the artifact is checked.
- Do not claim device compatibility until installed and tested on the target hardware.
- Do not replace licensing notices or remove upstream attribution.
- Do not bypass platform permissions, provider access controls, or content restrictions.
- Keep credentials out of source control and build logs.
