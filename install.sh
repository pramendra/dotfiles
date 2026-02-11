#!/bin/bash
#
# Dotfiles installer - One command Mac setup
# Usage: curl -fsSL https://raw.githubusercontent.com/pramendra/dotfiles/main/install.sh | bash
# Or:    ~/.dotfiles/install.sh
#

set -e

DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_REPO="https://github.com/pramendra/dotfiles.git"

echo "🚀 Starting Mac setup..."

###############################################################################
# Clone dotfiles if not present                                                #
###############################################################################

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "📥 Cloning dotfiles..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  echo "✅ Dotfiles already present at $DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

###############################################################################
# Install Homebrew                                                             #
###############################################################################

if ! command -v brew &>/dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Add to path for this session
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "✅ Homebrew already installed"
fi

###############################################################################
# Install packages from Brewfile                                               #
###############################################################################

echo "📦 Installing packages from Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile" || true

###############################################################################
# Create symlinks                                                              #
###############################################################################

echo "🔗 Creating symlinks..."

# Shell configs
ln -sf "$DOTFILES_DIR/shell/.zshrc" "$HOME/.zshrc"

# Git config
mkdir -p "$HOME/.config/git"
ln -sf "$DOTFILES_DIR/config/git/config" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/config/git/ignore" "$HOME/.config/git/ignore"

# Starship prompt
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/config/starship.toml" "$HOME/.config/starship.toml" 2>/dev/null || true

echo "✅ Symlinks created"

###############################################################################
# Apply macOS defaults                                                         #
###############################################################################

read -p "🍎 Apply macOS system defaults? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "⚙️ Applying macOS defaults..."
  source "$DOTFILES_DIR/macos/defaults.sh"
fi

###############################################################################
# Setup VSCode                                                                 #
###############################################################################

if [ -d "/Applications/Visual Studio Code.app" ]; then
  echo "📝 Setting up VSCode..."
  VSCODE_DIR="$HOME/Library/Application Support/Code/User"
  mkdir -p "$VSCODE_DIR"
  ln -sf "$DOTFILES_DIR/config/vscode/settings.json" "$VSCODE_DIR/settings.json"
  ln -sf "$DOTFILES_DIR/config/vscode/keybindings.json" "$VSCODE_DIR/keybindings.json"
  
  # Install extensions
  if [ -f "$DOTFILES_DIR/config/vscode/extensions.txt" ]; then
    while read extension; do
      code --install-extension "$extension" 2>/dev/null || true
    done < "$DOTFILES_DIR/config/vscode/extensions.txt"
  fi
fi

###############################################################################
# Disable unused Launch Agents                                                 #
###############################################################################

echo "🔇 Disabling unused launch agents..."

# iDrive (if not using)
launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.iDrive*.plist 2>/dev/null || true

# Bear Widgets (if not using Bear)
launchctl bootout gui/$(id -u)/net.shinyfrog.bear.BearWidgets 2>/dev/null || true

# Google Drive (if not using)
launchctl bootout gui/$(id -u)/com.google.GoogleDrive 2>/dev/null || true

# Run silence script for comprehensive agent disabling
echo "🤫 Silencing background agents..."
if [ -f "$DOTFILES_DIR/bin/silence" ]; then
  "$DOTFILES_DIR/bin/silence"
fi

###############################################################################
# Final setup                                                                  #
###############################################################################

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo "   1. Open a new terminal"
echo "   2. Run 'fnm install --lts' for Node.js"
echo "   3. Log in to 1Password/GitHub/etc"
echo ""
echo "🎉 Happy coding!"
