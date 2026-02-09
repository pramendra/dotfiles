#!/bin/bash

# Chrome Performance & Productivity Defaults
# Aggressive memory saving and CPU optimization

echo "🚀 Optimizing Chrome..."

# Enable Memory Saver Mode (Aggressive)
defaults write com.google.Chrome HighEfficiencyModeEnabled -bool true
defaults write com.google.Chrome HighEfficiencyModeState -int 1  # 1 = On

# Enable Energy Saver Mode (Always on for laptops)
defaults write com.google.Chrome BatterySaverModeEnabled -bool true
defaults write com.google.Chrome BatterySaverModeState -int 2    # 2 = When unplugged (or 1 for always)

# Disable detailed reporting (Privacy + CPU)
defaults write com.google.Chrome MetricsReportingEnabled -bool false
defaults write com.google.Chrome CrashReportsEnabled -bool false

# Printer settings (disable print preview for speed if needed, optional)
defaults write com.google.Chrome DisablePrintPreview -bool false

# Hardware Acceleration (Ensure it's ON for GPU offloading)
defaults write com.google.Chrome HardwareAccelerationModeEnabled -bool true

# Block third-party cookies (Privacy + minor perf)
defaults write com.google.Chrome BlockThirdPartyCookies -bool true

echo "✅ Chrome settings applied. Restart Chrome to take effect."
