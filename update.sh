#!/usr/bin/env bash
# update.sh
# Updates repository with latest git changes
set -euo pipefail

git pull --rebase
