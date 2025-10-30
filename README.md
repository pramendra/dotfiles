# Dotfiles

Personal dotfiles for macOS development environment. Idempotent bootstrap with Homebrew, Stow, and custom scripts.

## Features

- **Package Management**: Brewfile for Homebrew packages, Npmfile for global npm packages.
- **Configuration Linking**: Uses GNU Stow for symlinking configs (zsh, git, vscode, etc.).
- **macOS Customization**: Defaults and dock settings.
- **Automation**: Makefile targets for setup, updates, and status checks.

## Prerequisites

- macOS (tested on Ventura+)
- Xcode Command Line Tools: `xcode-select --install`
- Git: `git --version`

## Quick Setup (New Machine)

```bash
git clone https://github.com/pramendra/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make all
```

This runs: bootstrap → link → update → macos → dock → npm → ssh.

## Manual Setup

1. **Bootstrap**: `./scripts/bootstrap.sh` (installs Homebrew, taps, etc.)
2. **Link Configs**: `./bin/dots link` (symlinks with Stow)
3. **Install Packages**: `brew bundle --file="$(pwd)/Brewfile"`
4. **macOS Defaults**: `./macos/defaults.sh`
5. **Global NPM**: `npm install -g $(grep -v '^#' Npmfile | tr '\n' ' ')`

## Makefile Targets

- `make bootstrap`: Install Homebrew and basics.
- `make link`: Symlink configs.
- `make brew`: Install from Brewfile.
- `make macos`: Apply macOS defaults.
- `make update`: Update Homebrew packages.
- `make doctor`: Check tool status.
- `make all`: Full setup.

## Managing Node Versions with NVM

NVM is installed via Brewfile. To install and use the latest Node/npm:

```bash
# After setup, ensure NVM is loaded (added to ~/.zshenv)
nvm install node  # Latest Node
nvm use node
nvm alias default node
```

Verify: `node --version && npm --version`

## Troubleshooting

- **Stow conflicts**: Run `./bin/dots unlink` to remove links.
- **Brew issues**: `brew doctor` and `brew update`.
- **NVM not found**: Reload shell with `exec zsh`.
- **Permissions**: Use `sudo` for system changes if needed.

## Structure

```
.dotfiles/
├── Brewfile          # Homebrew packages
├── Makefile          # Automation
├── Npmfile           # Global npm packages
├── bin/dots          # Symlinking script
├── git/              # Git config
├── macos/            # macOS settings
├── scripts/          # Setup scripts
├── vscode/           # VS Code config
└── zsh/              # Zsh config
```

## Contributing

Fork, make changes, test with `make doctor`, and PR.

## Usage

```bash
make bootstrap   # brew + core tools
make link        # stow zsh, git, vscode...
make macos       # sensible defaults
make dock        # curated Dock
make update      # brew upgrade/cleanup
```

## GitHub SSH Setup

1. To generate a new SSH key and configure your SSH agent for GitHub, run:

```bash
make ssh
```

2. Copy public key into clipboard:

```bash
pbcopy < ~/.ssh/id_ed25519.pub
```

3. Go to [GitHub SSH keys settings](https://github.com/settings/keys).

4. Give your key a descriptive title (e.g., "MacBook Air 2025").

5. Test your connection:

```bash
ssh -T git@github.com
```
