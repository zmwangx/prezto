#
# Aliases and functions for easier calendar access, based on the cal command.
#
# Supported cal implementations:
#
#   * FreeBSD implementation (also seen in more recent Debians)
#     https://www.freebsd.org/cgi/man.cgi?query=cal
#   * OS X implementation (older implementaion from FreeBSD 6.0)
#     https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/cal.1.html
#
# Authors:
#   Zhiming Wang <zmwangx@gmail.com>
#

(( ! $+commands[cal] )) && return 1

# util-linux implementation not supported
# http://man7.org/linux/man-pages/man1/cal.1.html
cal --month &>/dev/null && return 1

# old BSD implementation not supported
# http://www.openbsd.org/cgi-bin/man.cgi/OpenBSD-5.7/man1/cal.1
cal -w &>/dev/null && return 1

# dumb implementations without the -m month option not supported
# http://pubs.opengroup.org/onlinepubs/9699919799/utilities/cal.html
cal -m jan &>/dev/null || return 1

function prezto_calendar_init
{
    setopt localoptions noksharrays noshwordsplit
    local month_names month year

    month_names=(january jan febuary feb march mar april apr may june jun july jul
                 august aug september sep october oct november nov december dec)

    for year in $(seq -w 00 99); do
        eval "alias $year='cal 20$year'"
        eval "alias 20$year='cal 20$year'"
    done

    if cal -3 &>/dev/null; then
        # recent FreeBSD implementation (also found on recent Debians)
        for month in $month_names; do
            eval '
function '$month'
{
    if [[ $@[-1] =~ ^[0-9]{2}$ ]]; then
        cal -m '$month' ${@:1:-1} 20$@[-1]
    else
        cal -m '$month' $@
    fi
}'
        done

        alias cal3='cal -3'
    else
        # older FreeBSD implementation (also found on OS X)
        for month in $month_names; do
            eval "alias $month='cal -m $month'"
        done
    fi
}

prezto_calendar_init

unfunction prezto_calendar_init
