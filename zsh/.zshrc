# ---------- performance ----------
export ZSH_DISABLE_COMPFIX=true

# ---------- completion ----------
autoload -Uz compinit
compinit -C

# ---------- antidote ----------
source $HOME/.antidote/antidote.zsh
antidote load

# ---------- prompt (starship) ----------
eval "$(starship init zsh)"

# ---------- env ----------
source ~/.dotfiles/zsh/env.zsh

# ---------- aliases ----------
source ~/.dotfiles/zsh/aliases.zsh

# --------- nvm ----------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
