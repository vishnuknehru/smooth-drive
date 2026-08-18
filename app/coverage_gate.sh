#!/usr/bin/env bash
# coverage_gate.sh — fail the build if filtered line coverage drops below 80%.
#
# Excludes generated code and platform adapters (tested on real devices only):
#   *.g.dart, *.freezed.dart, lib/main.dart, lib/app.dart,
#   geolocator_location_service.dart, replay_location_service.dart,
#   flutter_tts_voice_service.dart
#
# Usage:
#   flutter test --coverage && bash coverage_gate.sh
set -euo pipefail

LCOV="${1:-coverage/lcov.info}"
THRESHOLD=80

if [[ ! -f "$LCOV" ]]; then
  echo "ERROR: coverage file not found at $LCOV"
  echo "Run:  flutter test --coverage"
  exit 1
fi

python3 - "$LCOV" "$THRESHOLD" <<'PYEOF'
import sys, os

lcov_path = sys.argv[1]
threshold = int(sys.argv[2])

EXCLUDE = [
    ".g.dart",
    ".freezed.dart",
    "lib/main.dart",
    "lib/app.dart",
    "geolocator_location_service.dart",
    "replay_location_service.dart",
    "flutter_tts_voice_service.dart",
]

total = hit = 0
skip = False

with open(lcov_path) as f:
    for line in f:
        line = line.rstrip()
        if line.startswith("SF:"):
            skip = any(e in line for e in EXCLUDE)
        if skip:
            continue
        if line.startswith("DA:"):
            parts = line[3:].split(",")
            total += 1
            if int(parts[1]) > 0:
                hit += 1

if total == 0:
    print("ERROR: no coverage data found in", lcov_path)
    sys.exit(1)

pct = hit / total * 100
status = "PASS" if pct >= threshold else "FAIL"
print(f"Coverage: {hit}/{total} lines = {pct:.1f}%  [{status}: threshold {threshold}%]")

if pct < threshold:
    sys.exit(1)
PYEOF
