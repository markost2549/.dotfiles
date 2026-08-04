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

