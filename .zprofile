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

# When sshing into boxes, by default only TERM is passed and accepted. This
# means the remote side does not get our COLORTERM variable, and assumes we do
# not support colour. If we ended up passing in xterm-256color, we recreate
# COLORTERM for use when we execute a screen. We can then set our TERM within
# screen to screen-256color.
# This is complemented by settings in .shell/zsh/config.zsh
if [[ "$TERM" == "xterm-256color" && -z "$COLORTERM" ]]; then
  export COLORTERM=truecolor
fi

if [[ -x /usr/bin/screen ]]; then
  # If we're not already in a screen, prompt for opening the outer screen.
  if [[ "$TERM" != "screen" && -f ~/.outer ]]; then
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
elif [[ -x /usr/bin/tmux ]]; then
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
fi
