# dotfiles (fresh)

Idempotent macOS bootstrap.

❯ chmod +x scripts/bootstrap.sh
❯ chmod +x bin/dots
chmod +x macos/defaults.sh
chmod +x macos/dock.sh
chmod +x scripts/vscode.sh
chmod +x scripts/lang.sh

## Usage

```bash
make bootstrap   # brew + core tools
make link        # stow zsh, git, vscode...
make macos       # sensible defaults
make dock        # curated Dock
make update      # brew upgrade/cleanup
```
