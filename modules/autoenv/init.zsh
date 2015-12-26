#
# autoenv/init.zsh
#
# See README.md for more info.
#
# Authors:
#   Zhiming Wang <zmwangx@gmail.com>
#

# Uncomment to turn on debug mode
# zstyle :prezto:module:autoenv debug on

# Stacks
#
# Note that each element in the directory stack, except the bottommost
# one, must be a descendant of the element immediately below it.
#
# Example: /usr, /usr/local, /usr/local/lib/python3.5, etc.
typeset -a _autoenv_dirs _autoenv_purge_funcs _autoenv_inserted_paths
typeset _autoenv_stack_counter=0

_autoenv_source () {
    setopt localoptions noshwordsplit noksharrays

    _autoenv_debug_print_stacks () {
        zstyle -t :prezto:module:autoenv debug && {
            print -P $'%F{blue}\n[DEBUG] Directory stack:%f'
            (( _autoenv_stack_counter > 0 )) && print -Rl $_autoenv_dirs
            print -P '%F{blue}[DEBUG] Purge function stack:%f'
            (( _autoenv_stack_counter > 0 )) && print -Rl $_autoenv_purge_funcs
        }
    }

    trap 'unfunction autoenv-insert-paths autoenv-purge &>/dev/null
          _autoenv_debug_print_stacks
          unfunction _autoenv_debug_print_stacks' EXIT

    # Skip if the cd is fake (cd'ing to the same directory)
    [[ $PWD == $OLDPWD ]] && return
    # Also skip if returning to a not-yet-popped directory (in which case PWD
    # must be at the top of the stack)
    (( _autoenv_stack_counter > 0 )) && [[ $PWD == $_autoenv_dirs[_autoenv_stack_counter] ]] && return

    [[ -f $PWD/.env ]] || return

    # Define autoenv-insert-paths which can be used inside .env
    typeset -a inserted_paths
    autoenv-insert-paths () {
        local arg
        typeset -a new_paths
        # Convert arguments to absolute paths and store in the array new_paths
        for arg; do
            [[ $arg == /* ]] || arg=$PWD/$arg
            new_paths+=$arg
        done
        path=( $new_paths $path )
        inserted_paths=( $new_paths $inserted_paths )
        rehash
        zstyle -t :prezto:module:autoenv quiet || {
            print -P '%F{green}Inserted paths:%f'
            print -Rl $new_paths
        }
    }

    # Source .env
    zstyle -t :prezto:module:autoenv quiet || print -P $'%F{green}\nSourcing .env...%f'
    source $PWD/.env || {
        print -P '%F{red}Error: Sourcing .env failed.%f'
        return 1
    }

    # Increase counter and save current directory to the directory stack
    (( _autoenv_stack_counter++ ))
    _autoenv_dirs[_autoenv_stack_counter]=$PWD

    # Register the purge function autoenv-purge in the purge function stack if
    # there is one; otherwise, register the `:' builtin
    if (( $+functions[autoenv-purge] )); then
        local funcname
        funcname=_autoenv_purge_$_autoenv_stack_counter
        # "Rename" _autoenv_purge to $funcname by evaluating the function def
        # under a different name.
        eval "${${:-"$(whence -f autoenv-purge)"}/autoenv-purge/$funcname}"
        _autoenv_purge_funcs[_autoenv_stack_counter]=$funcname
    else
        _autoenv_purge_funcs[_autoenv_stack_counter]=:
    fi

    # Register inserted paths in the inserted path stack (as a single
    # colon-delimited string)
    _autoenv_inserted_paths[_autoenv_stack_counter]=${(j/:/)inserted_paths}
}

_autoenv_purge () {
    setopt localoptions noshwordsplit noksharrays
    local topmost_dir purgefunc inserted_path stack_name

    [[ $PWD == $OLDPWD ]] && return
    while (( _autoenv_stack_counter > 0 )); do
        # Retrieve top of the directory stack
        topmost_dir=$_autoenv_dirs[_autoenv_stack_counter]
        # Do not pop if PWD is a descendant of topmost_dir
        [[ $PWD == ${topmost_dir}* ]] && break

        purgefunc=$_autoenv_purge_funcs[_autoenv_stack_counter]
        zstyle -t :prezto:module:autoenv debug && {
            print -Pn '%F{green}[DEBUG] Popping directory from stack: %f'
            print -R $topmost_dir
            [[ $purgefunc != : ]] && {
                print -Pn '%F{green}[DEBUG] Executing purge function: %f'
                print -R $purgefunc
            }
        }
        # Execute the purge function
        [[ $purgefunc != : ]] && $purgefunc
        # Remove inserted paths
        for inserted_path in ${(ws/:/)${_autoenv_inserted_paths[_autoenv_stack_counter]}}; do
            path=( ${path:#$inserted_path} )
            zstyle -t :prezto:module:autoenv quiet || {
                print -Pn $'%F{green}Removed path: %f'
                print -R $inserted_path
            }
        done
        rehash

        # Fake a pop by decreasing the counter, and set the topmost element of
        # each stsack to empty just for the sake of sanity
        for stack_name in _autoenv_dirs _autoenv_purge_funcs _autoenv_inserted_paths; do
            unset "${stack_name}[_autoenv_stack_counter]"
        done
        (( _autoenv_stack_counter-- ))
    done
}

add-zsh-hook chpwd _autoenv_purge
add-zsh-hook chpwd _autoenv_source
