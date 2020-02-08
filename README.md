# Pramendra's dotfiles repository

## setup github
```
$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
$ pbcopy < ~/.ssh/id_rsa.pub
```
https://help.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account

## Install 
```
$ git clone git@github.com:pramendra/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ sh install.sh
```

## How to
### Init dotfiles 
```
$ mkdir ~/.dotfiles
$ cd ~/.dotfiles
$ git init
$ echo "# Pramendra's dotfiles repository" > README.md
$ git add README.md
$ git commit -m "Added initial README."
$ git push -u origin master
```

### global ignore (.gitignore_global)

```
*~
._*
.DS_Store
.idea
.vscode
node_modules
bower_components
npm-debug.log
```
### setup brew & zsh, macos
* check config .macos, Brewfile, .zshrc, mackup.cfg files

### setup zsh, aliash
