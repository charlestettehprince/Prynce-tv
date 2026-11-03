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

for sample in 1 2 3 4 5; do
  adb shell am force-stop "$PACKAGE" || true
  sleep 2
  output="$(adb shell am start -W -n "$PACKAGE/$ACTIVITY" 2>&1)"
  printf "%s\n" "$output" >> performance-results/startup-raw.txt
  total="$(printf "%s\n" "$output" | tr -d '\r' | awk -F': ' '/^TotalTime:/ {print $2; exit}')"
  wait="$(printf "%s\n" "$output" | tr -d '\r' | awk -F': ' '/^WaitTime:/ {print $2; exit}')"
  if [ -z "$total" ] || ! printf "%s" "$total" | grep -Eq '^[0-9]+$'; then
    echo "Could not parse TotalTime from emulator launch output:"
    printf "%s\n" "$output"
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
