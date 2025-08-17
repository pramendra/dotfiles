# Homebrew setup (dynamically detect path based on architecture)
if [[ $(uname -m) == 'arm64' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Set ZSH config directory
export ZDOTDIR="$HOME/.config/zsh"

# Add local bin to PATH
export PATH="$HOME/bin:$PATH"