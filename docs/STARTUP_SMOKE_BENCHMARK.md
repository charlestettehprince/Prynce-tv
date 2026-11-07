# PRYNCE TV — Startup Smoke Benchmark

## Purpose

The `.github/workflows/startup-smoke.yml` workflow provides a repeatable, free CI emulator measurement for Android activity launch. It builds the pinned OpenTV debug variant, installs it on an Android API 35 x86_64 emulator, clears app data for the first launch, and records five process-cold launches using `adb shell am start -W`.

## What the measurements mean

- `TotalTime` is ActivityManager's reported activity launch timing.
- `WaitTime` is retained as supplementary output where the platform reports it.
- These values are not a precise first-rendered-frame measurement, nor are they a substitute for Macrobenchmark's StartupTimingMetric/Perfetto traces.
- The workflow writes raw output, CSV samples and a JSON summary as the `prynce-tv-startup-smoke-results` artifact.
- The first sample follows an app-data clear; later samples force-stop the app between launches. Treat the first sample as a fresh-install observation and the remaining samples as process-cold repeat launches with local data retained.

## CI troubleshooting history

- Run `41682156895` initially failed during Android SDK setup because the action attempted to install the removed `tools` SDK package. The setup step was corrected to request `platform-tools`.
- Run `41682368813` completed checkout, Java/SDK setup, emulator boot and debug build, but failed before measurement because the emulator action executes its script with POSIX `/usr/bin/sh`; Bash-only `set -o pipefail` is not supported there.
- The workflow was corrected to use POSIX-compatible `set -eu`. The job label and JSON description were also corrected to say activity launch timing, not first-frame timing.
- The next push-triggered run must pass the emulator step and upload a non-empty results artifact before any timing is reported.

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
4. Compare median and spread across at least five successful runs on the same API/emulator profile before making performance changes.

## Next steps

1. Complete a successful emulator run and capture several runs to establish normal timing variance.
2. Inspect the repository's actual Android Gradle Plugin/Kotlin versions before adding Macrobenchmark 1.5.0+ and Profile Installer 1.4.1+; do not blindly upgrade build tooling.
3. Add a Macrobenchmark test using `StartupTimingMetric` and cold-start mode, then generate a Baseline Profile for real critical user journeys.
4. Benchmark the profile on physical hardware before claiming user-visible speed improvements.
5. Measure first-run and returning-user journeys on representative low-end phone and Android TV hardware.
6. Optimise only after traces identify a specific bottleneck; preserve the no-mandatory-login and free basic-use requirements.


## Timeout diagnostic capture — 7 November 2026

When `adb shell am start -W` fails, returns a non-numeric `TotalTime`, or reports `Status: timeout`, the smoke script now:

- Preserves the launch output in `startup-raw.txt`.
- Writes `launch-diagnostics.txt` with ADB device/state information, app process state, filtered resumed-activity and focused-window state, the last ANR report, the crash log buffer, and filtered activity/ANR system messages.
- Exits non-zero and does not add a failed launch to the timing CSV. A timeout is never converted into a performance sample.
- Uses the existing `if: always()` artifact upload step so failure diagnostics can be inspected after the emulator job ends.

The workflow path filter now includes `scripts/startup-smoke.sh`, so changes to the diagnostic script trigger this workflow. Diagnostics are produced by the ephemeral CI emulator; no personal playlists or user provider credentials are configured for this test. Review diagnostic artifacts before sharing them outside the project because runtime traces can contain application or device details.

The code change has passed local POSIX shell syntax validation and a mocked-ADB failure-path test. A new GitHub Actions emulator run is still required to verify the commands against a real CI emulator.
