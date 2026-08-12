#!/usr/bin/env bash
#
# Bootstraps a new machine with this dotfiles repo.
# Usage: ./install.sh
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES=(zsh starship)
YARN_COMPLETIONS_DIR="$HOME/.antidote/github.com/g-plane/zsh-yarn-autocompletions"
YARN_COMPLETIONS_BIN="$YARN_COMPLETIONS_DIR/yarn-autocompletions"

info() { printf "\033[1;34m==>\033[0m %s\n" "$1"; }


install_packages_linux() {
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y zsh git stow curl cargo 
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Sy --noconfirm zsh git stow curl cargo 
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y zsh git stow curl cargo
  else
    echo "Unsupported package manager. Install zsh, git, and stow manually, then re-run this script." >&2
    exit 1
  fi

  if ! command -v starship >/dev/null 2>&1; then
    info "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
  fi
}

  install_yarn_completion(){
    if [[ ! -x "$YARN_COMPLETIONS_BIN" ]]; then
    printf '\nYarn Zsh autocompletion binary is missing.\n'
    read -r -p "Build it now with cargo? [y/N] " REPLY

  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    if ! command -v cargo >/dev/null 2>&1; then
      echo "Error: cargo is not installed."
      exit 1
    fi

    cd "$YARN_COMPLETIONS_DIR" || exit 1

    cargo build --release &&
      cp target/release/yarn-autocompletions "$YARN_COMPLETIONS_BIN" &&
      echo "Yarn autocompletion installed."
  else
    echo "Skipping Yarn autocompletion setup."
  fi
fi
}

info "Detecting OS..."
case "$(uname -s)" in
  Linux)
    install_packages_linux
    install_yarn_completion
    ;;
  *)
    echo "Unsupported OS: $(uname -s)" >&2
    exit 1
    ;;
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