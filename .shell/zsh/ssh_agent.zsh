
export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock

function find_ssh_auth_sock() {
  # Check if lsof exists
  if command -v lsof &> /dev/null; then

    # Search for keyring sockets and use them if they're open
    for file in /tmp/keyring-*/ssh; do
      if lsof $file &> /dev/null; then
        export SSH_AUTH_SOCK=$file
        return
      fi
    done

  fi
}

find_ssh_auth_sock
