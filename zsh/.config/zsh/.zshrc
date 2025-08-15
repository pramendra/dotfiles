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
