setopt interactive_comments
setopt numeric_glob_sort
setopt glob_star_short 2>/dev/null # new in 5.2
unsetopt auto_name_dirs
unsetopt bang_hist
unsetopt path_dirs

export PROMPT_EOL_MARK="" # PROMPT_SP
export LISTMAX=0 # ask if completion listing can't fit in one screen

# turn off ZLE bracketed paste in dumb term
# otherwise turn on ZLE bracketed-paste-magic
if [[ $TERM == dumb ]]; then
    unset zle_bracketed_paste
else
    autoload -Uz bracketed-paste-magic
    zle -N bracketed-paste bracketed-paste-magic
fi

# disable scrolling in completion listings
# see list-prompt in Completion-System.html, and zsh/complist in Zsh-Modules.html
zstyle -d ':completion:*:default' list-prompt
unset LISTPROMPT
