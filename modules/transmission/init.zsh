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

# A central dispatcher to fight code duplication.
#
# Arguments are command name (tmsi, tmsf, etc.) plus torrent IDs.
__tms_central_command () {
    local command torrents
    command=$1 && shift
    torrents=( $@ )
    [[ -n $torrents ]] || { print_error "No torrents specified."; return 1; }

    local message_opening action_opt
    case $command in
        tmsi)
            message_opening="Retrieving info for"
            action_opt=--info
            ;;
        tmsf)
            message_opening="Retrieving list of files for"
            action_opt=--files
            ;;
        tmsp)
            message_opening="Pausing"
            action_opt=--stop
            ;;
        tmsr)
            message_opening="Resuming"
            action_opt=--start
            ;;
        tmsv)
            message_opening="Start verifying"
            action_opt=--verify
            ;;
        tms-remove|tms-rm)
            message_opening="Removing"
            action_opt=--remove
            ;;
        *)
            print_error "Unknown command ${(qq)command}."
            return 1
            ;;
    esac

    print_progress "$message_opening torrent(s) ${(j:, :)${torrents[@]//,/, }}..."
    command transmission-remote --torrent ${(j:,:)torrents} $action_opt
    return $ret
}

# Define individual functions realized by __tms_central_command
function {
    local command
    for command in tmsi tmsf tmsp tmsr tmsv tms-remove tms-rm; do
        eval "$command () __tms_central_command $command \$@"
    done
}


# Exclude files from a torrent
tmse () {
    if [[ $1 == (-h|--help) ]]; then
        cat >&2 <<HELP
Usage: tmse <torrent> <filelist>

<torrent> is a torrent spec, <filelist> is a comma-delimited list of file No.s.
HELP
        return 1
    fi
    command transmission-remote --torrent $1 --no-get $2 \
        || { print_error "Failed to exclude files '$2' from torrent $1."; return 1; }
}

# transmission-show wrapper that lists files in a torrent without bullshit
tms-files () {
    if [[ $1 == (-h|--help) ]]; then
        cat >&2 <<HELP
Usage: tms-files <torrent>

<torrent> is a torrent file to be listed.
HELP
        return 1
    fi
    command transmission-show $1 | sed -n '/^FILES$/,$ { /^FILES$/d; /^$/d; s/^  //; p }'
}
