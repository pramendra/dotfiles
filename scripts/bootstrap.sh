#!/usr/bin/env bash
set -euo pipefail

# ────────────────────────────────
# Utility helpers
# ────────────────────────────────
log()    { echo -e "➡️  $*"; }
ok()     { echo -e "✅ $*"; }
warn()   { echo -e "⚠️  $*"; }
error()  { echo -e "❌ $*" >&2; }

# ────────────────────────────────
# Homebrew initialization
# ────────────────────────────────
setup_brew() {
  if ! command -v brew >/dev/null 2>&1; then
    log "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Initialize Homebrew depending on arch
  if [[ $(uname -m) == 'arm64' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  ok "Homebrew ready at $(brew --prefix)"
}

# ────────────────────────────────
# Brewfile bundle
# ────────────────────────────────
install_brewfile() {
  log "Updating Homebrew..."
  brew update --quiet

  log "Applying Brewfile bundle..."
  brew bundle --file="$(dirname "$0")/../Brewfile" || true

  ok "Brew packages synced"
}

# ────────────────────────────────
# Mac App Store apps via mas
# ────────────────────────────────
upgrade_mas() {
  if command -v mas >/dev/null 2>&1; then
    if mas account >/dev/null 2>&1; then
      log "Upgrading Mac App Store apps..."
      mas upgrade || true
      ok "MAS apps upgraded"
    else
      warn "Sign into the Mac App Store to enable MAS installs/upgrades."
    fi
  fi
}

# ────────────────────────────────
# Setup Oh My Zsh
# ────────────────────────────────
install_ohmyzsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log "Installing Oh My Zsh..."
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
    ok "Oh My Zsh installed"
  else
    ok "Oh My Zsh already installed"
    (cd ~/.oh-my-zsh && git pull --quiet && ok "Oh My Zsh updated") || warn "Failed to update Oh My Zsh"
  fi
}

# ────────────────────────────────
# Ensure supporting dirs
# ────────────────────────────────
setup_nvm() {
  mkdir -p "$HOME/.nvm"
  ok "~/.nvm ensured for Node Version Manager"
}

# ────────────────────────────────
# Run bootstrap
# ────────────────────────────────
main() {
  setup_brew
  install_brewfile
  upgrade_mas
  install_ohmyzsh
  setup_nvm

  echo "✨ Bootstrap complete!"
}

main "$@"
