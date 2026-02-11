# Shell Functions
# Reusable shell functions

# Quick directory creation + cd
mk() { mkdir -p "$1" && cd "$1"; }

# Kill process on port
killport() { lsof -ti:"$1" | xargs kill -9 2>/dev/null; }

# Cleanup caches
cleanup() {
  brew cleanup -s 2>/dev/null
  npm cache clean --force 2>/dev/null
  rm -rf ~/Library/Caches/* 2>/dev/null
  echo "✅ Done"
}

# Browser management
killbrowsers() {
  pkill -9 "Arc" 2>/dev/null
  pkill -9 "Dia" 2>/dev/null
  pkill -9 "Google Chrome" 2>/dev/null
  echo "✅ All browsers killed"
}

browsermem() {
  echo "🌐 Browser Memory Usage:"
  echo "Arc:    $(ps aux | grep 'Arc.app' | grep -v grep | awk '{sum+=$4} END {print sum}')%"
  echo "Dia:    $(ps aux | grep 'Dia.app' | grep -v grep | awk '{sum+=$4} END {print sum}')%"
  echo "Chrome: $(ps aux | grep 'Google Chrome' | grep -v grep | awk '{sum+=$4} END {print sum}')%"
}

gpustatus() {
  ~/.dotfiles/macos/gpu-status.sh
}

# FZF-powered functions (loaded conditionally)
if command -v fzf &>/dev/null; then
  h() { print -z $(fc -l 1 | fzf --tac --no-sort | sed 's/^ *[0-9]* *//'); }
  pf() { cd "$(find ~/Projects ~/Code ~/work -maxdepth 2 -type d 2>/dev/null | fzf)"; }
fi
