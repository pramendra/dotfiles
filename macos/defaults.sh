#!/bin/bash
#
# macOS Performance Defaults
# Run: source ~/.dotfiles/macos/defaults.sh
#

COMPUTER_NAME="Everest"

osascript -e 'tell application "System Preferences" to quit' 2>/dev/null
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# PERFORMANCE (Aggressive)                                                     #
###############################################################################

# Reduce motion and transparency
defaults write com.apple.universalaccess reduceMotion -bool true
defaults write com.apple.universalaccess reduceTransparency -bool true

# Disable all animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
defaults write -g QLPanelAnimationDuration -float 0
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.dock autohide-time-modifier -float 0.1
defaults write com.apple.dock autohide-delay -float 0

# Faster key repeat (10x typing speed)
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Disable auto-restore apps on login
defaults write NSGlobalDomain ApplePersistence -bool false

# Disable Spotlight indexing for external volumes
sudo mdutil -d /Volumes 2>/dev/null

###############################################################################
# Terminal.app                                                                 #
###############################################################################

defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal ShowLineMarks -int 0

# Terminal transparency (15% - subtle but visible)
defaults write com.apple.Terminal "Window Settings" -dict-add backgroundAlpha 0.85
defaults write com.apple.Terminal "Window Settings" -dict-add blurBackground true

###############################################################################
# Chrome Performance                                                           #
###############################################################################

defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool false
# Disable Chrome helper processes (reduces memory)
defaults write com.google.Chrome ExternalProtocolDialogShowAlwaysOpenCheckbox -bool true

###############################################################################
# Arc Browser Performance                                                      #
###############################################################################

defaults write company.thebrowser.Browser AppleEnableSwipeNavigateWithScrolls -bool false

###############################################################################
# Computer Name                                                                #
###############################################################################

sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$COMPUTER_NAME"
sudo scutil --set LocalHostName "$COMPUTER_NAME"

###############################################################################
# Keyboard                                                                     #
###############################################################################

defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

###############################################################################
# Trackpad                                                                     #
###############################################################################

defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

###############################################################################
# Finder                                                                       #
###############################################################################

defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

###############################################################################
# Dock                                                                         #
###############################################################################

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock no-bouncing -bool true
defaults write com.Apple.Dock show-recents -bool false
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock tilesize -int 36

# Disable hot corners
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-br-corner -int 0

###############################################################################
# Screenshots                                                                  #
###############################################################################

defaults write com.apple.screencapture location -string "${HOME}/Desktop"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Panels                                                                       #
###############################################################################

defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

###############################################################################
# Security                                                                     #
###############################################################################

defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
defaults write com.apple.LaunchServices LSQuarantine -bool false

###############################################################################
# Sound                                                                        #
###############################################################################

defaults write com.apple.sound.beep.feedback -bool false
defaults write "Apple Global Domain" com.apple.sound.uiaudio.enabled -int 0

###############################################################################
# Energy (for performance)                                                     #
###############################################################################

# Prevent sleep when on power
sudo pmset -c displaysleep 15
sudo pmset -c sleep 0
sudo pmset -c disksleep 0

###############################################################################
# Restart affected apps                                                        #
###############################################################################

for app in "Dock" "Finder" "SystemUIServer"; do
  killall "${app}" &>/dev/null
done

echo "✅ macOS defaults applied (10x performance mode)"
echo "⚡ Some changes require logout/restart"
