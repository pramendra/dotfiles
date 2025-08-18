SHELL := /bin/bash

.PHONY: bootstrap link unlink update macos dock npm ssh zsh all

# Detect Homebrew install path
BREW_PATH := $(shell command -v brew 2>/dev/null)
ifeq ($(BREW_PATH),)
    BREW_CMD := eval "$$(/opt/homebrew/bin/brew shellenv)" && brew
else
    BREW_CMD := brew
endif

### ───────────────────────────────
### High-level provisioning targets
### ───────────────────────────────

all: bootstrap link update macos dock npm ssh
	@echo "🎉 All provisioning complete! Run 'exec zsh' to reload."

bootstrap:
	@echo "🚀 Running bootstrap..."
	./scripts/bootstrap.sh

link:
	@echo "🔗 Linking dotfiles with stow..."
	./bin/dots link
	@echo "run 'exec zsh' to reload."

unlink:
	@echo "🗑️ Unlinking dotfiles..."
	./bin/dots unlink

update:
	@echo "📦 Updating Homebrew packages..."
	$(BREW_CMD) update && $(BREW_CMD) upgrade && $(BREW_CMD) cleanup

zsh: link
	@echo "💻 Starting new Zsh shell..."
	# ~/.zshrc is managed by stow, don’t overwrite it
	exec zsh -l

macos:
	@echo "🛠️ Applying macOS defaults..."
	./macos/defaults.sh

dock:
	@echo "🛠️ Setting up Dock preferences..."
	./macos/dock.sh

npm:
	@echo "📦 Installing global npm packages..."
	./scripts/npm_globals.sh

ssh:
	@echo "🔑 Setting up SSH config..."
	./scripts/ssh-setup.sh
