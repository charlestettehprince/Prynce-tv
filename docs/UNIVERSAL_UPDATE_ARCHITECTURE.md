# PRYNCE TV — Universal update architecture

**Decision date:** 3 November 2026  
**Scope:** The single PRYNCE TV Android application on supported phones, tablets, Android TV and Fire TV devices.

## Decision

Use one application identity and one signed release line wherever the target stores support the device. Do not create separate phone and TV products merely to update them independently. The app must check for updates gracefully, explain what is changing, and never silently install an APK outside the platform's supported update system.

There is no legitimate universal Android API that silently installs a new application binary on every consumer device. Store policy, device support, user consent, package identity and signing rules remain in force.

## Update layers

### 1. Application binary — phones and tablets

- Integrate the official Google Play In-App Updates library.
- On launch/resume, check availability and handle errors without blocking normal use.
- Prefer a **flexible update** for ordinary features and improvements: download in the background, show progress, then ask the viewer to restart to finish installation.
- Use an **immediate update** only for genuinely critical security or compatibility fixes, and only when Google Play reports that flow is allowed.
- Handle cancellation, offline state, Play Store absence, already-downloaded updates and resumed/in-progress updates.
- The Play In-App Updates API officially supports Android phones, tablets and ChromeOS; it is **not documented as supported for Android TV**.

### 2. Application binary — Android TV

- Publish the same compatible package identity through Google Play with TV support and the required TV launcher metadata.
- Let Google Play distribute updates to existing installs; viewers can enable automatic updates in Play settings.
- Do not call the phone/tablet in-app update API on Android TV as if it were supported.
- Keep D-pad focus stable and show a clear update/restart message when a store-managed update requires it.

### 3. Application binary — Fire TV

- Use the Fire TV distribution/update path for an app installed from the Amazon Appstore.
- Do not assume Google Play update APIs or Play Store services exist on Fire TV.
- For manually installed test builds, provide a signed, versioned release and a clear user-confirmed installation path. Android does not permit an ordinary app to silently replace itself on unmanaged consumer devices.

### 4. Features and content — all devices

- Separate remotely changeable content/configuration from executable code: help text, supported feature flags, release notes, artwork/catalog metadata and non-sensitive service configuration can be refreshed from a versioned HTTPS manifest.
- Validate the manifest schema, use TLS, apply cache/expiry rules, and fall back safely when offline or the server is unavailable.
- Do not download or execute arbitrary code/scripts as a substitute for a reviewed app release.
- A feature that changes native player code, permissions, security behaviour or bundled libraries requires a normal signed app update.

## Release identity and safety requirements

- Keep the application ID/package name unchanged across updates.
- Increase Android versionCode for every binary release.
- Sign each update with the same release signing identity as the installed app; protect the signing key outside the repository and CI logs.
- Publish through the appropriate store and complete its review before viewers receive the update.
- Keep phone and TV compatibility declarations, launcher assets and D-pad navigation covered by CI and device acceptance.
- Never bypass user consent, store review, Android package verification, DRM, authentication or provider restrictions.

## Implementation checklist

- [ ] Inspect the pinned OpenTV app module, package ID, versioning, entry activities and Gradle dependency catalog.
- [ ] Add the official Play In-App Updates dependency to the Android phone/tablet app module.
- [ ] Implement flexible update flow, progress state, completion prompt and lifecycle recovery.
- [ ] Implement immediate update only for high-priority releases and only when supported.
- [ ] Guard the Play update integration by device/store availability; do not present it as an Android TV or Fire TV solution.
- [ ] Add an update status/settings screen with installed version, latest known version, release notes and a manual store-open action.
- [ ] Add a signed HTTPS remote manifest for non-executable content/configuration, with schema validation, caching and offline fallback.
- [ ] Configure Play and Fire TV release tracks as applicable, preserving package ID and signing identity.
- [ ] Add CI checks for monotonically increasing versionCode, package ID consistency, manifest validity and release artifact checksums.
- [ ] Test on a physical Android phone, Android TV device and Fire TV device separately.
- [ ] Test update available/not available, offline, declined, download failure, restart, interrupted update and rollback/recovery scenarios.

## Current implementation status

This document records the selected architecture, not a claim that update code has already been integrated. The current repository CI builds the branded APK/AAB from a pinned OpenTV submodule, but the actual Android app source is provided through that submodule and the existing workflow currently applies branding changes during CI. The update feature must be implemented against the inspected app source and then proven by a new successful build and device tests.

## Official references

- Android in-app updates and supported device classes: https://developer.android.com/guide/playcore/in-app-updates
- Kotlin/Java integration, flexible/immediate flows and lifecycle handling: https://developer.android.com/guide/playcore/in-app-updates/kotlin-java
- Google Play app update identity, signing and delivery requirements: https://support.google.com/googleplay/android-developer/answer/9859350
- Managed-device automatic update policies (not a universal consumer-device mechanism): https://developers.google.com/android/management/control-app-updates
