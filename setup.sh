#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/ThePrimeagen/init.lua.git"
NVIM_CONFIG_DIR="${HOME}/.config/nvim"
BACKUP_SUFFIX="$(date +%Y%m%d-%H%M%S)"

log() {
  printf "\n==> %s\n" "$1"
}

has_pkg() {
  dpkg -s "$1" >/dev/null 2>&1
}

append_if_missing() {
  local file="$1"
  local line="$2"

  touch "$file"
  if ! grep -Fqx "$line" "$file"; then
    printf "\n%s\n" "$line" >> "$file"
  fi
}

log "Updating apt index"
sudo apt update

log "Removing Vim if installed"
if has_pkg vim; then
  sudo apt remove -y vim
else
  echo "vim package not installed, skipping."
fi

log "Installing Neovim and common prerequisites"
sudo apt install -y \
  neovim \
  git \
  curl \
  wget \
  unzip \
  ripgrep \
  fd-find \
  xclip \
  python3 \
  python3-pip \
  gcc \
  g++ \
  make

log "Creating /usr/local/bin/vim wrapper -> nvim"
sudo tee /usr/local/bin/vim >/dev/null <<'EOF'
#!/usr/bin/env bash
exec nvim "$@"
EOF
sudo chmod +x /usr/local/bin/vim

log "Adding vim -> nvim alias to shell configs"
append_if_missing "${HOME}/.bashrc" 'alias vim="nvim"'
append_if_missing "${HOME}/.zshrc" 'alias vim="nvim"'

log "Backing up existing Neovim config if present"
if [ -e "${NVIM_CONFIG_DIR}" ]; then
  mv "${NVIM_CONFIG_DIR}" "${NVIM_CONFIG_DIR}.bak-${BACKUP_SUFFIX}"
  echo "Backed up to ${NVIM_CONFIG_DIR}.bak-${BACKUP_SUFFIX}"
fi

log "Cloning ThePrimeagen config"
mkdir -p "${HOME}/.config"
git clone "${REPO_URL}" "${NVIM_CONFIG_DIR}"

log "Bootstrapping plugins once"
nvim --headless "+Lazy! sync" +qa || true

log "Done"
echo
echo "Next steps:"
echo "  1. Open a new shell, or run: source ~/.bashrc"
echo "  2. Start Neovim with: vim"
echo "  3. Your config lives at: ${NVIM_CONFIG_DIR}"
