#!/usr/bin/env bash
set -euo pipefail

NPMFILE="$(dirname "$0")/../npmfile"

# Check requirements
if ! command -v npm >/dev/null 2>&1; then
    echo "Error: npm is not installed"
    exit 1
fi

if [ ! -f "$NPMFILE" ]; then
    echo "Error: npmfile not found at $NPMFILE"
    exit 1
fi

echo "📦 Installing global NPM packages from npmfile..."

# Read npmfile and install packages
while read -r line; do
    # Skip empty lines, comments, and section headers
    if [[ -n "$line" && ! "$line" =~ ^[[:space:]]*# ]]; then
        # Extract package name (everything before #)
        package=$(echo "$line" | sed 's/[[:space:]]*#.*$//' | xargs)
        if [ -n "$package" ]; then
            echo "Installing $package..."
            npm install -g "$package"
        fi
    fi
done < "$NPMFILE"

echo "✨ NPM global packages installation complete!"