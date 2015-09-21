setopt clobber
setopt interactive_comments
unsetopt bang_hist
unsetopt path_dirs

export PROMPT_EOL_MARK="" # PROMPT_SP
export LISTMAX=0 # ask if completion listing can't fit in one screen

# turn off bracketed paste, which screws up auto-quoting of URL characters and messes up the Emacs shell
unset zle_bracketed_paste

# disable scrolling in completion listings
# see list-prompt in Completion-System.html, and zsh/complist in Zsh-Modules.html
zstyle -d ':completion:*:default' list-prompt
unset LISTPROMPT
