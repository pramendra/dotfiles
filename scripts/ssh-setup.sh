#!/usr/bin/env bash

EMAIL=$(git config --global user.email)

# 1. Generate SSH key (ed25519)
ssh-keygen -t ed25519 -C "$EMAIL" -f ~/.ssh/id_ed25519 -N "" <<< y 2>/dev/null

# 2. Start the agent and add key to Keychain (macOS Ventura+)
ssh-add --apple-use-keychain ~/.ssh/id_ed25519 2>/dev/null || \
  ssh-add -K ~/.ssh/id_ed25519 2>/dev/null || \
  ssh-add ~/.ssh/id_ed25519

# 3. Ensure SSH config for Keychain and this key
mkdir -p ~/.ssh && chmod 700 ~/.ssh
cat > ~/.ssh/config <<'EOF'
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOF
chmod 600 ~/.ssh/config