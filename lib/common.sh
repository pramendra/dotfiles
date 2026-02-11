#!/usr/bin/env bash
#
# Common Utilities Library
# Shared functions for all dotfiles scripts
#
# Usage: source "${DOTFILES_DIR:-$HOME/.dotfiles}/lib/common.sh"
#

# Strict mode
set -euo pipefail

# Colors
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Logging functions
log_info() {
  echo -e "${GREEN}✓${NC} $*"
}

log_warn() {
  echo -e "${YELLOW}⚠${NC} $*"
}

log_error() {
  echo -e "${RED}✗${NC} $*" >&2
}

log_step() {
  echo -e "\n${BLUE}▶${NC} $*"
}

log_debug() {
  [ "${DEBUG:-0}" = "1" ] && echo -e "${BLUE}[DEBUG]${NC} $*"
}

# Error handler
error_exit() {
  log_error "$1"
  exit "${2:-1}"
}

# Check if command exists
command_exists() {
  command -v "$1" &>/dev/null
}

# Require sudo
require_sudo() {
  if [ "$EUID" -ne 0 ]; then
    log_warn "This operation requires sudo"
    sudo -v
  fi
}

# Get dotfiles directory
get_dotfiles_dir() {
  echo "${DOTFILES_DIR:-$HOME/.dotfiles}"
}

# Check if running on macOS
is_macos() {
  [[ "$OSTYPE" == "darwin"* ]]
}

# Get macOS version
get_macos_version() {
  sw_vers -productVersion 2>/dev/null || echo "unknown"
}

# Confirm action
confirm() {
  local prompt="${1:-Are you sure?}"
  local default="${2:-n}"
  
  if [ "$default" = "y" ]; then
    read -p "$prompt [Y/n] " -n 1 -r
  else
    read -p "$prompt [y/N] " -n 1 -r
  fi
  echo
  
  [[ $REPLY =~ ^[Yy]$ ]]
}

# Print separator
separator() {
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}
