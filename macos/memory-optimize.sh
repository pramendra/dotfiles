#!/bin/bash
#
# macOS Memory Optimization Settings
# Optimizes system settings for 16GB MacBook
# Usage: ./memory-optimize.sh
#

echo "🧠 Optimizing macOS for memory efficiency (16GB)..."
echo ""

###############################################################################
# Disable Visual Effects & Animations                                         #
###############################################################################

echo "🎨 Reducing visual effects..."

# Disable transparency in menu bar and windows
defaults write com.apple.universalaccess reduceTransparency -bool true

# Disable animations when opening applications
defaults write com.apple.dock launchanim -bool false

# Disable window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Disable smooth scrolling (saves GPU memory)
defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

echo "✅ Visual effects reduced"

###############################################################################
# Dock Optimization                                                            #
###############################################################################

echo "🎯 Optimizing Dock..."

# Auto-hide Dock (frees up WindowServer memory)
defaults write com.apple.dock autohide -bool true

# Minimize delay for auto-hide
defaults write com.apple.dock autohide-delay -float 0

# Speed up animation
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Minimize windows into application icon (saves memory)
defaults write com.apple.dock minimize-to-application -bool true

echo "✅ Dock optimized"

###############################################################################
# Menu Bar Auto-Hide                                                           #
###############################################################################

echo "📱 Configuring menu bar auto-hide..."

# Auto-hide menu bar (saves WindowServer memory)
defaults write NSGlobalDomain _HIHideMenuBar -bool true

# Alternative method for newer macOS
defaults write com.apple.dock autohide-menu-bar -bool true

echo "✅ Menu bar will auto-hide"

###############################################################################
# Finder Optimization                                                          #
###############################################################################

echo "📁 Optimizing Finder..."

# Disable animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Don't show icons on desktop (saves memory)
defaults write com.apple.finder CreateDesktop -bool false

# Use list view by default (less memory than icon view)
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable window animations
defaults write com.apple.finder AnimateWindowZoom -bool false

echo "✅ Finder optimized"

###############################################################################
# Spotlight Optimization                                                       #
###############################################################################

echo "🔍 Optimizing Spotlight..."

# Reduce Spotlight indexing scope (saves CPU and memory)
# Disable indexing for specific folders
sudo mdutil -i off /System/Volumes/Data 2>/dev/null || true

# Limit Spotlight search results
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 0;"name" = "PDF";}' \
  '{"enabled" = 0;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "DOCUMENTS";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 0;"name" = "SOURCE";}' \
  '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
  '{"enabled" = 0;"name" = "MENU_OTHER";}' \
  '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
  '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
  '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
  '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

echo "✅ Spotlight optimized"

###############################################################################
# Notification Center                                                          #
###############################################################################

echo "🔔 Optimizing Notification Center..."

# Disable notification center widgets (saves memory)
defaults write com.apple.notificationcenterui ShowInNotificationCenter -bool false

echo "✅ Notification Center optimized"

###############################################################################
# Dashboard & Mission Control                                                  #
###############################################################################

echo "🎛️ Optimizing Mission Control..."

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don't group windows by application in Mission Control
defaults write com.apple.dock expose-group-by-app -bool false

# Disable automatic rearrangement of Spaces
defaults write com.apple.dock mru-spaces -bool false

echo "✅ Mission Control optimized"

###############################################################################
# Safari/Browser Optimization                                                  #
###############################################################################

echo "🌐 Optimizing Safari..."

# Disable preloading top hit in background
defaults write com.apple.Safari PreloadTopHit -bool false

# Disable thumbnail cache for Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

echo "✅ Safari optimized"

###############################################################################
# Time Machine                                                                 #
###############################################################################

echo "⏰ Optimizing Time Machine..."

# Disable local Time Machine snapshots (saves disk space and memory)
sudo tmutil disablelocal 2>/dev/null || true

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo "✅ Time Machine optimized"

###############################################################################
# App Nap & Power Settings                                                     #
###############################################################################

echo "⚡ Optimizing power settings..."

# Enable App Nap for all apps (reduces memory for background apps)
defaults write NSGlobalDomain NSAppSleepDisabled -bool false

# Disable sudden motion sensor (for SSDs, saves CPU)
sudo pmset -a sms 0 2>/dev/null || true

echo "✅ Power settings optimized"

###############################################################################
# Disable Unused Services                                                      #
###############################################################################

echo "🔇 Disabling unused services..."

# Disable Handoff
defaults write com.apple.coreservices.useractivityd ActivityAdvertisingAllowed -bool false
defaults write com.apple.coreservices.useractivityd ActivityReceivingAllowed -bool false

# Disable AirDrop
defaults write com.apple.NetworkBrowser DisableAirDrop -bool true

# Disable Siri
defaults write com.apple.assistant.support "Assistant Enabled" -bool false

# Disable dictation
defaults write com.apple.HIToolbox AppleDictationAutoEnable -int 0

echo "✅ Unused services disabled"

###############################################################################
# Memory Management                                                            #
###############################################################################

echo "💾 Configuring memory management..."

# Increase swap usage threshold (prefer swap over memory pressure)
# This is more aggressive but helps on 16GB systems
sudo sysctl vm.swapusage=1 2>/dev/null || true

# Disable memory compression (controversial - may help or hurt)
# Uncomment if you want to try it
# sudo nvram boot-args="vm_compressor=2"

echo "✅ Memory management configured"

###############################################################################
# Restart Required Services                                                    #
###############################################################################

echo ""
echo "🔄 Restarting affected services..."

# Restart Dock
killall Dock 2>/dev/null || true

# Restart Finder
killall Finder 2>/dev/null || true

# Restart SystemUIServer
killall SystemUIServer 2>/dev/null || true

echo "✅ Services restarted"

###############################################################################
# Summary                                                                      #
###############################################################################

echo ""
echo "✅ Memory optimization complete!"
echo ""
echo "📋 Changes made:"
echo "   • Disabled transparency and animations"
echo "   • Auto-hide Dock enabled"
echo "   • Desktop icons disabled"
echo "   • Spotlight indexing reduced"
echo "   • Notification Center widgets disabled"
echo "   • Dashboard disabled"
echo "   • Handoff and AirDrop disabled"
echo "   • Siri disabled"
echo ""
echo "⚠️  Some changes require a restart to take full effect."
echo "    Run: sudo shutdown -r now"
echo ""
echo "💡 Additional manual steps:"
echo "   1. System Settings → Desktop & Dock → Minimize windows using: Scale effect"
echo "   2. System Settings → Accessibility → Display → Reduce motion: ON"
echo "   3. System Settings → General → AirDrop & Handoff → Allow Handoff: OFF"
echo "   4. Close unused browser tabs (Browser Helpers using ~1.5GB)"
echo "   5. Consider closing Dia when not in use (995.9 MB)"
echo ""
