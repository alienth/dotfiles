alias ls='echo; ls --color=auto'

alias sb='sudo -E zsh'

alias psgrep='ps auxwww | grep'

alias ..='cd ..'

alias psql='psql --set "serverhostname=$HOSTNAME"'

alias grep='grep --color=auto'

alias dud='du -xch . --max-depth=1 | sort -h'
alias sdud='sudo du -xch . --max-depth=1 | sort -h'

alias gg='git grep'

alias info='info --vi-keys'

which systemctl &>/dev/null
if [[ $? -eq 0 ]]; then
    which start &>/dev/null
    if [[ $? -eq 1 ]]; then
        alias start='sudo systemctl start'
    fi

    which stop &>/dev/null
    if [[ $? -eq 1 ]]; then
        alias stop='sudo systemctl stop'
    fi

    which restart &>/dev/null
    if [[ $? -eq 1 ]]; then
        alias restart='sudo systemctl restart'
    fi

    which status &>/dev/null
    if [[ $? -eq 1 ]]; then
        alias status='sudo systemctl status'
    fi
fi
