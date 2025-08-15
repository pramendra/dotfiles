#!/usr/bin/env bash
set -euo pipefail
extexec() { code --install-extension "$1" || true; }
extexec esbenp.prettier-vscode
