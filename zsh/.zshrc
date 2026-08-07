# Antidote
source "$HOME/.local/share/antidote/antidote.zsh"

# Zsh completion system
autoload -Uz compinit
compinit

# Plugins
antidote load "$HOME/.zsh_plugins.txt"

# Starship
eval "$(starship init zsh)"