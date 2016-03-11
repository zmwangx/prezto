#
# Aliases for acdcli.
#
# Authors:
#   Zhiming Wang <zmwangx@gmail.com>
#

alias acddown='acdcli upload --max-connections=8 --max-retries=4'
alias acdls='acdcli ls'
alias acdsync='while ! acdcli -v sync; do :; done'
alias acdtrees='acdcli trees' # acdcli-trees is from https://github.com/zmwangx/acdcli-more
alias acdup='acdcli upload --max-connections=8 --max-retries=4'
