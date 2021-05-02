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
local box_name=$(box_name)

function container_color {
    (grep -E '(/docker/|/kubepods/)' /proc/1/cgroup >/dev/null && echo red) || echo green
}
local container_color=$(container_color)

local ret_status="%(?:%{$fg_bold[green]%}^_^ :%{$fg_bold[red]%}O_O %s)%{$reset_color%}"

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# Git info.
local git_info='$(git_prompt_info)'
local tf_info='$(tf_prompt_info)'
local kube_info='$(kube_ps1)'
ZSH_THEME_TF_PROMPT_PREFIX_DEFAULT="tf:%{$fg[cyan]%}"
ZSH_THEME_TF_PROMPT_PREFIX_NONDEFAULT="tf:%{$fg[red]%}"
ZSH_THEME_TF_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[white]%}on%{$reset_color%} git:%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}x"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}o"

KUBE_PS1_COLOR_SYMBOL="%{$reset_color%}"
KUBE_PS1_COLOR_CONTEXT="%{$reset_color%}"
KUBE_PS1_COLOR_NS="%{$fg[cyan]%}"

# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE [TIME] \n $ 
PROMPT="
(${current_dir}) \
${ret_status}\
${git_info} \
${tf_info} \
${kube_info}
%{$fg[white]%}%n%{$fg[${container_color}]%}@${box_name}%{$reset_color%} \
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
