# PRYNCE TV — APK Updater Authenticity Audit

**Audit date:** 3 November 2026  
**Repository:** `charlestettehprince/Prynce-tv`  
**Pinned engine:** OpenTV `443811904b6437720d37bb1064c0830906c3515f`  
**Scope:** Static review of updater metadata parsing, download, installer handoff, PRYNCE build-time updater configuration and release signing.

## Executive result

The updater uses HTTPS for the GitHub Releases API and APK download, and Android's system package installer performs the final package-signature checks. The app does not silently install updates. Those are positive controls.

However, the app itself does not verify a release asset digest or pin/check the APK signing certificate before handing the file to Android. The Android installer should reject an update that cannot update the installed package because its signing identity differs, but the current flow does not provide a pre-install authenticity check or an explicit first-install signer pin. The release signing configuration also falls back to the debug key when no production keystore is configured.

**Public production distribution remains blocked.** Do not treat a successful HTTPS download, a GitHub release URL, a ZIP checksum, or the system install prompt as a complete release-authenticity process.

## Evidence reviewed

### 1. Release metadata request

Pinned `UpdateChecker.kt`:
- Requests `https://api.github.com/repos/$repoSlug/releases/latest`.
- Skips drafts and prereleases.
- Selects the first asset whose name ends in `.apk`.
- Reads `browser_download_url` and asset `size`.
- Compares the release tag to the current version name.
- Does not parse or require the GitHub asset `digest` field.
- Does not require a specific expected APK filename.
- Does not validate the APK URL's host/scheme before passing it to the downloader.

PRYNCE's build workflow replaces the upstream repository slug with `charlestettehprince/Prynce-tv` at build time. That means the published PRYNCE binary will query the PRYNCE repository when this build-time step is applied.

### 2. APK download

Pinned `ApkInstaller.kt`:
- Downloads the URL supplied by release metadata using the shared OkHttp client.
- Checks only that the HTTP response is successful and that a body exists.
- Writes to the app-private cache path `updates/opentv-update.apk`.
- Does not compare the downloaded byte count against the expected size.
- Does not calculate/compare SHA-256 or another asset digest.
- Does not independently inspect the APK package name, version, or signing certificate before launching the installer.
- Uses a FileProvider URI and Android's `ACTION_INSTALL_PACKAGE` system UI; it does not install silently.

### 3. Android's final signature enforcement

Android's package installer verifies APK signatures. For an update to an existing app, Android requires a compatible signing identity for the installed package; a mismatched signer should cause the update to be rejected. This is an important final safety net, but it is not a substitute for app-side verification and a pinned expected signer, particularly for first installs and for clear pre-install feedback.

### 4. Release signing configuration

Pinned `app/build.gradle.kts`:
- The release build uses the configured `upload` signing config when `KEYSTORE_PATH` is present.
- Otherwise it falls back to the Android debug signing key.
- The latest PRYNCE CI test packages were independently recorded as debug-signed, not production-signed.
- The package identity must be frozen before the first public release. A package ID or signer change can prevent seamless updates.

### 5. PRYNCE build-time configuration

The PRYNCE Android workflow patches the pinned upstream `UpdateChecker.kt` repository slug to `charlestettehprince/Prynce-tv` before building. It also changes visible update-dialog wording to PRYNCE TV. This audit found no evidence in the workflow snippet inspected of a release-asset digest verification patch.

## Risk register

| Finding | Severity | Why it matters |
|---|---|---|
| No APK SHA-256/digest verification | High | A download is not checked against release metadata before installer handoff |
| No expected signer pin/pre-install signer check | High | The app does not independently confirm the APK signer before invoking Android's installer |
| First matching `.apk` is selected | Medium | A release with multiple APKs could cause the wrong artifact to be selected |
| APK URL host/scheme not explicitly constrained | Medium | Metadata-supplied URLs are passed directly to the HTTP client |
| No downloaded-size enforcement | Medium | Expected size is used for progress only, not as a strict integrity/size check |
| Debug-key release fallback | Critical for production | Test/debug key is not a permanent production identity |
| FileProvider + system installer confirmation | Positive | Narrow app-cache handoff; user confirms in Android installer; no silent install |

