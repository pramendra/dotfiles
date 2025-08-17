SHELL := /bin/bash

.PHONY: bootstrap link unlink update macos dock npm ssh all

# Check if brew is available and set initialization command accordingly
BREW_PATH := $(shell command -v brew 2>/dev/null)

ifeq ($(BREW_PATH),)
    # Homebrew not found in PATH, need to initialize it
    BREW_CMD := eval "$(/opt/homebrew/bin/brew shellenv)" && brew
else
    # Homebrew already in PATH
    BREW_CMD := brew
endif

bootstrap:
	./scripts/bootstrap.sh

link:
	./bin/dots link

unlink:
	./bin/dots unlink

update:
	$(BREW_CMD) update && $(BREW_CMD) upgrade && $(BREW_CMD) cleanup

macos:
	./macos/defaults.sh

dock:
	./macos/dock.sh

npm:
	./scripts/npm_globals.sh

ssh:
	./scripts/ssh-setup.sh

all: bootstrap link update macos dock npm ssh
