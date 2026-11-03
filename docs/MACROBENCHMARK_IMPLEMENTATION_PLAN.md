# PRYNCE TV Macrobenchmark Implementation Plan

Status: design proposal only. No benchmark module or runtime changes are included in this document.

## Goal

Replace the current emulator-based `adb shell am start -W` smoke measurement with AndroidX Macrobenchmark for trustworthy app-startup and Compose UI performance measurements.

## Why this approach

Android's official guidance recommends Macrobenchmark for larger user journeys, app startup, Compose scrolling and frame timing. It emits structured JSON results and Perfetto traces, and can run in CI. Performance numbers should be collected on physical devices; emulator runs are useful for functional smoke tests but are not representative performance measurements.

Reference: https://developer.android.com/topic/performance/benchmarking/macrobenchmark-overview

## Current repository constraints

- The Android engine is a Git submodule at `android/upstream`, pinned to the OpenTV upstream commit recorded by the parent repository.
- The upstream project currently has a single `:app` module.
- Avoid modifying the upstream submodule or moving its pin until a separate benchmark harness builds successfully.
- The current startup smoke workflow previously timed out at ActivityManager launch. Preserve that failure as an unresolved diagnostic; do not report it as a performance result.
- Existing successful Android CI builds are debug/test artifacts, not production-signed releases.

## Proposed low-risk architecture

1. Keep the existing Android build workflow and pinned engine unchanged.
2. Add a PRYNCE-owned benchmark harness in a separate directory/project, outside `android/upstream`.
3. Build the benchmark target from the exact PRYNCE CI APK produced by the branded build workflow, rather than duplicating upstream app source.
4. Configure the target variant as non-debuggable and profileable, with minification matching the intended release configuration. Add/verify ProfileInstaller 1.3+ (prefer the currently recommended stable version compatible with the project's toolchain).
5. Add a separate `com.android.test` benchmark module using a compatible stable AndroidX Macrobenchmark dependency.
6. Start with cold-start timing, then add a representative Ghana TV directory open and scroll journey once stable UI selectors/test tags are available.
7. Store JSON metrics and Perfetto traces as CI artifacts. Keep emulator smoke tests separate from physical-device performance runs.
8. Establish device-specific baselines before adding regression thresholds; do not compare measurements from unlike devices.

## Required compatibility checks before implementation

- Confirm current AGP, Kotlin, Gradle wrapper, compile SDK and dependency catalog from the pinned source.
- Confirm whether the production-like target can be built and installed separately from the debug test APK.
- Verify `<profileable android:shell="true"/>` can be enabled safely in the benchmark-only target configuration.
- Verify ProfileInstaller availability and version compatibility.
- Verify the benchmark runner and target package IDs, launch activity, and exported activity requirements.
- Verify GitHub Actions can access a physical Android device runner. If not, keep the benchmark locally runnable and retain emulator CI only for functional smoke checks.

## Acceptance criteria

- Benchmark module builds independently without changing the upstream submodule pointer.
- Cold-start test produces Macrobenchmark JSON output and Perfetto trace on a supported physical device.
- A Compose directory scroll test produces FrameTimingMetric output.
- Failed launch or missing metrics fails the job; no fabricated zero values or success fallbacks.
- Results identify device model, Android API level, app commit, APK checksum and benchmark revision.
- Documentation distinguishes emulator smoke checks from physical-device performance evidence.

## Not in scope

- No bypassing DRM, subscriptions, authentication, geographic restrictions or provider access controls.
- No production signing-key creation or storage in CI as part of this benchmark change.
- No app engine replacement, upstream submodule update, or unreviewed dependency upgrade.
- No claim of speed improvement until before/after measurements exist.

## Next implementation gate

Inspect the exact pinned Gradle wrapper and app dependency graph, then build a minimal separate harness against a known CI APK. Open a pull request for review before merging any benchmark infrastructure into `main`.


## Verified pinned-toolchain findings (2026-11-03)

The following values were read directly from the pinned OpenTV submodule commit
`443811904b6437720d37bb1064c0830906c3515f`:

- Gradle wrapper: **8.11.1**.
- Android Gradle Plugin: **8.7.3**.
- Kotlin: **2.0.21**; KSP: **2.0.21-1.0.28**.
- Compile/target SDK: **35**; min SDK: **23**.
- Java/Kotlin bytecode target: **17**.
- App namespace/application ID: `app.opentv`; debug application ID: `app.opentv.debug`.
- Launcher activity: `app.opentv.MainActivity`; debug launcher: `app.opentv.debug/app.opentv.MainActivity`.
- Existing instrumentation runner: `androidx.test.runner.AndroidJUnitRunner`.
- Project has one Android application module, `:app`, and uses a Gradle version catalog.
- Existing dependencies do not declare AndroidX Macrobenchmark or ProfileInstaller.
- The inspected application manifest does not currently declare `<profileable android:shell="true"/>`.
- Release currently falls back to the debug signing key when `KEYSTORE_PATH` is absent. Therefore the existing release variant is **not** an acceptable benchmark target for production-like signing or public distribution evidence.

## Updated implementation gate

**Status: compatibility discovery complete; implementation remains blocked pending a safe target APK.**

Do not point Macrobenchmark at the existing debug APK: Macrobenchmark requires a non-debuggable target. Do not treat the current debug-signed release fallback as production-signed. Before adding a harness, create or identify a dedicated benchmark target build that is non-debuggable, profileable, installable alongside/independently of the app, and uses the same code/minification configuration intended for the measured release. Keep signing identity out of benchmark artifacts and do not create or export a production private key for this work.

The next low-risk step is to inspect the parent repository's branded build workflow and artifact naming, then add a small isolated benchmark project only after confirming how a benchmark-only profileable APK can be produced without changing the upstream submodule. If that cannot be done without a source patch, propose a minimal patch in a separate reviewable PR rather than silently moving the submodule pointer.
