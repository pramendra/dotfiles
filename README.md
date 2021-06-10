# Pramendra's dotfiles repository

## Seup Dev Environment

### Install default app  
```
$ git clone https://github.com/pramendra/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ chmod +x install.sh
$ ./install.sh
```

### Setup Github
```
$ ssh-keygen -t rsa -b 4096 -C "pramendra@example.com"
$ pbcopy < ~/.ssh/id_rsa.pub
```
Paste key 
https://github.com/settings/gpg/new
Ref
https://help.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account


## How to setup dotfiles

### Create git repo 
```
$ mkdir ~/.dotfiles
$ cd ~/.dotfiles
$ git init
$ echo "# Pramendra's dotfiles repository" > README.md
$ git add README.md
$ git commit -m "Added initial README."
$ git push -u origin master
```

### Add global ignore (.gitignore_global)
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

