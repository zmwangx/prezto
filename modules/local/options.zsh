setopt clobber
setopt interactive_comments
unsetopt bang_hist
unsetopt path_dirs

export PROMPT_EOL_MARK="" # PROMPT_SP
export LISTMAX=0 # ask if completion listing can't fit in one screen

# disable scrolling in completion listings
# see list-prompt in Completion-System.html, and zsh/complist in Zsh-Modules.html
zstyle -d ':completion:*:default' list-prompt
unset LISTPROMPT
