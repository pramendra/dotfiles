# 10x Productivity Shell Configuration
# Modular design: each module loaded from shell/ directory
# Shell startup target: <0.1s

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
# Modules                                                                      #
###############################################################################

# Load all .zsh modules from shell/ directory
for module in aliases browser functions tools; do
  [[ -r "$DOTFILES/shell/${module}.zsh" ]] && source "$DOTFILES/shell/${module}.zsh"
done
unset module

###############################################################################
# Quick Actions (kept here for fast access)                                    #
###############################################################################

alias reload="exec zsh"
alias c="clear"
alias q="exit"
alias e="code ."

alias cpwd="pwd | tr -d '\n' | pbcopy"
alias cplast="fc -ln -1 | pbcopy"

###############################################################################
# Navigation                                                                   #
###############################################################################

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"
alias o="open ."

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
