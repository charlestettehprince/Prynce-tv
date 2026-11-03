# PRYNCE TV — Privacy, Security and Distribution Gate Audit

**Audit date:** 3 November 2026  
**Repository:** `charlestettehprince/Prynce-tv`  
**Pinned engine:** OpenTV commit `443811904b6437720d37bb1064c0830906c3515f`  
**Scope:** Static review of the pinned Android manifest, Gradle configuration, privacy statement, FileProvider paths, updater source, repository licensing files and current project documentation.

## Executive result

This is a source-level risk review, not a penetration test, dependency vulnerability scan, legal opinion, or physical-device test. No Android source or binary was changed during this audit.

**Public distribution remains blocked.** The highest-priority items are provider credential protection/backup behavior, the broad cleartext-traffic allowance, a permanent production signing identity and package ID, and complete GPL source/notice packaging.

## Findings

### 1. Cleartext traffic is enabled globally — HIGH

The pinned manifest sets `android:usesCleartextTraffic="true"` at application scope. The upstream privacy document explains that some provider panels are HTTP-only and explicitly warns that provider usernames and passwords sent over HTTP are unencrypted in transit.

**Risk:** This is broader than a per-provider exception. A network observer on the route may read credentials or alter unencrypted traffic. The documented compatibility rationale is real, so removing the setting blindly could break legitimate provider configurations.

**Required action:** Before release, assess whether the app can default to HTTPS and make any HTTP exception explicit and user-visible, or use a narrowly scoped Network Security Config if the platform behavior and provider requirements support it. Test real provider compatibility before changing the setting. Do not claim HTTP is secure.

### 2. Android backup is enabled — HIGH / VERIFY

The manifest sets `android:allowBackup="true"`. The upstream privacy statement says provider address, username and password are stored in the app's private SQLite database and says uninstalling removes the database. The inspected manifest does not show a backup/data-extraction rules reference.

**Risk:** Depending on Android version, device backup/transfer behavior and database implementation, provider credentials may be included in backup or device migration. This was not proven from the manifest alone.

**Required action:** Inspect the actual database/credential storage code and test backup/restore/device transfer. Decide explicitly whether credential-bearing data must be excluded from cloud backup and device transfer. Implement matching Android backup and data-extraction rules only after tests. Consider encrypting secrets with Android Keystore-backed protection; do not invent or silently migrate a credential format.

### 3. Sensitive permissions and user prompts need feature justification — MEDIUM / REVIEW

The manifest declares internet/network, wake lock, foreground media playback, notifications, boot receiver, exact alarms, battery-optimization exemption request, full-screen intent, and package-install request permissions.

**Risk:** Some are associated with recording, reminders, auto-switch and in-app updates, but they are powerful or sensitive user-facing capabilities. A viewer should understand why each is needed and be able to decline optional behavior.

**Required action:** Map every permission to an active feature and runtime prompt. Keep exact-alarm, full-screen-intent, battery-exemption and package-install flows opt-in and contextual. Verify Android/TV/Fire TV behavior. Remove only permissions proven unused after regression testing.

### 4. Update transport is HTTPS, but release authenticity still depends on signing — HIGH / BLOCKING

The updater source requests GitHub's HTTPS API and consumes an APK asset URL from the release metadata. The app's FileProvider is non-exported, grants URI permissions, and exposes only the cache `updates/` path.

The Gradle release build falls back to the Android debug signing key when no keystore environment variable is configured. Project records confirm the current packages are debug-signed test artifacts.

**Risk:** HTTPS protects transport, but it is not a substitute for a permanent, protected production signing identity and verified package continuity. Debug-signed artifacts must not be advertised as production releases.

**Required action:** Choose the final package ID, establish a permanent production keystore controlled by the authorised release owner, protect and back it up securely, configure CI secrets, and verify signer fingerprint and update continuity before publication. Keep the system installer confirmation; never silently install or ask users to disable Play Protect.

### 5. GPL-3.0-or-later compliance needs a release bundle — HIGH / BLOCKING

The pinned OpenTV source declares GPL-3.0-or-later. The PRYNCE repository README acknowledges corresponding-source and notice obligations, but a root-level `LICENSE` file was not found in the inspected main branch.

**Risk:** A README statement alone is not a complete release compliance package.

**Required action:** Preserve upstream notices; include the full applicable licence text and third-party notices; identify modifications; publish the exact corresponding source for each distributed modified binary, including the pinned submodule commit and build-time patch scripts. Review every bundled dependency's licence and source obligations. Do not remove or obscure upstream attribution.

### 6. Privacy statement is useful but needs PRYNCE-specific verification — MEDIUM

The upstream privacy document says there is no analytics SDK, crash reporter, telemetry, or project-controlled server. It says provider credentials and catalogues stay in local SQLite and that the app contacts the provider and URLs from the provider catalogue.

**Limit:** This is an upstream project statement. The PRYNCE fork also changes branding, updater destination and packages its own Ghana TV directory. The final PRYNCE binary and build-time patches must be checked to ensure the statement remains accurate.

**Required action:** Verify network destinations and SDK inventory for the exact release build. Clearly explain that provider-controlled logo/poster URLs may point to third parties and that HTTP provider connections expose credentials in transit.

### 7. FileProvider scope appears narrow — POSITIVE, STATIC ONLY

The inspected FileProvider is `exported=false`, grants URI permissions and maps only `<cache-path name="updates" path="updates/" />`. This is a narrow update-cache scope in the inspected configuration. Runtime behavior still requires testing.

## Prioritised release gate

1. Inspect credential database, encryption and backup/restore behavior.
2. Decide an explicit HTTP-provider policy and test HTTPS/HTTP compatibility.
3. Map permissions to features and ensure optional permissions are contextual and user-controlled.
4. Set permanent package identity and production signing; verify update authenticity and installer handoff.
5. Prepare GPL licence, notices, exact corresponding source and dependency licence inventory.
6. Re-check the final binary's network behavior, SDK inventory and privacy disclosures.
7. Complete physical phone, Android TV and Fire TV acceptance before any public release.

## What was not done

- No source changes or APK/AAB releases were made.
- No credentials were accessed or transmitted.
- No penetration test, SCA/SBOM vulnerability scan, device backup test, or physical-device test was performed.
- This audit does not certify legal compliance or security.

## Evidence inspected

- Pinned upstream `app/src/main/AndroidManifest.xml`
- Pinned upstream `app/build.gradle.kts`
- Pinned upstream `gradle/libs.versions.toml`
- Pinned upstream `docs/PRIVACY.md`
- Pinned upstream `app/src/main/res/xml/file_paths.xml`
- Pinned upstream `app/src/main/java/app/opentv/update/UpdateChecker.kt`
- Pinned upstream `LICENSE`
- PRYNCE repository `README.md` and `docs/FINAL_HANDOFF.md`

Pinned upstream commit: `443811904b6437720d37bb1064c0830906c3515f`.
