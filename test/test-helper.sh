#!/usr/bin/env bash
#
# Dotfiles Test Framework
# Lightweight test helper for bash scripts
#
# Usage: source test/test-helper.sh
#

# Test counters
TESTS_PASSED=0
TESTS_FAILED=0
TESTS_SKIPPED=0
CURRENT_SUITE=""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Describe a test suite
describe() {
  CURRENT_SUITE="$1"
  echo -e "\n${BLUE}━━━ $1 ━━━${NC}"
}

# Assert two values are equal
assert_equals() {
  local expected="$1"
  local actual="$2"
  local message="${3:-assert_equals}"

  if [ "$expected" = "$actual" ]; then
    ((TESTS_PASSED++))
    echo -e "  ${GREEN}✓${NC} $message"
  else
    ((TESTS_FAILED++))
    echo -e "  ${RED}✗${NC} $message"
    echo -e "    expected: '${expected}'"
    echo -e "    actual:   '${actual}'"
  fi
}

# Assert value is not empty
assert_not_empty() {
  local value="$1"
  local message="${2:-assert_not_empty}"

  if [ -n "$value" ]; then
    ((TESTS_PASSED++))
    echo -e "  ${GREEN}✓${NC} $message"
  else
    ((TESTS_FAILED++))
    echo -e "  ${RED}✗${NC} $message (value is empty)"
  fi
}

# Assert command exits with zero status
assert_success() {
  local message="${1:-assert_success}"
  shift

  if "$@" >/dev/null 2>&1; then
    ((TESTS_PASSED++))
    echo -e "  ${GREEN}✓${NC} $message"
  else
    ((TESTS_FAILED++))
    echo -e "  ${RED}✗${NC} $message (exit code: $?)"
  fi
}

# Assert command exits with non-zero status
assert_failure() {
  local message="${1:-assert_failure}"
  shift

  if ! "$@" >/dev/null 2>&1; then
    ((TESTS_PASSED++))
    echo -e "  ${GREEN}✓${NC} $message"
  else
    ((TESTS_FAILED++))
    echo -e "  ${RED}✗${NC} $message (expected failure but got success)"
  fi
}

# Assert file exists
assert_file_exists() {
  local file="$1"
  local message="${2:-File exists: $1}"

  if [ -f "$file" ]; then
    ((TESTS_PASSED++))
    echo -e "  ${GREEN}✓${NC} $message"
  else
    ((TESTS_FAILED++))
    echo -e "  ${RED}✗${NC} $message (not found)"
  fi
}

# Assert file is executable
assert_executable() {
  local file="$1"
  local message="${2:-File executable: $1}"

  if [ -x "$file" ]; then
    ((TESTS_PASSED++))
    echo -e "  ${GREEN}✓${NC} $message"
  else
    ((TESTS_FAILED++))
    echo -e "  ${RED}✗${NC} $message (not executable)"
  fi
}

# Assert string contains substring
assert_contains() {
  local haystack="$1"
  local needle="$2"
  local message="${3:-assert_contains}"

  if echo "$haystack" | grep -q "$needle"; then
    ((TESTS_PASSED++))
    echo -e "  ${GREEN}✓${NC} $message"
  else
    ((TESTS_FAILED++))
    echo -e "  ${RED}✗${NC} $message (not found: '$needle')"
  fi
}

# Skip a test
skip_test() {
  local message="${1:-skipped}"
  ((TESTS_SKIPPED++))
  echo -e "  ${YELLOW}○${NC} $message (skipped)"
}

# Print final results
print_results() {
  local total=$((TESTS_PASSED + TESTS_FAILED + TESTS_SKIPPED))

  echo ""
  echo -e "${BLUE}━━━ Results ━━━${NC}"
  echo -e "  ${GREEN}Passed:  $TESTS_PASSED${NC}"
  [ $TESTS_FAILED -gt 0 ] && echo -e "  ${RED}Failed:  $TESTS_FAILED${NC}"
  [ $TESTS_SKIPPED -gt 0 ] && echo -e "  ${YELLOW}Skipped: $TESTS_SKIPPED${NC}"
  echo -e "  Total:   $total"
  echo ""

  if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}All tests passed! ✓${NC}"
    return 0
  else
    echo -e "${RED}$TESTS_FAILED test(s) failed! ✗${NC}"
    return 1
  fi
}
