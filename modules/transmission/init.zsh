#
# Alias and function definitions for transmission-daemon and
# transmission-remote.
#
# Authors:
#   Zhiming Wang <zmwangx@gmail.com>
#

pmodload 'cliutils'

alias tmsd='transmission-daemon'
alias tmsd-stop='pkill -f transmission-daemon'

alias tms='transmission-remote'
alias tmsl='transmission-remote --list'

tmsa () {
    local ret=0
    for arg; do
        print_progress "Adding '$arg'..."
        command transmission-remote --add $arg || { print_error "Failed to add '$arg'."; ret=1; }
    done
    return $ret
}

# Technical note: All of the following functions except tmse that make use of
# the --torrent option could get away with a single transmission-remote call by
# passing a comma-delimited list of torrent IDs to --torrent, but we use
# multiple calls for better separation of output and errors.

tmsi () {
    local ret=0
    for arg; do
        [[ $arg == <-> ]] || { print_error "'$arg' is not a numeric torrent ID."; ret=1; continue; }
        print_progress "Retrieving info for torrent $arg..."
        command transmission-remote --torrent $arg --info \
            || { print_error "Failed to retrieve info for torrent $arg."; ret=1; }
    done
    return $ret
}

tmsf () {
    local ret=0
    for arg; do
        [[ $arg == <-> ]] || { print_error "'$arg' is not a numeric torrent ID."; ret=1; continue; }
        print_progress "Retrieving list of files for torrent $arg..."
        command transmission-remote --torrent $arg --files \
            || { print_error "Failed to retrieve info for torrent $arg."; ret=1; }
    done
    return $ret
}

# Exclude files from a torrent
tmse () {
    if [[ $1 == (-h|--help) ]]; then
        cat >&2 <<HELP
Usage: tmse <torrent> <filelist>

<torrent> is the numeric torrent ID, <filelist> is a comma-delimited list of file No.s.
HELP
        return 1
    fi
    [[ $1 == <-> ]] || { print_error "'$1' is not a numeric torrent ID."; return 1; }
    command transmission-remote --torrent $1 --no-get $2 \
        || { print_error "Failed to exclude files '$2' from torrent $1."; return 1; }
}

tmsv () {
    local ret=0
    for arg; do
        [[ $arg == <-> ]] || { print_error "'$arg' is not a numeric torrent ID."; ret=1; continue; }
        print_progress "Start verifying torrent $arg..."
        command transmission-remote --torrent $arg --remove \
            || { print_error "Failed to start verifying torrent $arg."; ret=1; }
    done
    return $ret
}

tmsr () {
    local ret=0
    for arg; do
        [[ $arg == <-> ]] || { print_error "'$arg' is not a numeric torrent ID."; ret=1; continue; }
        print_progress "Removing torrent $arg..."
        command transmission-remote --torrent $arg --remove \
            || { print_error "Failed to remove torrent $arg."; ret=1; }
    done
    return $ret
}
