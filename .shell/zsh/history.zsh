# Keep all lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000000000
# Save all lines to the history file - the rest will be persisted via histdb.
SAVEHIST=10000000000
HISTFILE=~/.zsh_history/$HOST


setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt extended_history       # Track timestamps in history file
setopt share_history          # import new cmds from hist file, and auto-appends hist lines to file
#setopt hist_verify            # show command with history expansion to user before running it

# Make history print out timestamps in the one true format: ISO8601.
# By default, history is just `fc -l`.
alias history='fc -il'

# Tried this, but it was too slow.
# bindkey -M viins '^R' _histdb-isearch
bindkey -M viins "^R" history-incremental-pattern-search-backward
