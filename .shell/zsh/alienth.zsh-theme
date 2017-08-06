# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background and the font Inconsolata.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
# 
# http://ysmood.org/wp/2013/03/my-ys-terminal-theme/
# Mar 2013 ys

# Machine name.
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

function container_color {
    (grep /docker/ /proc/1/cgroup >/dev/null && echo red) || echo green
}

local ret_status="%(?:%{$fg_bold[green]%}^_^ :%{$fg_bold[red]%}O_O %s)%{$reset_color%}"

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[white]%}on%{$reset_color%} git:%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}x"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}o"

# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE [TIME] \n $ 
PROMPT="
(${current_dir}) \
${ret_status}\
${git_info}
%{$fg[white]%}%n%{$fg[$(container_color)]%}@$(box_name)%{$reset_color%} \
%{$terminfo[bold]$fg[white]%}$ %{$reset_color%}"

#if [[ "$(whoami)" == "root" ]]; then
#PROMPT="
#%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
#%{$bg[yellow]%}%{$fg[cyan]%}%n%{$reset_color%} \
#%{$fg[white]%}at \
#%{$fg[green]%}$(box_name) \
#%{$fg[white]%}in \
#%{$terminfo[bold]$fg[yellow]%}${current_dir}%{$reset_color%}\
#${git_info} \
#%{$fg[white]%}[%*]
#%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
#fi
