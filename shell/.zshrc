# 10x Productivity Shell Configuration
# Optimized for speed and developer productivity

export DOTFILES="$HOME/.dotfiles"

###############################################################################
# Path (deduplicated)                                                          #
###############################################################################

typeset -U PATH  # Ensure unique entries
export PATH="$HOME/bin:$DOTFILES/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:$PATH"

###############################################################################
# Environment                                                                  #
###############################################################################

export EDITOR="code --wait"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

###############################################################################
# History                                                                      #
###############################################################################

HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY

###############################################################################
# Atuin (Magical History)                                                      #
###############################################################################

if command -v atuin &>/dev/null; then
  eval "$(atuin init zsh)"
fi

###############################################################################
# Git                                                                          #
###############################################################################

alias g="git"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit -v"
alias gcm="git commit -m"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gl="git pull"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gst="git status -sb"
alias gd="git diff"
alias gds="git diff --staged"
alias glog="git log --oneline -20"
alias glg="git log --graph --oneline --all"
alias gundo="git reset HEAD~1 --soft"
alias gclean="git branch --merged | grep -v main | xargs git branch -d"

###############################################################################
# Navigation                                                                   #
###############################################################################

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"
alias o="open ."

# Modern replacements (conditional)
if command -v eza &>/dev/null; then
  alias ls="eza --icons"
  alias l="eza -la --icons"
  alias lt="eza -la --icons --tree --level=2"
else
  alias l="ls -lahA"
fi

command -v bat &>/dev/null && alias cat="bat --style=plain"
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

###############################################################################
# Quick Actions                                                                #
###############################################################################

alias reload="exec zsh"
alias c="clear"
alias q="exit"
alias e="code ."

alias cpwd="pwd | tr -d '\n' | pbcopy"
alias cplast="fc -ln -1 | pbcopy"

###############################################################################
# Development                                                                  #
###############################################################################

alias ni="npm install"
alias nr="npm run"
alias nrd="npm run dev"
alias nrb="npm run build"
alias p="pnpm"
alias pd="pnpm dev"

alias python="python3"
alias pip="pip3"
alias venv="python3 -m venv .venv && source .venv/bin/activate"

###############################################################################
# Performance                                                                  #
###############################################################################

alias freemem="sudo purge"
alias memhogs="ps aux | sort -nrk 4 | head -10"
alias cpuhogs="ps aux | sort -nrk 3 | head -10"
alias ports="lsof -i -P | grep LISTEN"
alias myip="curl -s ifconfig.me"
alias flushdns="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"

###############################################################################
# Functions                                                                    #
###############################################################################

cleanup() {
  brew cleanup -s 2>/dev/null
  npm cache clean --force 2>/dev/null
  rm -rf ~/Library/Caches/* 2>/dev/null
  echo "✅ Done"
}

mk() { mkdir -p "$1" && cd "$1"; }
killport() { lsof -ti:$1 | xargs kill -9 2>/dev/null; }

# FZF (if installed)
if command -v fzf &>/dev/null; then
  h() { print -z $(fc -l 1 | fzf --tac --no-sort | sed 's/^ *[0-9]* *//'); }
  pf() { cd "$(find ~/Projects ~/Code ~/work -maxdepth 2 -type d 2>/dev/null | fzf)"; }
fi

###############################################################################
# Lazy Loading                                                                 #
###############################################################################

command -v fnm &>/dev/null && eval "$(fnm env --use-on-cd)"

nvm() {
  unset -f nvm node npm npx
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  nvm "$@"
}

gcloud() {
  unset -f gcloud gsutil bq
  source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" 2>/dev/null
  gcloud "$@"
}

###############################################################################
# Prompt                                                                       #
###############################################################################

command -v starship &>/dev/null && eval "$(starship init zsh)" || PS1="%F{cyan}%~%f %# "

###############################################################################
# Completion                                                                   #
###############################################################################

autoload -Uz compinit
[[ -n ~/.zcompdump(#qN.mh+24) ]] && compinit || compinit -C

###############################################################################
# Plugins                                                                      #
###############################################################################

[[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
