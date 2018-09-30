if [[ -x /usr/lib/command-not-found ]] ; then
  function command_not_found_handler() {
    /usr/lib/command-not-found -- ${1+"$1"} && :
  }
fi
