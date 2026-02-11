#!/bin/bash
#
# Browser Cache Cleanup
# Clears browser caches and purges system memory
# Usage: ./browser-cleanup.sh
#

echo "🧹 Cleaning browser caches..."
echo ""

# Arc Browser
if [ -d ~/Library/Caches/company.thebrowser.Browser ]; then
  rm -rf ~/Library/Caches/company.thebrowser.Browser/*
  echo "✅ Arc cache cleared"
fi

# Dia Browser
if [ -d ~/Library/Caches/Dia ]; then
  rm -rf ~/Library/Caches/Dia/*
  echo "✅ Dia cache cleared"
fi

# Chrome
if [ -d ~/Library/Caches/Google/Chrome ]; then
  rm -rf ~/Library/Caches/Google/Chrome/*
  echo "✅ Chrome cache cleared"
fi

# Clear DNS cache
echo ""
echo "🔄 Clearing DNS cache..."
sudo dscacheutil -flushcache 2>/dev/null || true
sudo killall -HUP mDNSResponder 2>/dev/null || true
echo "✅ DNS cache cleared"

# Purge system memory
echo ""
echo "💾 Purging system memory..."
sudo purge 2>/dev/null || true
echo "✅ Memory purged"

echo ""
echo "✅ Browser cleanup complete!"
echo ""
echo "💡 Restart browsers for full effect"
