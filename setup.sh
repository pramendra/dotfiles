#!/bin/bash
#
# Quick Setup for Browser Optimization
# Activates shell functions and makes scripts executable
# Usage: source setup.sh
#

echo "🚀 Browser Optimization Setup"
echo "=============================="
echo ""

# Step 1: Make scripts executable
echo "📝 Making scripts executable..."
chmod +x ~/.dotfiles/macos/gpu-status.sh 2>/dev/null
chmod +x ~/.dotfiles/macos/browser-cleanup.sh 2>/dev/null
chmod +x ~/.dotfiles/macos/autohide-menubar.sh 2>/dev/null
chmod +x ~/.dotfiles/macos/memory-optimize.sh 2>/dev/null
chmod +x ~/.dotfiles/macos/memory-status.sh 2>/dev/null
echo "✅ Scripts executable"
echo ""

# Step 2: Reload shell functions
echo "📝 Reloading shell functions..."
source ~/.zshrc
echo "✅ Shell functions loaded"
echo ""

# Step 3: Show available commands
echo "📋 Available Commands:"
echo "  browsermem     - Show browser memory usage"
echo "  killbrowsers   - Kill all browsers"
echo "  gpustatus      - Check GPU and memory status"
echo "  arc-bare       - Open Arc with minimal profile"
echo "  dia-bare       - Open Dia with minimal profile"
echo ""

echo "✅ Setup complete!"
echo ""
echo "📌 Next Steps:"
echo ""
echo "1. Install Notion (choose one):"
echo "   • Download: https://www.notion.so/desktop"
echo "   • Or fix Homebrew: brew update && brew install --cask notion"
echo ""
echo "2. Enable GPU flags in browsers:"
echo "   • Arc: arc://flags/"
echo "   • Dia: dia://flags/"
echo "   • Chrome: chrome://flags/"
echo "   Enable: gpu-rasterization, zero-copy, shared-image-cache, angle-metal"
echo ""
echo "3. Install OneTab extension in all browsers"
echo ""
echo "4. Disable Speechify extension (saves 380MB)"
echo ""
echo "5. Apply macOS settings:"
echo "   ~/.dotfiles/macos/memory-optimize.sh"
echo ""
