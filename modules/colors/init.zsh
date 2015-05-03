#
# Environment variables for easier coloring and bolding.
#
# Author:
#   Zhiming Wang <zmwangx@gmail.com>
#

if [[ ${TERM} == dumb ]]; then
    return 1
fi

# https://github.com/zsh-users/zsh/blob/master/Functions/Misc/colors
autoload -U colors
colors
for colorname in black red green yellow blue magenta cyan white; do
    eval export ${(U)colorname}='${fg[${colorname}]}'
    eval export BR${(U)colorname}='"\e[38;5;$((color[${colorname}] - 22))m"'
done
export BOLD=${bold_color}
export RESET=${reset_color}
