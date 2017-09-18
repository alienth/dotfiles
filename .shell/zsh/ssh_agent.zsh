
export SSH_AUTH_SOCK=$HOME/.ssh/sockets/$(hostname -s)

function find_ssh_auth_sock() {
  emulate -L zsh
  setopt nonomatch

  local file
  for file in $HOME/.gnupg/S.gpg-agent.ssh $XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh; do
    if [[ ( -S $file ) ]]; then
      export SSH_AUTH_SOCK=$file
      return
    fi
  done
  local sockets
  sockets=(/run/user/*/keyring/ssh)
  # Check if lsof exists
  if command -v lsof &> /dev/null && (($#sockets)); then

    # Search for keyring sockets and use them if they're open
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
