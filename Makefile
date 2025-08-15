SHELL := /bin/bash
.PHONY: bootstrap link unlink update macos dock

bootstrap: ; ./scripts/bootstrap.sh
link:      ; ./bin/dots link
unlink:    ; ./bin/dots unlink
update:    ; brew update && brew upgrade && brew cleanup

macos:     ; ./macos/defaults.sh
dock:      ; ./macos/dock.sh
npm:			 ; ./scripts/npm_globals.sh
ssh:			 ; ./scripts/ssh-setup.sh
all: 			 ; bootstrap link update macos dock npm ssh