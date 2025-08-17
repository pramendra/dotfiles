#!/bin/zsh
# Ensure this file is sourced by zsh

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Path Configuration
PATH="$HOME/bin:$PATH"
export PATH

# Initialize ZSH features only if running in zsh
if [ -n "$ZSH_VERSION" ]; then
    # Initialize completions
    autoload -Uz compinit && compinit
    autoload -U add-zsh-hook
fi

# Starship Configuration
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
if command -v starship >/dev/null; then
    eval "$(starship init zsh)"
else
    echo "Starship not installed. Run: brew install starship"
fi

# FZF Configuration
if [ -f "/opt/homebrew/opt/fzf/shell/completion.zsh" ]; then
    source "/opt/homebrew/opt/fzf/shell/completion.zsh"
    source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
fi

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
if command -v brew >/dev/null 2>&1; then
    NVM_PREFIX="$(brew --prefix nvm 2>/dev/null || true)"
    [ -s "$NVM_PREFIX/nvm.sh" ] && . "$NVM_PREFIX/nvm.sh"
    [ -s "$NVM_PREFIX/etc/bash_completion.d/nvm" ] && . "$NVM_PREFIX/etc/bash_completion.d/nvm"
fi

# Auto Node Version Switching
load-nvmrc() {
    local nvmrc_path="$(pwd)/.nvmrc"
    if [ -f "$nvmrc_path" ] && command -v nvm >/dev/null 2>&1; then
        nvm use --silent >/dev/null 2>&1 || nvm install
    fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc