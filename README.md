# Pramendra's .dotfiles

```
Note: These are my dotfiles. Take anything you want, but at your own risk.
This repository mainly targets macOS systems.
```

## Setup new device

#### Copy the item configuraiton

```bash
$ cp config/iterm/* ~/Library/Preferences/
```

```bash
$ git clone https://github.com/pramendra/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ make
```

```bash
$ dotfiles dock #./bin/dotfiles dock
$ dotfiles macos
```

## Hot fix

### fix symbolic link

```bash
make unlink && make link
```

### Update lastest change

```bash
$ cd ~/.dotfiles
$ git pull
$ make
```

### npm ERR! code ENOTEMPTY

```$
$ rm -rf /opt/homebrew/lib/node_modules/npm
```

---

## Pre Installation

### [Generating a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key)

```bash
$ ssh-keygen -t ed25519 -C "your_email@example.com"
```

### [Adding a new SSH key to your account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account#adding-a-new-ssh-key-to-your-account)

```bash
$ gh auth login
```

Copy ssh public key

```bash
$ pbcopy < ~/.ssh/id_ed25519.pub
```

### On a sparkling fresh installation of macOS:

```bash
sudo softwareupdate -i -a
xcode-select --install
```

Note: The Xcode Command Line Tools includes `git` and `make` (not available on stock macOS). Now there are two options:

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

# Features

```
brew, npm, oh-my-zsh
```

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).

## D0ctor

### nvm not found

$ rm -rf ~/.nvm
$ make npm

### "login: /usr/local/bin/bash: No such file or directory [Process completed]"

in Sonoma:

Open Terminal.
Choose Terminal > Settings, then click General.
Next to “Shells open with,” select “Command (complete path),” then enter the complete path to the shell you want to use1.

chsh -s /bin/zsh
