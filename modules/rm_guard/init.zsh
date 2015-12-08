#
# Functional wrapper for rm that blocks removals of git repos with the -f or
# --force option.
#
# Authors:
#   Zhiming Wang <zmwangx@gmail.com>
#

rm () {
    setopt localoptions noshwordsplit noksharrays
    local args_backup force
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
        # -f, --force hasn't been specified && node is a git repo
        [[ -z $force && -e $node/.git ]] && {
            printf "\e[31m'%s' is a git repo -- won't remove without the -f or --force option" $node
            return 1
        }
    done
    command rm $args_backup
}
