export ZDOTDIR="$HOME/.config/zsh"
PATH="$HOME/bin:$PATH"
autoload -Uz compinit && compinit
setopt auto_cd correct
alias ll='eza -lah --git'
alias cat='bat --paging=never'

# starship prompt if available
command -v starship >/dev/null && eval "$(starship init zsh)"

# fzf keybindings
/opt/homebrew/opt/fzf/install --key-bindings --completion --no-bash --no-fish >/dev/null 2>&1 || true

# --- NVM (Homebrew) ---
# Keep nvm data out of repo; Homebrew installs nvm code separately.
export NVM_DIR="$HOME/.nvm"
# Load nvm if installed via Homebrew
if command -v brew >/dev/null 2>&1; then
  NVM_PREFIX="$(brew --prefix nvm 2>/dev/null || true)"
  [ -s "$NVM_PREFIX/nvm.sh" ] && . "$NVM_PREFIX/nvm.sh"
  [ -s "$NVM_PREFIX/etc/bash_completion.d/nvm" ] && . "$NVM_PREFIX/etc/bash_completion.d/nvm"
fi

# Auto-use the Node version from .nvmrc when you cd into a project
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(pwd)/.nvmrc"
  if [ -f "$nvmrc_path" ] && command -v nvm >/dev/null 2>&1; then
    nvm use --silent >/dev/null 2>&1 || nvm install
  fi
}
add-zsh-hook chpwd load-nvmrc
# run once for the current directory
load-nvmrc
# --- end NVM ---