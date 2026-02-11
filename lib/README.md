# Dotfiles Libraries

Shared utility libraries for all dotfiles scripts.

## Libraries

### `common.sh`
Core utilities used by all scripts.

**Functions:**
- `log_info()` - Success messages (green ✓)
- `log_warn()` - Warning messages (yellow ⚠)
- `log_error()` - Error messages (red ✗)
- `log_step()` - Section headers (blue ▶)
- `log_debug()` - Debug messages (requires DEBUG=1)
- `error_exit()` - Exit with error message
- `command_exists()` - Check if command is available
- `require_sudo()` - Prompt for sudo if needed
- `confirm()` - Ask user for confirmation
- `is_macos()` - Check if running on macOS
- `get_dotfiles_dir()` - Get dotfiles directory path

**Usage:**
```bash
source "${DOTFILES_DIR:-$HOME/.dotfiles}/lib/common.sh"

log_step "Starting operation"
command_exists brew || error_exit "Homebrew not installed"
log_info "Operation complete"
```

---

### `process.sh`
Process management utilities.

**Functions:**
- `kill_process()` - Kill process by name
- `safe_kill()` - Kill with logging
- `get_process_memory()` - Get memory usage (%)
- `get_process_memory_mb()` - Get memory usage (MB)
- `list_memory_hogs()` - List top memory consumers
- `is_process_running()` - Check if process is running
- `get_process_count()` - Count processes matching pattern
- `kill_all_matching()` - Kill all matching processes

**Usage:**
```bash
source "${DOTFILES_DIR:-$HOME/.dotfiles}/lib/process.sh"

if is_process_running "Chrome"; then
  mem=$(get_process_memory "Chrome")
  log_info "Chrome using ${mem}% memory"
  safe_kill "Chrome"
fi
```

---

### `launchctl.sh`
macOS launch agent/daemon management.

**Functions:**
- `disable_user_agent()` - Disable user launch agent
- `disable_system_daemon()` - Disable system daemon (requires sudo)
- `enable_user_agent()` - Enable user launch agent
- `disable_by_pattern()` - Disable all matching services
- `is_service_loaded()` - Check if service is loaded
- `unload_plist()` - Unload plist file
- `disable_finder_extension()` - Disable Finder extension
- `list_finder_extensions()` - List Finder extensions

**Usage:**
```bash
source "${DOTFILES_DIR:-$HOME/.dotfiles}/lib/launchctl.sh"

disable_user_agent "com.google.keystone.agent"
disable_by_pattern "idrive" "user"
disable_by_pattern "idrive" "system"
```

---

### `browser.sh`
Browser-specific utilities (Arc, Dia, Chrome).

**Functions:**
- `get_browser_memory()` - Get browser memory (%)
- `get_browser_memory_mb()` - Get browser memory (MB)
- `kill_browser()` - Kill specific browser
- `kill_all_browsers()` - Kill all browsers
- `clear_browser_cache()` - Clear browser cache
- `clear_all_browser_caches()` - Clear all caches
- `is_browser_running()` - Check if browser is running
- `get_total_browser_memory()` - Total browser memory
- `show_browser_memory_report()` - Display memory report

**Usage:**
```bash
source "${DOTFILES_DIR:-$HOME/.dotfiles}/lib/browser.sh"

if is_browser_running "arc"; then
  mem=$(get_browser_memory "arc")
  log_info "Arc using ${mem}% memory"
fi

clear_all_browser_caches
show_browser_memory_report
```

---

## Design Principles

1. **Idempotent** - Safe to run multiple times
2. **Silent failures** - Use `|| true` for non-critical operations
3. **Logging** - Consistent output format
4. **Error handling** - Fail fast on critical errors
5. **Portability** - Use `#!/usr/bin/env bash`

---

## Adding New Libraries

1. Create `lib/newlib.sh`
2. Add shebang: `#!/usr/bin/env bash`
3. Source common.sh: `source "$(dirname "${BASH_SOURCE[0]}")/common.sh"`
4. Document functions in this README
5. Update scripts to use new library
