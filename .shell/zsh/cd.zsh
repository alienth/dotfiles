#TODO replace this with chpwd setup
cd () {

    builtin cd "$*"
    if [ $? -ne 0 ]; then 
        if [ ! -x "$1" ] && [ -d "$1" ]; then
                echo -n "Cannot access dir, become root? ";
                read foo
                if [[ $foo = "y" ]] || [[ $foo = "Y" ]]; then
                        sudo zsh 
                        return
                else
                        builtin cd "$*"
                        return
                fi
        fi
    else
                ls --color=auto
    fi
}

cdd () {
    builtin cd "$*"
}

