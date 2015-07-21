#
# Integrates zsh-autosuggestions into Prezto.
#
# Authors:
#   Zhiming Wang <zmwangx@gmail.com>
#

source "${0:h}/external/autosuggestions.zsh" || return 1


# configuration
# Solarized base00/bryellow, suitable for Solarized Dark
AUTOSUGGESTION_HIGHLIGHT_COLOR="fg=241"


# rebind user customized zle-line-init
(( $+widgets[zle-line-init] )) && zle -A zle-line-init autosuggestions_user_line_init

# define custom zle-line-init widget that calls autosuggest-start
autosuggest_custom_line_init() {
    zle autosuggest-start

    # essentially monkey patch autosuggest-tab for non-standard tab binding
    # fix https://github.com/tarruda/zsh-autosuggestions/issues/14
    local tab_key_widget=${$(bindkey "^I")[(ws: :)2]}
    [[ $tab_key_widget != "undefined-key" ]] && zle -A "$tab_key_widget" "autosuggest-${tab_key_widget}-orig"

    (( $+widgets[autosuggestions_user_line_init] )) || return
    zle autosuggestions_user_line_init
}

zle -N zle-line-init autosuggest_custom_line_init


# keybindings
bindkey '^Q' autosuggest-toggle
