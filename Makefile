SHELL = /bin/zsh # SHELL = /bin/bash
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
OS := $(shell bin/is-supported bin/is-macos macos linux)
PATH := $(DOTFILES_DIR)/bin:$(PATH)
NVM_DIR := $(HOME)/.nvm
export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)
export ACCEPT_EULA=Y
VSCODE_CONFIG_HOME_MACOS := $(HOME)/Library/Application\ Support/Code/User
# VSCODE_CONFIG_HOME_LINUX := $(HOME)/.config/Code/User

.PHONY: test

all: $(OS)

macos: sudo core-macos packages link

linux: core-linux link

core-macos: brew git npm ruby #core-macos: brew bash git npm ruby

core-linux:
	apt-get update
	apt-get upgrade -y
	apt-get dist-upgrade -f

stow-macos: brew
	is-executable stow || brew install stow

stow-linux: core-linux
	is-executable stow || apt-get -y install stow

sudo:
ifndef GITHUB_ACTION
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
endif

packages: brew-packages cask-apps node-packages

link: stow-$(OS)
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	mkdir -p $(XDG_CONFIG_HOME)
	stow -t $(HOME) runcom
	stow -t $(XDG_CONFIG_HOME) config
	ln -s $(STOW_DIR)/.config/config $(HOME)/.gitconfig  
	for FILE in $$(\ls -A VSCode); do if [ -f $(VSCODE_CONFIG_HOME_MACOS)/$$FILE -a ! -h $(VSCODE_CONFIG_HOME_MACOS)/$$FILE ]; then \
		mv -v $(VSCODE_CONFIG_HOME_MACOS)/$$FILE{,.bak}; fi; done
	stow -v -t $(VSCODE_CONFIG_HOME_MACOS) VSCode

unlink: stow-$(OS)
	stow --delete -t $(HOME) runcom
	stow --delete -t $(XDG_CONFIG_HOME) config
	rm -rf $(HOME)/.gitconfig
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then \
		mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done
	# todo: unlink VSCode

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash	

# bash: BASH=/usr/local/bin/bash
# bash: SHELLS=/private/etc/shells
# bash: brew

zsh: ZSH=/usr/local/bin/zsh
zsh: SHELLS=/private/etc/shells
zsh: brew
	if ! grep -q $(ZSH) $(SHELLS); then brew install zsh zsh-completion pcre && sudo append $(ZSH) $(SHELLS) && chsh -s $(ZSH); fi

ifdef GITHUB_ACTION
	if ! grep -q $(BASH) $(SHELLS); then \
		brew install bash bash-completion@2 pcre && \
		sudo append $(BASH) $(SHELLS) && \
		sudo chsh -s $(BASH); \
	fi
else
	if ! grep -q $(BASH) $(SHELLS); then \
		brew install bash bash-completion@2 pcre && \
		sudo append $(BASH) $(SHELLS) && \
		chsh -s $(BASH); \
	fi
endif

git: brew
	brew install git git-extras

npm:
	if ! [ -d $(NVM_DIR)/.git ]; then git clone https://github.com/creationix/nvm.git $(NVM_DIR); fi
	. $(NVM_DIR)/nvm.sh; nvm install --lts

ruby: brew
	brew install ruby
	is-executable rvm || gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys | bash
	is-executable rvm || curl -sSL https://get.rvm.io | bash -s stable --rails

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile

cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true
	defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
	for EXT in $$(cat install/Codefile); do code --install-extension $$EXT; done
	xattr -d -r com.apple.quarantine ~/Library/QuickLook
	# . "$(shell brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/install.sh"

node-packages: npm
	. $(NVM_DIR)/nvm.sh; npm install -g $(shell cat install/npmfile)

test:
	. $(NVM_DIR)/nvm.sh; bats test
