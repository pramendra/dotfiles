#!/usr/bin/env bash
set -euo pipefail

# Load Homebrew nvm if available
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if command -v brew >/dev/null 2>&1; then
  NVM_PREFIX="$(brew --prefix nvm 2>/dev/null || true)"
  [ -s "$NVM_PREFIX/nvm.sh" ] && . "$NVM_PREFIX/nvm.sh"
fi

# Ensure we have Node (via nvm)
if ! command -v node >/dev/null 2>&1; then
  echo "No Node found; installing LTS via nvm…"
  nvm install --lts
  nvm alias default 'lts/*'
  nvm use default
fi

# Prefer Corepack for Yarn/pnpm, but still honor Npmfile entries
if command -v corepack >/dev/null 2>&1; then
  corepack enable || true
fi

# Install/upgrade all globals from Npmfile
mapfile -t pkgs < <(grep -vE '^\s*#' Npmfile | sed '/^\s*$/d')
if ((${#pkgs[@]})); then
  echo "Installing/updating global npm packages: ${pkgs[*]}"
  npm i -g "${pkgs[@]}"
else
  echo "Npmfile is empty; nothing to install."
fi

echo "Done."
