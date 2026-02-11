# Tool Configurations
# External tool initialization and configuration

###############################################################################
# Atuin (Magical History)                                                      #
###############################################################################

if command -v atuin &>/dev/null; then
  eval "$(atuin init zsh)"
fi

###############################################################################
# Modern Replacements                                                          #
###############################################################################

# eza (modern ls)
if command -v eza &>/dev/null; then
  alias ls="eza --icons"
  alias l="eza -la --icons"
  alias lt="eza -la --icons --tree --level=2"
else
  alias l="ls -lahA"
fi

# bat (modern cat)
command -v bat &>/dev/null && alias cat="bat --style=plain"

# zoxide (smart cd)
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# fnm (fast node manager)
command -v fnm &>/dev/null && eval "$(fnm env --use-on-cd)"

###############################################################################
# Lazy Loading (for slow tools)                                                #
###############################################################################

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
# Completions                                                                  #
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
