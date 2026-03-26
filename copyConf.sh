#!/usr/bin/env bash
set -euo pipefail
echo "==> Copy configs"
rm -rf "$HOME/.config/nvim"
mkdir -p "$HOME/.config/nvim"
cp "$SCRIPT_DIR/init.lua" "$HOME/.config/nvim/"
cp -r "$SCRIPT_DIR/lua" "$HOME/.config/nvim/"
