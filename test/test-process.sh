#!/usr/bin/env bash
#
# Tests for lib/process.sh
#

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
source "$DOTFILES_DIR/test/test-helper.sh"

# Override strict mode
set +euo pipefail

describe "lib/process.sh - File Structure"

assert_file_exists "$DOTFILES_DIR/lib/process.sh" "process.sh exists"

# Source the library
source "$DOTFILES_DIR/lib/process.sh" 2>/dev/null
set +euo pipefail

describe "Process Detection"

# Test is_process_running (loginwindow is always running on macOS)
assert_success "is_process_running detects loginwindow" is_process_running "loginwindow"
assert_failure "is_process_running fails for nonexistent" is_process_running "nonexistent_process_xyz"

# Test get_process_count
count=$(get_process_count "bash")
assert_not_empty "$count" "get_process_count returns value for bash"

describe "Memory Functions"

# Test get_process_memory
mem=$(get_process_memory "bash")
# May be empty if bash is low memory, so just test it runs
assert_success "get_process_memory runs without error" get_process_memory "bash"

# Test list_memory_hogs
output=$(list_memory_hogs 3)
assert_not_empty "$output" "list_memory_hogs returns output"

describe "Kill Functions (Dry Run)"

# These should return 1 (process not found) for nonexistent processes
assert_failure "kill_process fails for nonexistent" kill_process "definitely_not_a_real_process_12345"
assert_failure "safe_kill returns 1 for nonexistent" safe_kill "definitely_not_a_real_process_12345"

print_results
