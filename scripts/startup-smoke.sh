#!/bin/sh
set -eu

APK="android/upstream/app/build/outputs/apk/debug/app-debug.apk"
PACKAGE="app.opentv.debug"
ACTIVITY="app.opentv.MainActivity"

test -s "$APK"
mkdir -p performance-results
adb install -r "$APK"
adb shell pm clear "$PACKAGE" >/dev/null

printf "sample,total_time_ms,wait_time_ms\n" > performance-results/startup.csv
: > performance-results/startup-raw.txt

collect_failure_diagnostics() {
  sample_number="$1"
  reason="$2"
  launch_output="$3"
  diagnostics="performance-results/launch-diagnostics.txt"

  {
    printf "PRYNCE TV startup smoke failure\n"
    printf "Sample: %s\nReason: %s\n\n" "$sample_number" "$reason"
    printf "=== am start -W output ===\n%s\n\n" "$launch_output"

    printf "=== ADB devices ===\n"
    adb devices -l 2>&1 || true

    printf "\n=== ADB state ===\n"
    adb get-state 2>&1 || true

    printf "\n=== App process ===\n"
    adb shell pidof "$PACKAGE" 2>&1 || true

    printf "\n=== Activity state ===\n"
    adb shell dumpsys activity activities 2>&1 \
      | grep -E "$PACKAGE|mResumedActivity|topResumedActivity" || true

    printf "\n=== Focused window ===\n"
    adb shell dumpsys window 2>&1 \
      | grep -E "mCurrentFocus|mFocusedApp" || true

    printf "\n=== Last ANR report (first 120 lines) ===\n"
    adb shell dumpsys activity lastanr 2>&1 | sed -n '1,120p' || true

    printf "\n=== Crash buffer (last 120 lines) ===\n"
    adb logcat -b crash -d -t 200 -v brief 2>&1 | tail -n 120 || true

    printf "\n=== Filtered activity/ANR system log ===\n"
    adb logcat -b system -d -t 300 -v brief 2>&1 \
      | grep -E "ANR in|Input dispatching timed out|am_anr|ActivityTaskManager|ActivityManager" \
      | tail -n 100 || true
  } > "$diagnostics"

  cat "$diagnostics"
}

for sample in 1 2 3 4 5; do
  adb shell am force-stop "$PACKAGE" || true
  sleep 2

  if output="$(adb shell am start -W -n "$PACKAGE/$ACTIVITY" 2>&1)"; then
    launch_status=0
  else
    launch_status=$?
  fi

  printf "\n=== Sample %s ===\n%s\n" "$sample" "$output" >> performance-results/startup-raw.txt
  total="$(printf "%s\n" "$output" | tr -d '\r' | awk -F': ' '/^TotalTime:/ {print $2; exit}')"
  wait="$(printf "%s\n" "$output" | tr -d '\r' | awk -F': ' '/^WaitTime:/ {print $2; exit}')"

  if [ "$launch_status" -ne 0 ] \
    || [ -z "$total" ] \
    || ! printf "%s" "$total" | grep -Eq '^[0-9]+$' \
    || printf "%s\n" "$output" | grep -q '^Status: timeout'; then
    reason="Activity launch did not return a valid TotalTime (adb exit: $launch_status)."
    collect_failure_diagnostics "$sample" "$reason" "$output"
    exit 1
  fi

  wait="${wait:-0}"
  printf "%s,%s,%s\n" "$sample" "$total" "$wait" >> performance-results/startup.csv
  adb shell am force-stop "$PACKAGE" || true
done

python3 - <<'PY'
import csv, json, statistics
from pathlib import Path

rows = list(csv.DictReader(Path("performance-results/startup.csv").open()))
values = [int(row["total_time_ms"]) for row in rows]
report = {
    "device": "GitHub Actions Android Emulator / Pixel 2 profile / API 35 / x86_64",
    "package": "app.opentv.debug",
    "activity": "app.opentv.MainActivity",
    "samples": len(values),
    "total_time_ms": values,
    "median_total_time_ms": statistics.median(values),
    "minimum_total_time_ms": min(values),
    "maximum_total_time_ms": max(values),
    "measurement": "ActivityManager am start -W TotalTime; emulator activity-launch smoke baseline only, not first-frame timing or physical-device acceptance."
}
Path("performance-results/startup.json").write_text(json.dumps(report, indent=2) + "\n")
print(json.dumps(report, indent=2))
PY
