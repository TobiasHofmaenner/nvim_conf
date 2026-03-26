#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TMP_DIR="$(mktemp -d)"
ARCHIVE="nvim-linux-x86_64.tar.gz"
URL="https://github.com/neovim/neovim/releases/latest/download/${ARCHIVE}"
INSTALL_PARENT="/opt"
INSTALL_DIR="${INSTALL_PARENT}/nvim-linux-x86_64"
SYMLINK="/usr/local/bin/nvim"

cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

echo "==> Installing dependencies"
sudo apt update
sudo apt install -y curl tar npm nodejs

echo "==> Downloading latest Neovim release"
cd "$TMP_DIR"
curl -fL -o "$ARCHIVE" "$URL"

echo "==> Removing previous install"
sudo rm -rf "$INSTALL_DIR"

echo "==> Extracting to ${INSTALL_PARENT}"
sudo tar -C "$INSTALL_PARENT" -xzf "$ARCHIVE"

echo "==> Updating symlink ${SYMLINK}"
sudo ln -sf "${INSTALL_DIR}/bin/nvim" "$SYMLINK"

echo "==> Verifying install"
nvim --version | head -n 3

echo "==> Copy configs"
rm -rf "$HOME/.config/nvim"
mkdir -p "$HOME/.config/nvim"
cp "$SCRIPT_DIR/init.lua" "$HOME/.config/nvim/"
cp -r "$SCRIPT_DIR/lua" "$HOME/.config/nvim/"

echo
echo "Installed Neovim from:"
echo "  $URL"
echo "Binary:"
echo "  $SYMLINK"
