# ZSH Config Directory
export ZDOTDIR="$HOME/.config/zsh"

# Path
PATH="$HOME/bin:$PATH"

# Completion and corrections
autoload -Uz compinit && compinit
setopt auto_cd correct

# Modern CLI alternatives
alias ll='eza -lah --git'
alias cat='bat --paging=never'

# Starship prompt configuration
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
if command -v starship >/dev/null; then
    eval "$(starship init zsh)"
else
    echo "Starship is not installed. Run 'brew install starship' to install it."
fi

# FZF key bindings
/opt/homebrew/opt/fzf/install --key-bindings --completion --no-bash --no-fish >/dev/null 2>&1 || true

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
if command -v brew >/dev/null 2>&1; then
    NVM_PREFIX="$(brew --prefix nvm 2>/dev/null || true)"
    [ -s "$NVM_PREFIX/nvm.sh" ] && . "$NVM_PREFIX/nvm.sh"
    [ -s "$NVM_PREFIX/etc/bash_completion.d/nvm" ] && . "$NVM_PREFIX/etc/bash_completion.d/nvm"
fi

# Auto Node version switching
autoload -U add-zsh-hook
load-nvmrc() {
    local nvmrc_path="$(pwd)/.nvmrc"
    if [ -f "$nvmrc_path" ] && command -v nvm >/dev/null 2>&1; then
        nvm use --silent >/dev/null 2>&1 || nvm install
    fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc