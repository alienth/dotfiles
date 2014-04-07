

# Stop here if we aren't interactive
[[ ! -o interactive ]] && return

if [[ $TERM == "screen" ]]; then
  echo -ne '\ek'`hostname -s`'\e\\'
fi;

# Start screen, if possible
if [[ -x `which screen` ]]; then
  # If this is a "master" box, give a choice on what screen to pick
  if [[ -f ~/.masterscreen && -f ~/.master ]]; then
    screen -ls
    echo 'Master(1) or Slave(2)?'
    read i
    if [[ $i -eq 1 ]]; then
      screen -c .masterscreen -xR master
    else
      if [[ $i -eq 2 ]]; then
        screen -xR slave
      fi
    fi
  else
    screen -xR slave
  fi
fi


