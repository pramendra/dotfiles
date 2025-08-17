SHELL := /bin/bash
HOMEBREW := /opt/homebrew/bin/brew
.PHONY: bootstrap link unlink update macos dock

# Check if Homebrew exists and set PATH
ifeq ($(shell which brew),)
  BREW_INIT := eval "$$(/opt/homebrew/bin/brew shellenv)"
else
  BREW_INIT := 
endif

bootstrap: ; ./scripts/bootstrap.sh
link:      ; ./bin/dots link
unlink:    ; ./bin/dots unlink
update:
    $(BREW_INIT) brew update && \
    brew upgrade && \
    brew cleanup
macos:     ; ./macos/defaults.sh
dock:      ; ./macos/dock.sh
npm:			 ; ./scripts/npm_globals.sh
ssh:			 ; ./scripts/ssh-setup.sh
all: 			 ; bootstrap link update macos dock npm ssh