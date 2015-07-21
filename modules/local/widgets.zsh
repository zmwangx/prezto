#
# Extra widgets for ZLE.
#

# This widget inserts "./" to the buffer and list possible completions
# (executable files and directories in the present working directory) if the
# buffer is empty or only contains whitespace.
function complete_pwd_items_on_empty_buffer
{
    if [[ $BUFFER =~ ^[[:space:]]*$ ]]; then
        BUFFER+="./"
        CURSOR+=2
        zle .list-choices
    else
        zle .expand-or-complete
    fi
}

zle -N complete_pwd_items_on_empty_buffer
