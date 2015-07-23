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
        zle list-choices
    else
        zle expand-or-complete
    fi
}

zle -N complete_pwd_items_on_empty_buffer

# This widgets adds PATH=... to the beginning of the buffer, where the PATH
# contains a set of "vanilla" paths read from /etc/paths and /etc/paths.d.
#
# Not supported on systems that don't use /etc/paths and /etc/paths.d, e.g.,
# Ubuntu, which sets the system path in /etc/environment.
function vanilla_path
{
    setopt localoptions nullglob noksharrays noshwordsplit
    local -a vanilla_paths

    function read_path_file
    {
        [[ -r $1 ]] || { print_error "'$1' not readable"; return 1; }
        local IFS=$'\n'
        vanilla_paths+=( $(<$1) )
    }

    [[ -r "/etc/paths" ]] && read_path_file "/etc/paths"
    for file in /etc/paths.d/*; do
        [[ -r $file ]] && read_path_file $file
    done

    [[ -n $vanilla_paths ]] && LBUFFER="PATH='${(j/:/)vanilla_paths}' $LBUFFER"
}

zle -N vanilla_path
