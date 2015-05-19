#
# Manipulating disks and displaying disk info, including disk images.
#
# Authors:
#   Zhiming Wang <zmwangx@gmail.com>
#

alias dls='diskutil list'
alias dinfo='diskutil info'
alias dunmount='diskutil unmount'
alias dunmountdisk='diskutil unmountDisk'
alias deject='diskutil eject'
alias dmount='diskutil mount'
alias dmountdisk='diskutil mountDisk'

alias dattach='hdiutil attach'
alias dpattach='hdiutil attach -stdinpass'
alias ddetach='hdiutil detach'
