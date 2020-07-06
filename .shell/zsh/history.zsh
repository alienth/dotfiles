# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=9999999999
HISTFILESIZE=9999999999
SAVEHIST=9999999999
HISTFILE=~/.zsh_history/$HOST


setopt histignoredups sharehistory extendedhistory
#setopt histverify
setopt histignorespace

alias history='fc -il'

# Tried this, but it was too slow.
# bindkey -M viins '^R' _histdb-isearch
bindkey -M viins "^R" history-incremental-pattern-search-backward
