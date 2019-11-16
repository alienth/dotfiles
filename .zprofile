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

# Bail if we're already tmux.
if [[ ! -z "$TMUX_PANE" ]]; then
    return
fi

if [[ -x /usr/bin/tmux ]]; then
  if [[ -z $TMUX && -f ~/.outer ]]; then
    echo "Run outer tmux? "
    local INPUT
    read -qs INPUT
    if [[ "$INPUT" == "y" ]]; then
      tmux new-session -A -s outer
    else
      tmux new-session -A -s inner
    fi
  else
    unset TMUX
    tmux new-session -A -s inner
  fi
elif [[ -x /usr/bin/screen ]]; then
  # If we're not already in a screen, prompt for opening the outer screen.
  if [[ "$TERM" != "screen" && -f ~/.masterscreen ]]; then
    screen -ls
    local INPUT
    vared -p "Outer(1) or Inner(2)?: " -c INPUT
    if [[ "$INPUT" == "1" ]]; then
      screen -c .masterscreen -xR outer
    elif [[ "$INPUT" == "2" ]]; then
      screen -xR inner
    fi
  else
    screen -xR inner
  fi
fi


