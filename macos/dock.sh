#!/usr/bin/env bash
set -euo pipefail
if ! command -v dockutil >/dev/null 2>&1; then
  brew install hpedrorodrigues/tools/dockutil >/dev/null
fi
dockutil --remove all --no-restart
dockutil --add "/System/Applications/Calendar.app" --no-restart
dockutil --add "/Applications/iTerm.app" --no-restart
killall Dock 2>/dev/null || true
echo "Configured Dock."
