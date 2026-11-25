#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
git diff --quiet && git diff --cached --quiet || { echo "Commit local changes first"; exit 1; }
git pull --ff-only
exec bash install.sh "$@"
