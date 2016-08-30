
export SSH_AUTH_SOCK=$HOME/.ssh/sockets/$(hostname -s)

function find_ssh_auth_sock() {
  emulate -L zsh
  setopt nonomatch

  local sockets
  sockets=(/run/user/*/keyring/ssh)
  # Check if lsof exists
  if command -v lsof &> /dev/null && (($#sockets)); then

    # Search for keyring sockets and use them if they're open
    local file
    for file in $sockets; do
      if [[ ( -S $file ) && $file =~ '/run/user/.*' ]]; then
        export SSH_AUTH_SOCK=$file
        return
      elif lsof $file &> /dev/null; then
        export SSH_AUTH_SOCK=$file
        return
      fi
    done

  fi
}

find_ssh_auth_sock
