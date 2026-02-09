#!/bin/bash
#
# Dotfiles Apply Script
# Applies all dotfiles settings and symlinks
#
# Usage: ~/.dotfiles/apply.sh
#

set -e

DOTFILES="$HOME/.dotfiles"

echo "🔧 Applying dotfiles..."

###############################################################################
# Create symlinks                                                              #
###############################################################################

echo "🔗 Creating symlinks..."

# Shell
ln -sf "$DOTFILES/shell/.zshrc" "$HOME/.zshrc"

# Git
ln -sf "$DOTFILES/config/git/config" "$HOME/.gitconfig"
mkdir -p "$HOME/.config/git"
ln -sf "$DOTFILES/config/git/ignore" "$HOME/.config/git/ignore"

# Starship
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES/config/starship.toml" "$HOME/.config/starship.toml"

echo "✅ Symlinks created"

###############################################################################
# Apply macOS defaults                                                         #
###############################################################################

read -p "🍎 Apply macOS system defaults? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  source "$DOTFILES/macos/defaults.sh"
fi

###############################################################################
# VSCode settings                                                              #
###############################################################################

if [ -d "/Applications/Visual Studio Code.app" ]; then
  echo "📝 Setting up VSCode..."
  VSCODE_DIR="$HOME/Library/Application Support/Code/User"
  mkdir -p "$VSCODE_DIR"
  
  [ -f "$DOTFILES/config/vscode/settings.json" ] && \
    ln -sf "$DOTFILES/config/vscode/settings.json" "$VSCODE_DIR/settings.json"
  
  [ -f "$DOTFILES/config/vscode/keybindings.json" ] && \
    ln -sf "$DOTFILES/config/vscode/keybindings.json" "$VSCODE_DIR/keybindings.json"
  
  echo "✅ VSCode configured"
fi

###############################################################################
# Done                                                                         #
###############################################################################

echo ""
echo "🎉 Dotfiles applied!"
echo ""
echo "Open a new terminal to see changes."
