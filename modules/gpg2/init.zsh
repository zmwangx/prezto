#
# Make gpg2 easier to use.
#
# Authors:
#   Zhiming Wang <zmwangx@gmail.com>
#

pmodload cliutils

(( $+commands[gpg2] )) || [[ -n $NO_GPG2 ]] || {
    print_error 'gpg2 not found.'
    return 1
}

alias gpg='gpg2'
