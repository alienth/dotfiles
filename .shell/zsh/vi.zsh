if command -v nvim &>/dev/null; then
  export VISUAL=$(command -v nvim)
elif command -v vim &>/dev/null; then
  export VISUAL=$(command -v vim)
else
  export VISUAL=$(command -v vi)
fi

#complete -c vipath
vipath () {
        $VISUAL $(command -v $1)
}

vi () {
  if [ ! -d "$1" ] && [ ! -f "$1" ]; then
    $VISUAL "$@";
    return
  fi

  if [[ ! -w "$1" && -f "$1" ]]; then
    echo -n "Not writable. sudo?:"
    local INPUT
    read -sq INPUT
    if [[ "$INPUT" == "y" ]]; then
      echo
      sudo $VISUAL "$@";
      return
    fi
  fi
  $VISUAL "$@";
}

alias vim=vi

man () {
  /usr/bin/man -w $* && $VISUAL -c ":Man $*" -c 'silent only'
}
