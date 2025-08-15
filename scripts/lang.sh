#!/usr/bin/env bash
set -euo pipefail
brew list asdf >/dev/null 2>&1 || brew install asdf
. "$(brew --prefix asdf)/libexec/asdf.sh"
asdf plugin add nodejs || true
asdf plugin add python || true
asdf install
