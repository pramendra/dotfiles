#!/bin/bash
#
# Auto-hide Menu Bar
# Automatically hides the menu bar on macOS
# Usage: ./autohide-menubar.sh
#

echo "🎯 Configuring auto-hide menu bar..."

# Auto-hide menu bar
defaults write NSGlobalDomain _HIHideMenuBar -bool true

# Alternative method (macOS Ventura+)
defaults write com.apple.dock autohide-menu-bar -bool true

# Restart SystemUIServer to apply changes
killall SystemUIServer 2>/dev/null || true

echo "✅ Menu bar will now auto-hide"
echo ""
echo "💡 To show menu bar temporarily, move cursor to top of screen"
echo ""
echo "To revert: defaults write NSGlobalDomain _HIHideMenuBar -bool false && killall SystemUIServer"
