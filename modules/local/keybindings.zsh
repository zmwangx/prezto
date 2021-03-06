#
# Extra keybindings for ZLE.
#
# The key_info associative array is defined in prezto/modules/editor/init.zsh.
# https://github.com/sorin-ionescu/prezto/blob/master/modules/editor/init.zsh
#

# up-line-or-search and down-line-or-search:
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#History-Control-1
(( $+key_info[Up] )) && bindkey "$key_info[Up]" up-line-or-search
(( $+key_info[Down] )) && bindkey "$key_info[Down]" down-line-or-search

bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

# bind keys to custom widgets
bindkey '^I' complete_pwd_items_on_empty_buffer
bindkey '^[p' vanilla_path
