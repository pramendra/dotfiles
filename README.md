# .dotfiles

## Installation

On a sparkling fresh installation of macOS:

```bash
sudo softwareupdate -i -a
xcode-select --install
```

The Xcode Command Line Tools includes `git` and `make` (not available on stock macOS). Now there are two options:


### Install Pre-Requirements

#### [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh)

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

#### Clone following repo:

```bash
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
```

#### Symlink spaceship.zsh-theme to your oh-my-zsh custom themes directory:

```bash
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```

#### Update Theme in ~/.zshrc
```
ZSH_THEME="spaceship" 
```
Reload source
```bash
source ~/.zshrc
```

### Install pramendra dotfiles

#### Clone dotfiles
```bash
bash -c "`curl -fsSL https://raw.githubusercontent.com/pramendra/dotfiles/master/remote-install.sh`"
```
Cloned to `~/.dotfiles`

##### Alternatively, clone manually into the desired location:

```bash
git clone https://github.com/pramendra/dotfiles.git ~/.dotfiles
```

Use the [Makefile](./Makefile) to install everything [listed above](#package-overview), and symlink [runcom](./runcom)
and [config](./config) (using [stow](https://www.gnu.org/software/stow/)):

#### Install dotfiles
```bash
cd ~/.dotfiles
make
```
##### debug command not found: brew
```
- Run these two commands in your terminal to add Homebrew to your PATH:
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/pramendra/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
```

The installation process in the Makefile is tested on every push and every week in this
[GitHub Action](https://github.com/pramendra/dotfiles/actions).

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

## Customize

You can put your custom settings, such as Git credentials in the `system/.custom` file which will be sourced from
`.bash_profile` automatically. This file is in `.gitignore`.

Alternatively, you can have an additional, personal dotfiles repo at `~/.extra`. The runcom `.bash_profile` sources all
`~/.extra/runcom/*.sh` files.

## Additional Resources

- [Awesome Dotfiles](https://github.com/pramendra/awesome-dotfiles)
- [Homebrew](https://brew.sh)
- [Homebrew Cask](https://github.com/Homebrew/homebrew-cask)
- [Bash prompt](https://wiki.archlinux.org/index.php/Color_Bash_Prompt)
- [Solarized Color Theme for GNU ls](https://github.com/seebi/dircolors-solarized)

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).
