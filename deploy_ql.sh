#!/usr/bin/env bash
# deploy_ql.sh
# Updates quakelive server files
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp "$SCRIPT_DIR/quakelive/workshop.txt" /home/steam/quakelive/qlds/baseq3/workshop.txt
cp "$SCRIPT_DIR/quakelive/mappool.txt" /home/steam/quakelive/qlds/baseq3/mappool.txt
