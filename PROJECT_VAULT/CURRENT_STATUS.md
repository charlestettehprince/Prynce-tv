# PRYNCE TV — Current Project Snapshot

**Snapshot date:** 2026-11-05  
**Repository:** https://github.com/charlestettehprince/Prynce-tv

## Verified repository evidence available to this handoff
- The project is an Android media-player application intended for Android phones, Android TV, and Fire TV.
- The repository README identifies the OpenTV v0.11.10 foundation.
- PRYNCE TV is a player, not a broadcaster. Users must provide access to content they are authorized to view.
- The project notes prohibit DRM, subscription, authentication, or provider-access bypass.
- PR #10, **“design: prepare PRYNCE yellow and black TV theme”**, was observed open and not merged on 2026-11-04.
- PR #10 branch: `feature/prynce-yellow-black-theme`.
- PR #10 observed head: `32f8c519687d0e5cd918f68289f4b65998a4e6e8`.
- The PR describes a yellow/black/white PRYNCE theme while retaining the pinned player engine.
- A successful validation run was reported for that PR before cleanup; the prior report mentioned 122 lint warnings. Re-run CI before treating this as current.
- The latest main commit observed in the prior inspection was `b1ffab64b21f52125d780f8a946cd36f64b5a338`. Re-check before relying on it.

## Release readiness
**Not verified as production-ready.** Earlier repository notes indicate debug-signed APK/AAB artifacts only. A debug build is not a production release.

## Outstanding verification / work
1. Re-fetch main, branches, pull requests, workflow runs, and artifact retention status.
2. Review and resolve PR #10; do not merge without checking its diff and CI.
3. Re-run lint, unit tests, instrumentation tests, and release build.
4. Test on real Android phone, Android TV, and Fire TV hardware/emulators.
5. Review privacy, permissions, dependencies, open-source licences, and content-provider terms.
6. Configure production signing securely outside Git; never commit keystore files or passwords.
7. Verify app bundle/APK signatures, checksums, versioning, and release notes.
8. Complete a public-release checklist and obtain owner approval.

## Historical artifact details — do not treat as current
Earlier README notes recorded a branded adaptive-icon workflow artifact and debug-signed outputs:
- Workflow run: `41625818584`
- Artifact ID: `13226525916` (previously reported expiry: 2027-02-01)
- Historical APK SHA-256: `5fac9671ee89d245f50e5deb924c74a4e3a1fa64f766f8fd011767279ba7be88`
- Historical AAB SHA-256: `05c9a557ddd2daa422945d9440a502a1065725913294954d65fffec0be562abc`
- Historical archive SHA-256: `04da2dce25fd3e85696f0d8108786d5ed2ea3ba49bd069a033cc2cf562b77b60`

These hashes are historical references only. Re-download and verify any artifact before use. Do not distribute an old debug build as a production release.

## What this snapshot does not prove
No fresh build, physical-device test, database export, full repository mirror, or production signing operation was performed while creating this vault documentation.
