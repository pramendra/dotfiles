#!/usr/bin/env bash
set -euo pipefail

# Check for dockutil
if ! command -v dockutil >/dev/null 2>&1; then
    echo "Error: dockutil is not installed"
    echo "Installing dockutil..."
    brew install dockutil
fi

echo "Configuring Dock..."

# Dock Settings
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock showhidden -bool true

# Clear dock items
dockutil --no-restart --remove all

# Add applications to Dock
DOCK_APPS=(
    "/Applications/Google Chrome.app"
    "/Applications/iTerm.app"
    "/System/Applications/System Settings.app"
)

for app in "${DOCK_APPS[@]}"; do
    if [ -e "$app" ]; then
        dockutil --no-restart --add "$app"
    else
        echo "Warning: $app not found, skipping..."
    fi
done

echo "Restarting Dock..."
killall Dock

echo "Dock configuration complete! ✨"