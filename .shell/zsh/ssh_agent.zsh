
export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock

function find_ssh_auth_sock() {
  emulate -L zsh
  setopt nonomatch

  sockets=(/tmp/keyring-*/ssh)
  # Check if lsof exists
  if command -v lsof &> /dev/null && (($#sockets)); then

    # Search for keyring sockets and use them if they're open
    for file in $sockets; do
      if lsof $file &> /dev/null; then
        export SSH_AUTH_SOCK=$file
        return
      fi
    done

  fi
}

find_ssh_auth_sock
