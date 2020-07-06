# Keep all lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000000000
# Save all lines to the history file - the rest will be persisted via histdb.
SAVEHIST=10000000000
HISTFILE=~/.zsh_history/$HOST


setopt histignoredups sharehistory extendedhistory
#setopt histverify
setopt histignorespace

alias history='fc -il'

# Tried this, but it was too slow.
# bindkey -M viins '^R' _histdb-isearch
bindkey -M viins "^R" history-incremental-pattern-search-backward
