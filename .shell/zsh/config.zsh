# File for misc config

# sane globbing failure
setopt cshnullglob

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

if [[ "$COLORTERM" == "mate-terminal" || "$COLORTERM" == "truecolor" ]]; then
  export TERM=xterm-256color
fi
