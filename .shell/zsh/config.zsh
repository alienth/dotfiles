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

# By default, vi-backward-delete-char would be used with backspace (^?). This
# doesn't allow backspacing over newline characters, which can be annoying if a
# newline character was pasted.
bindkey -v '^?' backward-delete-char

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

# When sshing into boxes, by default only TERM is passed and accepted. This
# means the remote side does not get our COLORTERM variable, and assumes we do
# not support colour. If we ended up passing in xterm-256color, we recreate
# COLORTERM for use when we execute a screen. We can then set our TERM within
# screen to screen-256color.
if [[ "$TERM" == "xterm-256color" && -z "$COLORTERM" ]]; then
  export COLORTERM=truecolor
fi

if [[ "$COLORTERM" == "truecolor" && "$TERM" == "screen" ]]; then
  export TERM=screen-256color
fi
