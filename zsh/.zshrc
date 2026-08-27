# ~/.zshrc
# Managed by dotfiles repo — see ~/dotfiles/README.md

# ---- Path ----
export PATH="$HOME/.local/bin:$PATH"

# ---- History ----
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# ---- Basic options ----
setopt AUTO_CD
setopt CORRECT
setopt INTERACTIVE_COMMENTS

# ---- Completion ----
autoload -Uz compinit
# Only re-check the dump once a day for faster startup
if [[ -n "${ZDOTDIR:-$HOME}/.zcompdump"(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

zstyle ':completion:*' menu select

# ---- Antidote (zsh plugin manager) ----
ANTIDOTE_HOME="${ZDOTDIR:-$HOME}/.antidote"
if [[ ! -d "$ANTIDOTE_HOME" ]]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_HOME"
fi
source "$ANTIDOTE_HOME/antidote.zsh"

# Plugins are declared in ~/.zsh_plugins.txt and compiled to a static
# file for fast shell startup. The static file regenerates automatically
# whenever you edit the plugin list.
zsh_plugins="${ZDOTDIR:-$HOME}/.zsh_plugins.txt"
zsh_plugins_static="${ZDOTDIR:-$HOME}/.zsh_plugins.zsh"

if [[ ! -f "$zsh_plugins_static" || "$zsh_plugins" -nt "$zsh_plugins_static" ]]; then
  antidote bundle <"$zsh_plugins" >"$zsh_plugins_static"
fi
source "$zsh_plugins_static"

# ---- Starship prompt ----
eval "$(starship init zsh)"

if zoxide --version &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# ---- Aliases ----
[[ -f "$HOME/.config/zsh/aliases.zsh" ]] && source "$HOME/.config/zsh/aliases.zsh"
[[ -f "$HOME/.config/zsh/env.zsh" ]] && source "$HOME/.config/zsh/env.zsh"
[[ -f "$HOME/.config/zsh/functions.zsh" ]] && source "$HOME/.config/zsh/functions.zsh"


# ---- Editor ----
export EDITOR='vim'
export VISUAL='vim'

# ---- Machine-local overrides (never tracked in git) ----
[[ -f "$HOME/.config/zsh/local.zsh" ]] && source "$HOME/.config/zsh/local.zsh"
