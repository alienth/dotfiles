# Stop here if we aren't interactive
[[ ! -o interactive ]] && return

# I'd like to use the window-title functions I've written, but they aren't
# loaded here yet. Loading that file itself in a login shell would be
# problematic.
if [[ -f ~/.window-name ]]; then
  echo -ne "\e]2;$(cat ~/.window-name)\a"
fi;

if [[ $TERM == "screen" ]]; then
  echo -ne '\ek'`hostname -s`'\e\\'
fi;

if [[ -x /usr/bin/tmux ]]; then
  if [[ -z $TMUX ]]; then 
    if [[ -f ~/.outer ]]; then
      echo -n "Run outer tmux? "
      local INPUT
      read -qs INPUT
      if [[ "$INPUT" == "y" ]]; then
        exec tmux new-session -A -s outer
      else
        exec tmux new-session -A -s inner
      fi
    else
      unset TMUX
      exec tmux new-session -A -s inner
    fi
  fi
elif [[ -x /usr/bin/screen ]]; then
  # If we're not already in a screen, prompt for opening the outer screen.
  if [[ "$TERM" != "screen" && -f ~/.masterscreen ]]; then
    screen -ls
    echo -n "Run outer screen? "
    local INPUT
    read -qs INPUT
    if [[ "$INPUT" == "y" ]]; then
      screen -c .outerscreen -xR outer
    else
      screen -xR inner
    fi
  else
    screen -xR inner
  fi
fi


