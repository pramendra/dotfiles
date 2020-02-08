# Pramendra's dotfiles repository

## Init dotfiles 
```
$ mkdir ~/.dotfiles
$ cd ~/.dotfiles
$ git init
$ echo "# Pramendra's dotfiles repository" > README.md
$ git add README.md
$ git commit -m "Added initial README."
$ git push -u origin master
```

## global ignore (.gitignore_global)

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