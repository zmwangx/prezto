#
# init.zsh for the cliutils module, defining various printing facilities.
#
# Authors:
#   Zhiming Wang <zmwangx@gmail.com>
#

print_milestone () print -R $'\e[32;1m'"$@"$'\e[0m' >&2
print_progress () print -R $'\e[32m'"$@"$'\e[0m' >&2
print_command () print -R $'\e[34;1m'"==> $@"$'\e[0m' >&2
print_note () print -R $'\n\e[1m'"$@"$'\e[0m' >&2
print_warning () print -R $'\e[33m'"Warning: $@"$'\e[0m' >&2
print_error () print -R $'\e[31m'"Error: $@"$'\e[0m' >&2
print_fatal_error () print -R $'\e[31;1m'"Fatal error: $@"$'\e[0m' >&2
