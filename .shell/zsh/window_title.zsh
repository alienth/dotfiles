AUTO_WINDOW_TITLE=true

# Don't override precmd/preexec; append to hook array.
autoload -Uz add-zsh-hook

function set-window-title() {
  # if [[ "$TERM" == ((x|a|ml|dt|E)term*|(u|)rxvt*) ]]; then
  #   printf "\e]2;%s\a" ${(V)argv}
  # fi
  printf "\e]2;%s\a" ${(V)argv}
}

# Sets the GNU Screen title.
function set-screen-title() {
  if [[ "$TERM" == screen* ]]; then
    printf "\ek%s\e\\" ${(V)argv}
  fi
}

# https://github.com/mattjj/my-oh-my-zsh/blob/master/terminal.zsh
# Sets the tab and window titles with the command name.
function set-title-by-command() {
  # Make setops local to this func.
  emulate -L zsh
  setopt LOCAL_OPTIONS EXTENDED_GLOB
  # If fg'ing a job, get the command name that is under job control.
  if [[ "${1[(w)1]}" == (fg|%*)(\;|) ]]; then
    # Get the job name, and, if missing, set it to the default %+.
    local job_name="${${1[(wr)%*(\;|)]}:-%+}"
    # Make a local copy for use in the subshell.
    local -A jobtexts_from_parent_shell
    jobtexts_from_parent_shell=(${(kv)jobtexts})
    jobs $job_name 2>/dev/null > >(
      read index discarded
      # The index is already surrounded by brackets: [1].
      set-title-by-command "${(e):-\$jobtexts_from_parent_shell$index}"
    )
  else
    # Set the command name, or in the case of sudo or ssh, the next command.
    local cmd=${1[(wr)^(*=*|-*)]}
    # # Right-truncate the command name to 15 characters.
    # if (( $#cmd > 15 )); then
    #   cmd="${cmd[1,15]}..."
    # fi

    # for kind in window tab screen; do
    for kind in window; do
      set-${kind}-title "$cmd"
    done
  fi
}


# Sets the tab and window titles before command execution.
function set-title-preexec() {
  if [[ "$AUTO_WINDOW_TITLE" == true ]]; then
    set-title-by-command "$2"
  fi
}
add-zsh-hook preexec set-title-preexec


# Sets the window title before the prompt is displayed.
function set-title-precmd() {
  if [[ "$AUTO_WINDOW_TITLE" == true ]]; then
    # '(%)' - flag to expand the resulting words in the same way as prompts.
    # :-    - Syntax hack to make this count as parameter expansion, in order to
    #         allow us to apply expansion flags to literal strings. This will
    #         just expand to whatever the literal is that follows it.
    # %~    - Prompt escape which evaluates to CWD, with home replaced with ~
    # In short, this gives us a prompt's %~ as a value.
    set-window-title "${(%):-%~}"
  fi
}
add-zsh-hook precmd set-title-precmd
