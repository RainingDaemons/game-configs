#!/usr/bin/env bash
# deploy_status_page.sh
# Copies extra_pages content to the status page
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p /opt/status-page/extra_pages
cp -r "$SCRIPT_DIR/extra_pages/." /opt/status-page/extra_pages/
