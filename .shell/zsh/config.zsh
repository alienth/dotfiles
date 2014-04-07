# File for misc config

# sane globbing failure
setopt cshnullglob

bindkey -v
bindkey -M viins "^[[A" up-line-or-history
bindkey -M viins "^[[B" down-line-or-history
bindkey -M viins "^R" history-incremental-pattern-search-backward

export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
