# Minimal zshrc
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export DOTFILES="$HOME/.dotfiles"

# Basic prompt
PS1="%n@%m %~ %# "

# Source bash profile if exists
if [ -f ~/.bash_profile ]; then
  source ~/.bash_profile
fi

# Bun
export PATH="$HOME/.bun/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Basic completion
autoload -Uz compinit
compinit
# Starship prompt
eval "$(starship init zsh)"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
