#!/usr/bin/env bash
set -euo pipefail

# Initialize Homebrew if needed
if [[ $(uname -m) == 'arm64' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Update Homebrew metadata (faster subsequent ops)
brew update --quiet

# Install/upgrade everything in Brewfile:
# - installs if missing
# - upgrades if outdated
# - no-op if already current
brew bundle --file="$(dirname "$0")/../Brewfile"

# If MAS is available, try upgrades (user must be signed in to App Store)
if command -v mas >/dev/null 2>&1; then
  if mas account >/dev/null 2>&1; then
    mas upgrade || true
  else
    echo "Tip: Sign into the Mac App Store app to enable MAS installs/upgrades."
  fi
fi

# Ensure NVM_DIR exists for Homebrew-managed nvm
mkdir -p "$HOME/.nvm"

echo "Bootstrap complete! ✨"