#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ANTIDOTE_DIR="$HOME/.local/share/antidote"

log() {
    printf '\n==> %s\n' "$1"
}

install_packages() {
    log "Installing packages"

    if command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y zsh git stow starship

    elif command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update
        sudo apt-get install -y zsh git stow curl

        if ! command -v starship >/dev/null 2>&1; then
            curl -sS https://starship.rs/install.sh | sh
        fi

    elif command -v brew >/dev/null 2>&1; then
        brew install zsh git stow starship

    else
        echo "Unsupported package manager."
        exit 1
    fi
}

install_antidote() {
    log "Installing Antidote"

    if [[ -d "$ANTIDOTE_DIR/.git" ]]; then
        echo "Antidote already installed."
        return
    fi

    mkdir -p "$(dirname "$ANTIDOTE_DIR")"

    git clone --depth=1 \
        https://github.com/mattmc3/antidote.git \
        "$ANTIDOTE_DIR"
}

stow_dotfiles() {
    log "Stowing dotfiles"

    cd "$DOTFILES_DIR"

    stow --restow zsh
    stow --restow starship
}

set_default_shell() {
    log "Setting Zsh as default shell"

    local zsh_path
    zsh_path="$(command -v zsh)"

    if [[ "$SHELL" != "$zsh_path" ]]; then
        chsh -s "$zsh_path"
    fi
}

main() {
    install_packages
    install_antidote
    stow_dotfiles
    set_default_shell

    log "Setup complete"

    echo
    echo "Run:"
    echo
    echo "    exec zsh"
}

main "$@"