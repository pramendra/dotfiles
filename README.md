# Dotfiles

VPoE-grade dotfiles for fast Mac setup. Shell startup: **0.07s**

## Quick Start

```bash
git clone https://github.com/pramendra/dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh
```

## Structure

```
~/.dotfiles/
├── Brewfile          # All packages (brew bundle)
├── install.sh        # One-command new Mac setup
├── apply.sh          # Re-apply settings
├── config/           # git, vscode, starship
├── macos/            # System defaults
├── shell/.zshrc      # Shell config
└── bin/              # dotfiles, maintain, deepclean
```

## Commands

```bash
dotfiles update    # Update brew, npm
dotfiles clean     # Clean caches
dotfiles macos     # Apply system defaults
dotfiles edit      # Open in VSCode

silence            # Disable background agents
maintain           # Weekly maintenance
deepclean          # Deep system clean
freemem            # Purge RAM
```

## Manual Install

```bash
brew bundle --file=~/.dotfiles/Brewfile
source ~/.dotfiles/macos/defaults.sh
```

## License

MIT
