# PRYNCE TV — Android App Build Plan

## Product direction
PRYNCE TV is a premium, simple-to-use media player for Android phones, Android TV, and Fire TV. The visual direction is near-black with restrained gold accents, a gold TV/play launcher mark, clear typography, and remote-friendly navigation on television.

## Technical baseline
- Starting point selected for evaluation: OpenTV (https://github.com/opentvproject/opentv).
- License: GPL-3.0-or-later. Preserve upstream notices and meet source-availability obligations for any redistributed modified build.
- Android compatibility target: Android 11 and newer.
- Initial build target: debug APK for controlled testing; production signing is a separate release task.
- Keep the upstream application ID during the first rebrand unless a deliberate migration and update-signature plan is approved.

## Product requirements
- One app experience that adapts to touch devices and TV remotes.
- Keep playback, search, categories, favourites, guide, history, and other useful upstream capabilities intact.
- Premium black/gold branding, app name, launcher icon, and TV banner.
- Clear first-run setup and accessible navigation.
- Use only media sources the user is authorised to access; the app does not bundle or provide channel content.

## Delivery phases and acceptance checks
1. **Repository baseline:** import and pin a reviewed upstream release; record source tag and licence.
2. **Branding:** apply PRYNCE TV name, black/gold palette, launcher icon, TV banner, and app copy without breaking resources.
3. **Build automation:** add CI for unit tests and debug APK artifact generation.
4. **Functional verification:** test startup, source setup, playback, search, favourites, guide, remote navigation, and error handling.
5. **Device verification:** install and test on Android 11 phone, a newer Android phone, and Android TV/Fire TV where available.
6. **Release readiness:** configure a persistent release signing key securely, versioning, privacy disclosures, and GPL source distribution.

## Current verified status
- GitHub repository access: available.
- Repository baseline: currently contains only the starter README; no Android source tree is present yet.
- OpenTV evaluation and technical direction: completed at planning level.
- PRYNCE TV code integration: not started.
- APK build: not started.
- Physical-device testing: not started.

## Important constraints
- Do not claim an APK or working app until a build succeeds and the artifact is checked.
- Do not replace licensing notices or remove upstream attribution.
- Do not bypass platform permissions, provider access controls, or content restrictions.
