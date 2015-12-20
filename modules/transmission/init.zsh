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

# This helper scans argv for non-numeric arguments (more precisely, non-
# nonnegative integer arguments) and print an error for those
# arguments. Afterwards it set the array argument `torrents' to the list of
# (potentially) valid torrent IDs.
#
# Note that the caller is required to declare local arguments `torrents' and
# `ret', where `torrents' is an array and `ret' is a scalar for return value.
__tms_filter_torrent_ids () {
    local invalid_args
    invalid_args=( ${@:#<->} )
    [[ -z $invalid_args ]] || {
        print_error "The following arguments are not numeric torrent IDs: ${(j:, :)${(qq)invalid_args[@]}}.";
        ret=1;
    }
    set -A torrents ${(M)@:#<->}
}

tmsi () {
    local ret=0 torrents
    __tms_filter_torrent_ids $@
    [[ -n $torrents ]] || { print_error "No torrents specified."; return 1; }
    print_progress "Retrieving info for torrent(s) ${(j:, :)torrents}..."
    command transmission-remote --torrent ${(j:,:)torrents} --info
    return $ret
}

tmsf () {
    local ret=0 torrents
    __tms_filter_torrent_ids $@
    [[ -n $torrents ]] || { print_error "No torrents specified."; return 1; }
    print_progress "Retrieving list of files for torrent(s) ${(j:, :)torrents}..."
    command transmission-remote --torrent ${(j:,:)torrents} --files
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
    local ret=0 torrents
    __tms_filter_torrent_ids $@
    [[ -n $torrents ]] || { print_error "No torrents specified."; return 1; }
    print_progress "Start verifying torrent(s) ${(j:, :)torrents}..."
    command transmission-remote --torrent ${(j:,:)torrents} --verify
    return $ret
}

tmsr () {
    local ret=0 torrents
    __tms_filter_torrent_ids $@
    [[ -n $torrents ]] || { print_error "No torrents specified."; return 1; }
    print_progress "Removing torrent(s) ${(j:, :)torrents}..."
    command transmission-remote --torrent ${(j:,:)torrents} --remove
    return $ret
}
