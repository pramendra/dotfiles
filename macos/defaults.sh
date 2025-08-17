#!/usr/bin/env bash
set -euo pipefail

echo "Configuring macOS defaults..."

# Close System Preferences
osascript -e 'tell application "System Preferences" to quit'

# Ask for admin password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script finishes
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# System                                                                     #
###############################################################################

# Set computer name
COMPUTER_NAME="Everest"
sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$COMPUTER_NAME"
sudo scutil --set LocalHostName "$COMPUTER_NAME"

# Set language and region
defaults write NSGlobalDomain AppleLanguages -array "en" "ja"
defaults write NSGlobalDomain AppleLocale -string "ja_JP@currency=JPY"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Set timezone
sudo systemsetup -settimezone "Asia/Tokyo" > /dev/null

###############################################################################
# Security & Privacy                                                          #
###############################################################################

# Require password immediately after sleep or screen saver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Disable "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

###############################################################################
# Keyboard & Input                                                           #
###############################################################################

# Fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable press-and-hold for keys
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# Finder                                                                     #
###############################################################################

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Keep folders on top when sorting
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Avoid .DS_Store files on network/USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in Finder windows
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

###############################################################################
# Terminal & iTerm2                                                          #
###############################################################################

# Only use UTF-8
defaults write com.apple.terminal StringEncodings -array 4

# iTerm2 settings
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
defaults write com.googlecode.iterm2 HideTab -bool true

###############################################################################
# Restart affected applications                                              #
###############################################################################

for app in "Finder" "Terminal" "SystemUIServer" "iTerm2"; do
    killall "${app}" &> /dev/null || true
done

echo "macOS defaults configuration complete! Some changes may require a logout/restart to take effect."