# .dotfiles

These are my dotfiles. Take anything you want, but at your own risk.

It mainly targets macOS systems

## Pre Installation

### [Generating a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key)

```bash
$ ssh-keygen -t ed25519 -C "your_email@example.com"
```

### [Adding a new SSH key to your account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account#adding-a-new-ssh-key-to-your-account)

```bash
$ pbcopy < ~/.ssh/id_ed25519.pub
```

# Installation

## Preinstall

### On a sparkling fresh installation of macOS:

```bash
sudo softwareupdate -i -a
xcode-select --install
```

The Xcode Command Line Tools includes `git` and `make` (not available on stock macOS). Now there are two options:

## Clone the repository

```bash
git clone https://github.com/pramendra/dotfiles.git ~/.dotfiles
```

### alternative using curl

#### Clone dotfiles

```bash
bash -c "`curl -fsSL https://raw.githubusercontent.com/pramendra/dotfiles/master/remote-install.sh`"
```

Cloned to `~/.dotfiles`

## Install via make

```bash
$ cd ~/.dotfiles
$ make
```

# Features

```
brew, npm, oh-my-zsh
```

## Post-Installation

- `dotfiles dock` (set [Dock items](./macos/dock.sh))
- `dotfiles macos` (set [macOS defaults](./macos/defaults.sh))
- Mackup
  - Log in to Dropbox (and wait until synced)
  - `ln -s ~/.config/mackup/.mackup.cfg ~` (until [#632](https://github.com/lra/mackup/pull/632) is fixed)
  - `mackup restore`

## The `dotfiles` command

```bash
$ dotfiles help
Usage: dotfiles <command>

Commands:
    clean            Clean up caches (brew, npm, gem, rvm)
    dock             Apply macOS Dock settings
    edit             Open dotfiles in IDE (code) and Git GUI (stree)
    help             This help message
    macos            Apply macOS system defaults
    test             Run tests
    update           Update packages and pkg managers (OS, brew, npm, gem)
```

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).

# Doctor

## nvm not found

$ rm -rf ~/.nvm
$ make npm
