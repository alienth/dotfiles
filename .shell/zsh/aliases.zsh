alias ls='echo; ls --color=auto'

alias sb='sudo -E zsh'

alias psgrep='ps auxwww | grep'

alias ..='cd ..'

alias psql='psql --set "serverhostname=$HOSTNAME"'

alias grep='grep --color=auto'

alias dud='du -xch . --max-depth=1 | sort -h'
alias sdud='sudo du -xch . --max-depth=1 | sort -h'

alias info='info --vi-keys'

which systemctl &>/dev/null
if [[ $? -eq 0 ]]; then
    which start &>/dev/null
    if [[ $? -eq 1 ]]; then
        alias start='systemctl start'
    fi

    which stop &>/dev/null
    if [[ $? -eq 1 ]]; then
        alias stop='systemctl stop'
    fi

    which restart &>/dev/null
    if [[ $? -eq 1 ]]; then
        alias restart='systemctl restart'
    fi

    which status &>/dev/null
    if [[ $? -eq 1 ]]; then
        alias status='systemctl status'
    fi
fi
