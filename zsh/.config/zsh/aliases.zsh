alias ys='yarn start'
alias c='clear'
alias gmrem='git branch --merged | egrep -v '\''(^\*|master|dev|main)'\'' | xargs git branch -d'
alias gundo='git reset --soft HEAD~1'
alias killangular='sudo kill $(sudo lsof -t -i:4200)'

# ---------- git ----------
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"

# ---------- node ----------
alias ni="npm install"
alias nr="npm run"

# ---------- angular ----------
alias ngs="ng serve"
alias ngb="ng build"
alias ngt="ng test"

# ---------- nx ----------
alias nxs="nx serve"
alias nxb="nx build"
alias nxt="nx test"
alias nxl="nx lint"

# smart Nx run
nxr() {
  nx run "$1:$2"
}
# usage: nxr app build

# ---------- pnpm ----------
alias pi="pnpm install"
alias pr="pnpm run"

# ---------- misc ----------
alias ll="ls -lah"
alias ..="cd .."