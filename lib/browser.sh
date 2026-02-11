#!/usr/bin/env bash
#
# Browser Management Library
# Functions for managing browsers (Arc, Dia, Chrome)
#
# Usage: source "${DOTFILES_DIR:-$HOME/.dotfiles}/lib/browser.sh"
#

# Source common utilities
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"
source "$(dirname "${BASH_SOURCE[0]}")/process.sh"

# Browser definitions
declare -gA BROWSERS=(
  [arc]="Arc"
  [dia]="Dia"
  [chrome]="Google Chrome"
)

declare -gA BROWSER_CACHE_DIRS=(
  [arc]="$HOME/Library/Caches/company.thebrowser.Browser"
  [dia]="$HOME/Library/Caches/Dia"
  [chrome]="$HOME/Library/Caches/Google/Chrome"
)

# Get browser memory usage (percentage)
get_browser_memory() {
  local browser="$1"
  local browser_name="${BROWSERS[$browser]}"
  
  if [ -z "$browser_name" ]; then
    log_error "Unknown browser: $browser"
    return 1
  fi
  
  get_process_memory "$browser_name"
}

# Get browser memory in MB
get_browser_memory_mb() {
  local browser="$1"
  local browser_name="${BROWSERS[$browser]}"
  
  if [ -z "$browser_name" ]; then
    log_error "Unknown browser: $browser"
    return 1
  fi
  
  get_process_memory_mb "$browser_name"
}

# Kill browser
kill_browser() {
  local browser="$1"
  local browser_name="${BROWSERS[$browser]}"
  
  if [ -z "$browser_name" ]; then
    log_error "Unknown browser: $browser"
    return 1
  fi
  
  safe_kill "$browser_name"
}

# Kill all browsers
kill_all_browsers() {
  local count=0
  for browser in "${!BROWSERS[@]}"; do
    kill_browser "$browser" && ((count++))
  done
  
  [ $count -gt 0 ] && log_info "Killed $count browsers"
  return 0
}

# Clear browser cache
clear_browser_cache() {
  local browser="$1"
  local cache_dir="${BROWSER_CACHE_DIRS[$browser]}"
  
  if [ -z "$cache_dir" ]; then
    log_error "Unknown browser: $browser"
    return 1
  fi
  
  if [ -d "$cache_dir" ]; then
    rm -rf "$cache_dir"/* 2>/dev/null || true
    log_info "Cleared $browser cache"
  else
    log_debug "Cache directory not found: $cache_dir"
  fi
}

# Clear all browser caches
clear_all_browser_caches() {
  for browser in "${!BROWSER_CACHE_DIRS[@]}"; do
    clear_browser_cache "$browser"
  done
}

# Check if browser is running
is_browser_running() {
  local browser="$1"
  local browser_name="${BROWSERS[$browser]}"
  
  if [ -z "$browser_name" ]; then
    return 1
  fi
  
  is_process_running "$browser_name"
}

# Get total browser memory usage
get_total_browser_memory() {
  local total=0
  for browser in "${!BROWSERS[@]}"; do
    if is_browser_running "$browser"; then
      local mem=$(get_browser_memory "$browser")
      total=$(echo "$total + ${mem:-0}" | bc)
    fi
  done
  echo "$total"
}

# Show browser memory report
show_browser_memory_report() {
  log_step "Browser Memory Usage"
  
  local total=0
  for browser in arc dia chrome; do
    if is_browser_running "$browser"; then
      local mem=$(get_browser_memory "$browser")
      printf "%-10s %6.1f%%\n" "$browser:" "${mem:-0}"
      total=$(echo "$total + ${mem:-0}" | bc)
    fi
  done
  
  echo ""
  printf "%-10s %6.1f%%\n" "Total:" "$total"
}
