alias ls='echo; ls --color=auto'

alias sb='sudo -E zsh'

alias psgrep='ps auxwww | grep'

alias ..='cd ..'

alias psql='psql --set "serverhostname=$HOST"'

alias grep='grep --color=auto'

alias dud='du -xch . --max-depth=1 | sort -h'
alias sdud='sudo du -xch . --max-depth=1 | sort -h'

alias gg='git grep'

alias info='info --vi-keys'

if [[ -x /usr/bin/htop ]]; then
  alias top='htop'
fi

alias suspendlock='mate-screensaver-command -l; dbus-send \
  --system \
  --print-reply \
  --dest=org.freedesktop.login1 \
  /org/freedesktop/login1 \
  org.freedesktop.login1.Manager.Suspend \
  boolean:true'
