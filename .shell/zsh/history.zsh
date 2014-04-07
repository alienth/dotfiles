# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=9999999999
HISTFILESIZE=9999999999
SAVEHIST=9999999999
HOSTNAME=`hostname -s || echo unknown`
HISTFILE=~/.zsh_history/$HOSTNAME


setopt histignoredups sharehistory extendedhistory
#setopt histverify
setopt histignorespace

alias history='fc -il 1'
