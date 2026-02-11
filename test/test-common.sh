#!/usr/bin/env bash
#
# Tests for lib/common.sh
#

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
source "$DOTFILES_DIR/test/test-helper.sh"

# Override strict mode for testing
set +euo pipefail

describe "lib/common.sh - File Structure"

assert_file_exists "$DOTFILES_DIR/lib/common.sh" "common.sh exists"

# Source the library (capture output since it doesn't produce any)
source "$DOTFILES_DIR/lib/common.sh" 2>/dev/null
# Reset strict mode after sourcing
set +euo pipefail

describe "Logging Functions"

# Test log_info
output=$(log_info "test message" 2>&1)
assert_contains "$output" "test message" "log_info outputs message"
assert_contains "$output" "✓" "log_info has check mark"

# Test log_warn
output=$(log_warn "warning" 2>&1)
assert_contains "$output" "warning" "log_warn outputs message"
assert_contains "$output" "⚠" "log_warn has warning icon"

# Test log_error
output=$(log_error "error" 2>&1)
assert_contains "$output" "error" "log_error outputs message"
assert_contains "$output" "✗" "log_error has error icon"

# Test log_step
output=$(log_step "step" 2>&1)
assert_contains "$output" "step" "log_step outputs message"
assert_contains "$output" "▶" "log_step has arrow icon"

describe "Utility Functions"

# Test command_exists
assert_success "command_exists finds bash" command_exists "bash"
assert_failure "command_exists fails for nonexistent" command_exists "nonexistent_command_xyz"

# Test is_macos
if [[ "$OSTYPE" == "darwin"* ]]; then
  assert_success "is_macos returns true on macOS" is_macos
else
  skip_test "is_macos (not on macOS)"
fi

# Test get_dotfiles_dir
result=$(get_dotfiles_dir)
assert_not_empty "$result" "get_dotfiles_dir returns a value"
assert_equals "$DOTFILES_DIR" "$result" "get_dotfiles_dir matches DOTFILES_DIR"

# Test separator
output=$(separator 2>&1)
assert_not_empty "$output" "separator produces output"

describe "Color Constants"

assert_not_empty "$RED" "RED is defined"
assert_not_empty "$GREEN" "GREEN is defined"
assert_not_empty "$YELLOW" "YELLOW is defined"
assert_not_empty "$BLUE" "BLUE is defined"
assert_not_empty "$NC" "NC (no color) is defined"

print_results
