#
# Functional wrapper for rm that blocks removals of git repos without the -f or
# --force option.
#
# It also downright reject the removal of several specially protected
# directories, currently: $HOME/.config, $HOME/.local and $HOME/.local/share,
# whether -f is specified or not. To remove those, use command rm instead.
#
# Authors:
#   Zhiming Wang <zmwangx@gmail.com>
#

rm () {
    setopt localoptions noshwordsplit noksharrays
    local args_backup force node

    # Resolve path with pure Zsh, but do not resolve links.
    _rm_guard_resolve_path () {
        setopt localoptions extendedglob
        local node match MATCH MBEGIN MEND
        node=$1
        [[ $node != /* ]] && node=$PWD/$node
        node=${node//\/##/\/}
        while [[ $node == */./* ]]; do
            node=${node/\/.\//\/}
        done
        node=${node/%\/./\/}
        while [[ $node == */[^/]##/../* ]]; do
            print $node
            node=${node/\/[^\/]##\/..\//\/}
        done
        node=${node/%\/[^\/]##\/../\/}
        print -R $node
    }

    set -A args_backup $@
    while :; do
        case $1 in
            --force|-*f*) force=1 && shift;;
            --) shift && break;;
            -*) shift;;
            *) break;;
        esac
    done
    for node; do
        # -f, --force hasn't been specified && node exists && node is not a symlink && node is a git repo
        [[ -z $force && -e $node && ! -h $node && ( -e $node/.git || $node == (.git|*/.git) ) ]] && {
            printf "\e[31m'%s' is a git repo -- won't remove without the -f or --force option\e[0m\n" $node
            return 1
        }
        # compare to no-fly list
        node=$(_rm_guard_resolve_path $node)
        [[ $node == ($HOME/.config|$HOME/.local|$HOME/.local/share) ]] && {
            printf "\e[31;1mREMOVING '%s' IS DANGEROUS! No, for your safety we won't let you do that.\e[0m\n" $node
            return 1
        }
    done
    command rm $args_backup
}
