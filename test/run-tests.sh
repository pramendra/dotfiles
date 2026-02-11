#!/usr/bin/env bash
#
# Dotfiles Test Runner
# Runs all test files matching test/test-*.sh
#
# Usage: ./test/run-tests.sh
#        dotfiles test
#

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
TEST_DIR="$DOTFILES_DIR/test"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔══════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Dotfiles Test Suite               ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════╝${NC}"

total_passed=0
total_failed=0
total_skipped=0
suite_count=0

for test_file in "$TEST_DIR"/test-*.sh; do
  [ -f "$test_file" ] || continue
  # Skip the helper library
  [[ "$(basename "$test_file")" == "test-helper.sh" ]] && continue
  ((suite_count++))

  echo -e "\n${BLUE}▶ Running: $(basename "$test_file")${NC}"

  # Run test and capture output
  output=$(bash "$test_file" 2>&1)
  exit_code=$?

  echo "$output"

  # Parse results from output
  passed=$(echo "$output" | grep -c "✓" || true)
  failed=$(echo "$output" | grep -c "✗" || true)
  skipped=$(echo "$output" | grep -c "○" || true)

  total_passed=$((total_passed + passed))
  total_failed=$((total_failed + failed))
  total_skipped=$((total_skipped + skipped))
done

# Final summary
total=$((total_passed + total_failed + total_skipped))

echo ""
echo -e "${BLUE}╔══════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Final Summary                     ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════╝${NC}"
echo ""
echo -e "  Suites:  $suite_count"
echo -e "  ${GREEN}Passed:  $total_passed${NC}"
[ $total_failed -gt 0 ] && echo -e "  ${RED}Failed:  $total_failed${NC}"
[ $total_skipped -gt 0 ] && echo -e "  ${BLUE}Skipped: $total_skipped${NC}"
echo -e "  Total:   $total"
echo ""

if [ $total_failed -eq 0 ]; then
  echo -e "${GREEN}✓ All tests passed!${NC}"
  exit 0
else
  echo -e "${RED}✗ $total_failed test(s) failed!${NC}"
  exit 1
fi
