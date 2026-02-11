#!/usr/bin/env bash
#
# Launchctl Management Library
# Functions for managing macOS launch agents and daemons
#
# Usage: source "${DOTFILES_DIR:-$HOME/.dotfiles}/lib/launchctl.sh"
#

# Source common utilities
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

# Disable user agent
disable_user_agent() {
  local service="$1"
  local user_id="$(id -u)"
  
  launchctl bootout "gui/$user_id/$service" 2>/dev/null || true
  launchctl disable "gui/$user_id/$service" 2>/dev/null || true
  
  log_debug "Disabled user agent: $service"
}

# Disable system daemon
disable_system_daemon() {
  local service="$1"
  
  require_sudo
  sudo launchctl bootout "system/$service" 2>/dev/null || true
  sudo launchctl disable "system/$service" 2>/dev/null || true
  
  log_debug "Disabled system daemon: $service"
}

# Enable user agent
enable_user_agent() {
  local service="$1"
  local user_id="$(id -u)"
  
  launchctl enable "gui/$user_id/$service" 2>/dev/null || true
  launchctl bootstrap "gui/$user_id" "$service" 2>/dev/null || true
  
  log_debug "Enabled user agent: $service"
}

# Find and disable by pattern
disable_by_pattern() {
  local pattern="$1"
  local domain="${2:-user}"
  
  local services
  local count=0
  
  if [ "$domain" = "user" ]; then
    services=$(launchctl list | grep -i "$pattern" | awk '{print $3}')
    for service in $services; do
      disable_user_agent "$service"
      ((count++))
    done
  else
    require_sudo
    services=$(sudo launchctl list | grep -i "$pattern" | awk '{print $3}')
    for service in $services; do
      disable_system_daemon "$service"
      ((count++))
    done
  fi
  
  [ $count -gt 0 ] && log_info "Disabled $count services matching: $pattern"
  return 0
}

# Check if service is loaded
is_service_loaded() {
  local service="$1"
  local domain="${2:-user}"
  
  if [ "$domain" = "user" ]; then
    launchctl list | grep -q "$service"
  else
    sudo launchctl list | grep -q "$service"
  fi
}

# Unload plist file
unload_plist() {
  local plist="$1"
  
  if [ -f "$plist" ]; then
    if [[ "$plist" == /Library/LaunchDaemons/* ]]; then
      require_sudo
      sudo launchctl unload -w "$plist" 2>/dev/null || true
    else
      launchctl unload -w "$plist" 2>/dev/null || true
    fi
    log_debug "Unloaded plist: $plist"
  fi
}

# Disable Finder extension
disable_finder_extension() {
  local extension_id="$1"
  pluginkit -e ignore -i "$extension_id" 2>/dev/null || true
  log_debug "Disabled Finder extension: $extension_id"
}

# List all Finder extensions matching pattern
list_finder_extensions() {
  local pattern="${1:-.*}"
  pluginkit -m | grep -i "$pattern" | awk '{print $3}'
}
