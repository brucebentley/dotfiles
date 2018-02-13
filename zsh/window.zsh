#
# window.zsh
#

# Sets The Window Title Nicely No Matter Where You Are.
#   @SOURCE:    http://dotfiles.org/~_why/.zshrc
function title() {
  # Escape '%' Chars In $1, Make Nonprintables Visible.
  a=${(V)1//\%/\%\%}

  # Truncate Command, And Join Lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")

  case $TERM in
  screen)
    print -Pn "\ek$a:$3\e\\"    # SCREEN TITLE (IN ^A")
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$2\a"       # PLAIN XTERM TITLE ($3 FOR pwd)
    ;;
  esac
}

