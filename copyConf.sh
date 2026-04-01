#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "==> Copy configs"
rm -rf "$HOME/.config/nvim"
mkdir -p "$HOME/.config/nvim"
cp "$SCRIPT_DIR/init.lua" "$HOME/.config/nvim/"
cp -r "$SCRIPT_DIR/lua" "$HOME/.config/nvim/"
