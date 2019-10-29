# File for misc config

# sane globbing failure
setopt cshnullglob

# If this is on, any parameter passed to `cd` that happens to be variable is
# expanded as such. I hate this.
unsetopt cdablevars

bindkey -v
bindkey -M viins "^[[A" up-line-or-history
bindkey -M viins "^[[B" down-line-or-history
bindkey -M viins "^R" history-incremental-pattern-search-backward
bindkey -M viins "^P" up-line-or-history
bindkey -M viins "^N" down-line-or-history

# The 'undo completion/expansion' key
bindkey  undo

if [ -f /etc/alternatives/editor ]; then
  export EDITOR=/etc/alternatives/editor
else
  export EDITOR=/usr/bin/vim
fi

if [[ ("$COLORTERM" == "mate-terminal" || "$COLORTERM" == "truecolor") && "$TERM" == "xterm" ]]; then
  export TERM=xterm-256color
fi
