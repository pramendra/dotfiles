export ZDOTDIR="$HOME/.config/zsh"
PATH="$HOME/bin:$PATH"
autoload -Uz compinit && compinit
setopt auto_cd correct
alias ll='eza -lah --git'
alias cat='bat --paging=never'
