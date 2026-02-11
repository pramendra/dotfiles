#!/usr/bin/env bash
#
# Process Management Library
# Functions for managing system processes
#
# Usage: source "${DOTFILES_DIR:-$HOME/.dotfiles}/lib/process.sh"
#

# Source common utilities
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

# Kill process by name
kill_process() {
  local name="$1"
  local signal="${2:--9}"
  
  if pgrep -f "$name" >/dev/null 2>&1; then
    pkill "$signal" -f "$name" 2>/dev/null || true
    log_debug "Killed process: $name"
    return 0
  fi
  return 1
}

# Safe process kill with logging
safe_kill() {
  local process="$1"
  local signal="${2:--9}"
  
  if pgrep -f "$process" >/dev/null 2>&1; then
    pkill "$signal" -f "$process" 2>/dev/null || true
    log_info "Killed $process"
    return 0
  else
    log_debug "Process not running: $process"
    return 1
  fi
}

# Get process memory usage (percentage)
get_process_memory() {
  local name="$1"
  ps aux | grep -i "$name" | grep -v grep | awk '{sum+=$4} END {print sum}'
}

# Get process memory in MB
get_process_memory_mb() {
  local name="$1"
  ps aux | grep -i "$name" | grep -v grep | awk '{sum+=$6} END {print sum/1024}'
}

# List processes by memory usage
list_memory_hogs() {
  local count="${1:-10}"
  ps aux | sort -nrk 4 | head -n "$count"
}

# Check if process is running
is_process_running() {
  local name="$1"
  pgrep -f "$name" >/dev/null 2>&1
}

# Get process count
get_process_count() {
  local name="$1"
  pgrep -f "$name" 2>/dev/null | wc -l | tr -d ' '
}

# Kill all processes matching pattern
kill_all_matching() {
  local pattern="$1"
  local signal="${2:--9}"
  
  local count=0
  while IFS= read -r proc; do
    kill_process "$proc" "$signal" && ((count++))
  done < <(pgrep -f "$pattern" 2>/dev/null)
  
  [ $count -gt 0 ] && log_info "Killed $count processes matching: $pattern"
  return 0
}
