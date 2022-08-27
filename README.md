# .dotfiles

These are my dotfiles. Take anything you want, but at your own risk.

It mainly targets macOS systems, but it works on at least Ubuntu as well.

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
