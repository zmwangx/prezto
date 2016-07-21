#
# Aliases for acdcli.
#
# Authors:
#   Zhiming Wang <zmwangx@gmail.com>
#

pmodload cliutils

alias acddown='acdcli download --max-connections=8'
alias acdls='acdcli ls'
alias acdsync='while ! acdcli -v sync; do :; done'
alias acdtrees='acdcli trees' # acdcli-trees is from https://github.com/zmwangx/acdcli-more
alias acdup='acdcli upload --max-connections=8'
