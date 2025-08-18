#!/bin/zsh
# Ensure this file is sourced by zsh

### ──────────────────────────────
### Directories & Environment
### ──────────────────────────────
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Path
export PATH="$HOME/bin:$PATH"

# Homebrew Initialization (Apple Silicon vs Intel)
if [[ $(uname -m) == 'arm64' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

### ──────────────────────────────
### Oh My Zsh
### ──────────────────────────────
export ZSH="$HOME/.oh-my-zsh"

# Use "robbyrussell" (default) or "random" to let Oh My Zsh pick a theme
# 👉 Starship overrides this prompt later, so theme choice here doesn't matter
ZSH_THEME="robbyrussell"

# Define some plugins (add more if you like)
plugins=(
  git
  z
  brew
  fzf
)

# Load Oh My Zsh framework
if [ -d "$ZSH" ]; then
    source "$ZSH/oh-my-zsh.sh"
else
    echo "⚠️  Oh My Zsh not installed. Run: make bootstrap"
fi

### ──────────────────────────────
### Shell Enhancements
### ──────────────────────────────
# Load Zsh modules safely
if [[ -n "${ZSH_VERSION:-}" ]]; then
    if (( $+commands[zmodload] )); then
        zmodload zsh/complist
    fi

    # Initialize completions
    autoload -Uz compinit && compinit
    autoload -U add-zsh-hook
fi

### ──────────────────────────────
### Prompt (Starship overrides Oh My Zsh theme)
### ──────────────────────────────
if command -v starship >/dev/null; then
    eval "$(starship init zsh)"
else
    echo "⚠️  Starship not installed. Run: brew install starship"
fi

### ──────────────────────────────
### FZF Configuration
### ──────────────────────────────
if [ -f "/opt/homebrew/opt/fzf/shell/completion.zsh" ]; then
    source "/opt/homebrew/opt/fzf/shell/completion.zsh"
    source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
fi

### ──────────────────────────────
### NVM & Node.js
### ──────────────────────────────
export NVM_DIR="$HOME/.nvm"
if command -v brew >/dev/null 2>&1; then
    NVM_PREFIX="$(brew --prefix nvm 2>/dev/null || true)"
    [ -s "$NVM_PREFIX/nvm.sh" ] && . "$NVM_PREFIX/nvm.sh"
    [ -s "$NVM_PREFIX/etc/bash_completion.d/nvm" ] && . "$NVM_PREFIX/etc/bash_completion.d/nvm"
fi

# Auto Node version switching on `cd`
load-nvmrc() {
    local nvmrc_path="$(pwd)/.nvmrc"
    if [ -f "$nvmrc_path" ] && command -v nvm >/dev/null 2>&1; then
        nvm use --silent >/dev/null 2>&1 || nvm install
    fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
