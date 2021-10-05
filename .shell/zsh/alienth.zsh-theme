# Adopted from http://ysmood.org/wp/2013/03/my-ys-terminal-theme/

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

function kube_prompt {
    if [[ $KUBECTL_TOUCH ]]; then
        if [[ $(date +%s)-$KUBECTL_TOUCH -lt 600 ]]; then
            echo -n $(kube_ps1)
        fi
    fi
}

# Git info.
local git_info='$(git_prompt_info)'
local tf_info='$(tf_prompt_info)'
local kube_info='$(kube_prompt)'
ZSH_THEME_TF_PROMPT_PREFIX_DEFAULT="tf:%{$fg[cyan]%}"
ZSH_THEME_TF_PROMPT_PREFIX_NONDEFAULT="tf:%{$fg[red]%}"
ZSH_THEME_TF_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[white]%}on%{$reset_color%} git:%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}x"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}o"

KUBE_PS1_SYMBOL_COLOR="default"
KUBE_PS1_CTX_COLOR="default"
KUBE_PS1_NS_COLOR="cyan"
KUBE_PS1_SEPARATOR=""

PROMPT="
(${current_dir}) \
${ret_status}\
${git_info} \
${tf_info} \
${kube_info}
%{$fg[white]%}%n%{$fg[${container_color}]%}@${box_name}%{$reset_color%} \
%{$terminfo[bold]$fg[white]%}$ %{$reset_color%}"
