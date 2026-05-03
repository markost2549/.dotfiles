
export ZSH="$HOME/.oh-my-zsh"
export NX_TUI=false

ZSH_THEME="marko"
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

autoload -Uz compinit && compinit

source $HOME/.antidote/antidote.zsh
antidote load



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
