cd () {
  local DIR=${@[-1]}
  local STATUS
  builtin cd $*
  STATUS=$?
  if [[ $STATUS -ne 0 ]]; then
    if [[ ! -x "$DIR" ]] && [[ -d "$DIR" ]]; then
      echo "Cannot access dir. sudo? ";
      local INPUT
      read -qs INPUT
      if [[ $INPUT = "y" ]]; then
        sudo /bin/sh -c "cd $*; exec zsh"
        return
      else
        return $STATUS
      fi
    fi
  fi
}

# This hook is called by zsh whenever the CWD changes.
chpwd () {
  ls
}
