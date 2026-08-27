#!/usr/bin/env bash
# deploy_necesse.sh
# Updates necesse server files
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp "$SCRIPT_DIR/configs/necesse/workshop.txt" /home/steam/necesse_saves/workshop.txt
