export MANPAGER="/bin/sh -c 'col -b | vim -c '\''set ft=man nomod nolist signcolumn=no nonu'\'' -'"

if [ -x $(which vim) ]; then
  VI=$(which vim)
else
  VI=$(which vi)
fi

#complete -c vipath
vipath () {
        $VI $(which $1)
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

