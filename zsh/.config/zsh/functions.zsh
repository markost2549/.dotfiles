mkcd() {
    mkdir -p "$1" && cd "$1"
}

set-title() {
  print -Pn "\e]0;$1\a"
}