#!/usr/bin/env bash
set -euo pipefail
osascript -e 'tell application "System Settings" to quit' >/dev/null 2>&1 || true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"
killall SystemUIServer Finder Dock 2>/dev/null || true
echo "Applied macOS defaults."
