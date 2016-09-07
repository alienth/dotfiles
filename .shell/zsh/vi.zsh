if [ `which vim` ]; then
	VI=`which vim`
else
	VI=`which vi`
fi

#complete -c vipath
vipath () {
	FILE=`which $1`
	$VI $FILE
}


vi () {
	if [ ! -d "$1" ] && [ ! -f "$1" ]; then
		$VI "$@";
		return
	fi

	if [[ ! -w "$1" && -f "$1" ]]; then
                echo -n "Not writable. Become root?"
                local foo
                read -q foo
                echo
                if [[ $foo = "y" ]]; then
                        sudo $VI "$@";
                        return
                else
        		$VI "$@";
                        return
                fi
	fi
        $VI "$@";
}

