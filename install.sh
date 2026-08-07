#!/usr/bin/env bash
#
# Bootstraps a new machine with this dotfiles repo.
# Usage: ./install.sh
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES=(zsh starship git)

info() { printf "\033[1;34m==>\033[0m %s\n" "$1"; }

install_packages_macos() {
  if ! command -v brew >/dev/null 2>&1; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
  fi
  info "Installing packages via Homebrew..."
  brew install zsh git stow starship
}

install_packages_linux() {
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y zsh git stow curl
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Sy --noconfirm zsh git stow curl
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y zsh git stow curl
  else
    echo "Unsupported package manager. Install zsh, git, and stow manually, then re-run this script." >&2
    exit 1
  fi

  if ! command -v starship >/dev/null 2>&1; then
    info "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
  fi
}

info "Detecting OS..."
case "$(uname -s)" in
  Darwin) install_packages_macos ;;
  Linux)  install_packages_linux ;;
  *) echo "Unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac

info "Symlinking dotfiles with GNU Stow: ${PACKAGES[*]}"
cd "$DOTFILES_DIR"
for pkg in "${PACKAGES[@]}"; do
  stow --restow --target="$HOME" "$pkg"
done

if [[ "$SHELL" != *zsh* ]]; then
  info "Setting zsh as your default shell (you may be asked for your password)..."
  chsh -s "$(command -v zsh)"
fi

info "Done! Open a new terminal (or run 'exec zsh') to see it in action."
info "Antidote will clone itself and install plugins automatically on first launch."