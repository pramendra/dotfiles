#!/usr/bin/env bash
set -euo pipefail
COMPUTER_NAME="Everest"

osascript -e 'tell application "System Settings" to quit' >/dev/null 2>&1 || true

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$COMPUTER_NAME"
sudo scutil --set LocalHostName "$COMPUTER_NAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"

defaults write NSGlobalDomain AppleShowAllExtensions -bool true
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"
killall SystemUIServer Finder Dock 2>/dev/null || true
echo "Applied macOS defaults."
