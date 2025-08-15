# dotfiles (fresh)

Idempotent macOS bootstrap.

chmod +x scripts/bootstrap.sh
chmod +x bin/dots
chmod +x macos/defaults.sh
chmod +x macos/dock.sh
chmod +x scripts/vscode.sh
chmod +x scripts/lang.sh
chmod +x scripts/npm_globals.sh
chmod +x scripts/ssh-setup.sh

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
