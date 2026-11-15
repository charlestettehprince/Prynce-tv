#!/bin/sh
# PRYNCE TV emulator launch smoke test.
# A launch timeout is a diagnostic failure, never a valid timing sample.
set -u

APK="android/upstream/app/build/outputs/apk/debug/app-debug.apk"
PACKAGE="app.opentv.debug"
ACTIVITY="app.opentv.MainActivity"
OUT="performance-results"

mkdir -p "$OUT"
: > "$OUT/install.txt"
: > "$OUT/startup-raw.txt"
: > "$OUT/diagnostics.txt"
printf "sample,total_time_ms,wait_time_ms\n" > "$OUT/startup.csv"

if [ ! -s "$APK" ]; then
  echo "APK missing or empty: $APK" | tee "$OUT/install.txt"
  exit 1
fi

# CI emulator is disposable. Start from a clean install so an old debug
# signature/package cannot silently contaminate the result.
adb uninstall "$PACKAGE" > "$OUT/uninstall.txt" 2>&1 || true
if ! adb install "$APK" > "$OUT/install.txt" 2>&1; then
  echo "Fresh APK installation failed." | tee -a "$OUT/diagnostics.txt"
  adb logcat -d -t 2500 > "$OUT/logcat-install-failure.txt" 2>&1 || true
  exit 1
fi

adb shell pm clear "$PACKAGE" >/dev/null 2>&1 || true
failed=0

for sample in 1 2 3 4 5; do
  adb shell am force-stop "$PACKAGE" >/dev/null 2>&1 || true
  sleep 2
  output="$(adb shell am start -W -n "$PACKAGE/$ACTIVITY" 2>&1)"
  start_status=$?
  printf "=== sample %s (exit %s) ===\n%s\n" "$sample" "$start_status" "$output" >> "$OUT/startup-raw.txt"

  total="$(printf "%s\n" "$output" | tr -d '\r' | awk -F': ' '/^TotalTime:/ {print $2; exit}')"
  wait="$(printf "%s\n" "$output" | tr -d '\r' | awk -F': ' '/^WaitTime:/ {print $2; exit}')"
  launch_state="$(printf "%s\n" "$output" | tr -d '\r' | awk -F': ' '/^LaunchState:/ {print $2; exit}')"

  if [ -z "$total" ] || ! printf "%s" "$total" | grep -Eq '^[0-9]+$' || printf "%s" "$output" | grep -q 'Status: timeout'; then
    failed=1
    {
      echo "Launch sample $sample did not complete normally."
      echo "adb am start exit: $start_status"
      echo "LaunchState: ${launch_state:-not reported}"
      echo "ActivityManager output:"
      printf "%s\n" "$output"
      echo
      echo "Package process:"
      adb shell pidof "$PACKAGE" 2>&1 || true
      echo
      echo "Activity state:"
      adb shell dumpsys activity activities 2>&1 | grep -E -i -C 3 "$PACKAGE|mResumedActivity|topResumedActivity" || true
      echo
      echo "Last ANR information:"
      adb shell dumpsys activity lastanr 2>&1 || true
    } >> "$OUT/diagnostics.txt"
    adb logcat -d -t 5000 > "$OUT/logcat-launch-failure.txt" 2>&1 || true
    adb shell am force-stop "$PACKAGE" >/dev/null 2>&1 || true
    break
  fi

  wait="${wait:-0}"
  printf "%s,%s,%s\n" "$sample" "$total" "$wait" >> "$OUT/startup.csv"
  adb shell am force-stop "$PACKAGE" >/dev/null 2>&1 || true
done

if [ "$failed" -ne 0 ]; then
  python3 - <<'PY'
import json
from pathlib import Path
Path("performance-results/startup.json").write_text(json.dumps({
    "status": "failed",
    "reason": "Activity launch timed out or returned no valid TotalTime",
    "timing_samples_are_valid": False,
    "diagnostics": ["diagnostics.txt", "logcat-launch-failure.txt", "startup-raw.txt"]
}, indent=2) + "\n")
PY
  exit 1
fi

python3 - <<'PY'
import csv, json, statistics
from pathlib import Path
rows = list(csv.DictReader(Path("performance-results/startup.csv").open()))
values = [int(row["total_time_ms"]) for row in rows]
report = {
    "status": "passed",
    "device": "GitHub Actions Android Emulator / Pixel 2 profile / API 35 / x86_64",
    "package": "app.opentv.debug",
    "activity": "app.opentv.MainActivity",
    "samples": len(values),
    "total_time_ms": values,
    "median_total_time_ms": statistics.median(values),
    "minimum_total_time_ms": min(values),
    "maximum_total_time_ms": max(values),
    "measurement": "ActivityManager am start -W TotalTime; activity-launch smoke check only, not first-frame timing or physical-device acceptance."
}
Path("performance-results/startup.json").write_text(json.dumps(report, indent=2) + "\n")
print(json.dumps(report, indent=2))
PY
