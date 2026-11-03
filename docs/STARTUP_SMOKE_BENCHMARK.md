# PRYNCE TV — Startup Smoke Benchmark

## Purpose

The `.github/workflows/startup-smoke.yml` workflow provides a repeatable, free CI emulator measurement for app launch. It builds the pinned OpenTV debug variant, installs it on an Android API 35 x86_64 emulator, clears app data for the first launch, and records five process-cold launch samples using `adb shell am start -W`.

## What the measurements mean

- `TotalTime` is ActivityManager's launch timing reported for the activity start.
- `WaitTime` is retained as supplementary output where the platform reports it.
- The workflow writes raw output, CSV samples and a JSON summary as the `prynce-tv-startup-smoke-results` artifact.
- The first sample follows an app-data clear; later samples force-stop the app between launches. Treat the first sample as a fresh-install cold-start observation and the remaining samples as process-cold repeat launches with local data retained.

## Limitations

- This is an emulator smoke baseline, not a physical Android phone, Android TV or Fire TV benchmark.
- Emulator timing varies with CI host load and virtual hardware; compare repeated runs on the same workflow profile and do not treat one run as a user-facing speed guarantee.
- The upstream debug package is measured before PRYNCE's CI-only branding and Ghana directory patches. The activity and main app code are pinned to the same OpenTV source commit, but this is not a benchmark of the final branded binary.
- It does not measure frame jank, scroll performance, video startup, network-dependent EPG refresh, memory pressure, battery use or TV D-pad interaction.
- It does not generate a Baseline Profile. Baseline Profile generation and Macrobenchmark integration require a separate build-configuration change and a stable benchmark test module; do not claim profile-based speed gains until generated profile artifacts are merged and validated.
- No hard millisecond threshold is enforced yet. Establish a stable baseline across multiple CI runs before setting a regression gate.

## How to read results

1. Open the repository's Actions tab and select **PRYNCE TV startup smoke benchmark**.
2. Open the completed run and download `prynce-tv-startup-smoke-results`.
3. Review `startup.json`, `startup.csv` and `startup-raw.txt`.
4. Compare median and spread across at least five runs on the same API/emulator profile before making performance changes.

## Next steps

1. Capture several successful CI runs to establish normal timing variance.
2. Add a Macrobenchmark module and Baseline Profile generator after verifying compatible AndroidX plugin/dependency versions against the pinned AGP/Kotlin setup.
3. Measure real first-run and returning-user journeys on representative low-end phone and Android TV hardware.
4. Optimise only after traces identify a specific bottleneck; preserve the no-mandatory-login and free basic-use requirements.
