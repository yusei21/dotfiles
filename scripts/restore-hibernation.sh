#!/usr/bin/env bash
set -euo pipefail

sudo systemctl unmask \
  hibernate.target \
  hybrid-sleep.target \
  suspend-then-hibernate.target

printf 'Hibernacao reativada.\n'
