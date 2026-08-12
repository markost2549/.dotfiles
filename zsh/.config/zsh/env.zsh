export NX_TUI=false
export NODE_OPTIONS="--max-old-space-size=4096"

# NVM (lazy-ish load)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export STARSHIP_CONFIG=~/.config/gruvbox-rainbow.toml
# export STARSHIP_CONFIG=~/.config/no-nerd-font.toml
# export STARSHIP_CONFIG=~/.config/starship.toml