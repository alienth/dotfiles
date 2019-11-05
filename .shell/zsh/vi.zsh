if [ command -v vim &>/dev/null ]; then
  VI=$(command -v vim)
else
  VI=$(command -v vi)
fi

#complete -c vipath
vipath () {
        $VI $(command -v $1)
}

vi () {
  if [ ! -d "$1" ] && [ ! -f "$1" ]; then
    $VI "$@";
    return
  fi

  if [[ ! -w "$1" && -f "$1" ]]; then
    echo -n "Not writable. sudo?:"
    local INPUT
    read -sq INPUT
    if [[ "$INPUT" == "y" ]]; then
      echo
      sudo $VI "$@";
      return
    fi
  fi
  $VI "$@";
}

man () {
  /usr/bin/man -w $* && vim -c ":Man $*" -c 'silent only'
}
