# PRYNCE TV — Source Audit: Simple Home and Offline Media

**Audit date:** 3 November 2026  
**Repository:** `charlestettehprince/Prynce-tv`  
**Pinned engine:** OpenTV commit `443811904b6437720d37bb1064c0830906c3515f`

## Files inspected

- `app/src/main/java/app/opentv/ui/MainScreen.kt`
- `app/src/main/java/app/opentv/ui/channels/HomeScreen.kt`
- `app/src/main/java/app/opentv/OpenTvApp.kt`
- Recursive source tree for the pinned engine commit.

## Confirmed current behaviour

1. The app shell currently uses a left navigation rail with separate Live, Movies, Shows and Recordings tabs. Search, Profiles and Settings are also in the rail.
2. The Live tab opens the existing channel guide, not a separate simplified consumer home.
3. The Live guide has category navigation, channel rows, optional live preview, EPG information and channel playback.
4. The Movies and Shows screens are separate catalogue screens.
5. Profiles and parental-control screens exist in the source tree.
6. App startup schedules catalogue synchronisation, EPG refresh, recording recovery and optional NAS sync.
7. The existing project does not expose a dedicated local-media browser or general offline-download feature in the audited source tree. The current source tree search found no dedicated download/offline/local-media implementation.
8. The existing engine has recording/DVR and NAS recording support; these are not equivalent to importing arbitrary local videos or provider-authorised offline downloads.

## Implementation implications

- Do not describe offline downloads as implemented. First add a local-media feature based on Android's Storage Access Framework / user-selected media URIs, then test playback with the device in airplane mode.
- Keep recordings, local files and provider downloads as distinct content types in the UI and data model.
- The simplified home should be a new, explicit home destination above the existing feature screens. Preserve the existing guide and catalogue screens as destinations rather than replacing working functionality.
- The Ghana TV directory should open verified official broadcaster destinations unless a direct stream is explicitly published for public playback with appropriate permission.
- Keep all provider credentials and private playlist URLs user-supplied; never hard-code or bundle them.
- Parent PIN and profiles are present, but their exact gating behaviour must be tested before claiming external links or source editing are parent-protected.

## Next implementation sequence

1. Add a simple home route and large, focusable cards for Watch Live, Ghana TV, Movies & Shows, My Downloads and Continue Watching.
2. Add an official-destination Ghana directory with source type, owner, verification date and availability status.
3. Add a user-selected local media library using Android's document/media picker and persistable URI permissions.
4. Test local playback in airplane mode, file permission revocation, unsupported formats, empty library and low-storage states.
5. Run existing tests and build a new APK; then test touch navigation on a phone and D-pad navigation on Android TV.

## Scope and honesty

This audit is source inspection only. No Kotlin implementation, APK rebuild, signed release, or physical-device test was performed as part of this audit. The existing successful test build remains the latest build until a new workflow run produces another artifact.
