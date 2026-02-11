#!/usr/bin/env bash
#
# Tests for dotfiles structure and integrity
#

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
source "$DOTFILES_DIR/test/test-helper.sh"

describe "Repository Structure"

# Core files
assert_file_exists "$DOTFILES_DIR/install.sh" "install.sh exists"
assert_file_exists "$DOTFILES_DIR/apply.sh" "apply.sh exists"
assert_file_exists "$DOTFILES_DIR/Brewfile" "Brewfile exists"
assert_file_exists "$DOTFILES_DIR/README.md" "README.md exists"

describe "Library Files"

for lib in common.sh process.sh launchctl.sh browser.sh; do
  assert_file_exists "$DOTFILES_DIR/lib/$lib" "lib/$lib exists"
done
assert_file_exists "$DOTFILES_DIR/lib/README.md" "lib/README.md exists"

describe "Shell Modules"

assert_file_exists "$DOTFILES_DIR/shell/.zshrc" ".zshrc exists"
assert_file_exists "$DOTFILES_DIR/shell/aliases.zsh" "aliases.zsh exists"
assert_file_exists "$DOTFILES_DIR/shell/browser.zsh" "browser.zsh exists"
assert_file_exists "$DOTFILES_DIR/shell/functions.zsh" "functions.zsh exists"
assert_file_exists "$DOTFILES_DIR/shell/tools.zsh" "tools.zsh exists"

describe "Bin Scripts"

for script in dotfiles silence killmem maintain deepclean tame; do
  assert_file_exists "$DOTFILES_DIR/bin/$script" "bin/$script exists"
  assert_executable "$DOTFILES_DIR/bin/$script" "bin/$script is executable"
done

describe "macOS Scripts"

for script in defaults.sh memory-optimize.sh gpu-status.sh browser-cleanup.sh; do
  assert_file_exists "$DOTFILES_DIR/macos/$script" "macos/$script exists"
done

describe "Config Files"

assert_file_exists "$DOTFILES_DIR/config/starship.toml" "starship.toml exists"

describe "Shebang Consistency"

# All bin/ scripts should use #!/usr/bin/env bash
for script in "$DOTFILES_DIR"/bin/*; do
  [ -f "$script" ] || continue
  shebang=$(head -1 "$script")
  assert_equals "#!/usr/bin/env bash" "$shebang" "$(basename $script) uses env bash shebang"
done

describe "Shell Module Loading"

# Check that .zshrc references all modules
zshrc_content=$(cat "$DOTFILES_DIR/shell/.zshrc")
assert_contains "$zshrc_content" "aliases" ".zshrc loads aliases module"
assert_contains "$zshrc_content" "browser" ".zshrc loads browser module"
assert_contains "$zshrc_content" "functions" ".zshrc loads functions module"
assert_contains "$zshrc_content" "tools" ".zshrc loads tools module"

describe "Library Source Chains"

# process.sh should source common.sh
content=$(cat "$DOTFILES_DIR/lib/process.sh")
assert_contains "$content" "common.sh" "process.sh sources common.sh"

# launchctl.sh should source common.sh
content=$(cat "$DOTFILES_DIR/lib/launchctl.sh")
assert_contains "$content" "common.sh" "launchctl.sh sources common.sh"

# browser.sh should source common.sh and process.sh
content=$(cat "$DOTFILES_DIR/lib/browser.sh")
assert_contains "$content" "common.sh" "browser.sh sources common.sh"
assert_contains "$content" "process.sh" "browser.sh sources process.sh"

print_results