## Recommended implementation

### A. Release asset contract

- Publish exactly one installable universal APK per release, with a predictable name containing the product and version.
- Publish its SHA-256 digest in GitHub Release asset metadata (where the API exposes `digest`) and/or a signed checksum manifest.
- Require the expected asset name and a valid HTTPS URL from an approved GitHub release host/path.
- Reject missing, malformed or unsupported digest metadata. Never silently downgrade to “download without verification.”
- Enforce expected byte count and a sensible maximum download size.

A checksum fetched from the same GitHub release is an integrity check against accidental corruption and some delivery errors; it is not an independent trust anchor if the release account or metadata is compromised. The signing-certificate pin is still required.

### B. Signer verification before installer handoff

- Establish one permanent production signing identity under the authorised project owner's control.
- Embed the public signing-certificate SHA-256 fingerprint in the app (public certificate material only; never embed or distribute the private key).
- After download and digest verification, inspect the APK signing certificate using Android's package APIs.
- Compare it with the pinned expected certificate before showing the system installer.
- For an installed app, also verify the installed package identity and signer continuity.
- Support the app's minimum SDK 23 deliberately: use the appropriate legacy signature API on older supported Android versions and the signingInfo API on newer versions.
- Fail closed with a clear message if the APK package name, version, signer or digest does not match.

### C. Signing and key custody

- Remove the debug-key fallback from any production release workflow. A release build must fail if required production signing secrets are absent.
- Keep the private keystore and passwords outside Git and build artifacts; use protected CI secrets or an authorised secure signing service.
- Back up the production key securely under owner control and document recovery/rotation policy.
- Record the production certificate SHA-256 fingerprint and verify it against the first release artifact.
- Never ask users to disable Play Protect or bypass Android's installer/signature checks.

### D. Tests required before release

1. Valid APK, correct digest and expected signer → installer handoff permitted.
2. One-byte APK modification → digest mismatch; installer not launched.
3. Wrong signer / debug signer → rejected before installer.
4. Wrong package ID → rejected before installer.
5. Wrong or lower version → rejected according to downgrade policy.
6. Missing or malformed digest → rejected.
7. Wrong host, HTTP URL or unexpected redirect → rejected.
8. Truncated download or content-length mismatch → rejected and partial file removed.
9. GitHub API rate limit/network failure → no update shown; current app remains usable.
10. Android 6–16, phone, Android TV and Fire TV installer handoff → tested on supported devices.
11. Upgrade from the first production-signed release to a later release → same signer and package identity; user data preserved.

## Implementation sequence

1. Finalise the production package ID and release channel.
2. Establish production keystore custody and certificate fingerprint.
3. Add strict release asset selection, HTTPS/host checks, byte-count and SHA-256 verification.
4. Add pre-install package/version/signer verification.
5. Remove debug fallback for production release tasks.
6. Add unit/instrumentation tests and CI negative test fixtures.
7. Build and inspect a release candidate; verify the certificate fingerprint and update continuity on physical devices.

## What was not done

- No source code, workflow, signing configuration, keystore or APK was changed.
- No production key was generated or requested.
- No GitHub release was published.
- No APK was installed or updater runtime test performed.
- No claim is made that the current updater has been penetrated or that an exploit occurred. These are static design gaps and release-readiness findings.

## Evidence files

Pinned upstream:
- `app/src/main/java/app/opentv/update/UpdateChecker.kt`
- `app/src/main/java/app/opentv/update/ApkInstaller.kt`
- `app/src/main/java/app/opentv/data/remote/GitHubReleaseApi.kt`
- `app/build.gradle.kts`

PRYNCE:
- `.github/workflows/android-baseline.yml` — updater repository rewrite and build process
- `docs/PROJECT_STATUS.md` — latest test build and signer evidence

Pinned upstream commit: `443811904b6437720d37bb1064c0830906c3515f`.
