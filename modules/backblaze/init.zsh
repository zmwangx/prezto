#
# Backblaze related stuff.
#
# Authors:
#   Zhiming Wang <zmwangx@gmail.com>
#

pmodload "cliutils"

backblaze-stop () {
    print_command "sudo launchctl remove com.backblaze.bzserv"
    sudo launchctl remove com.backblaze.bzserv
    print_command "launchctl remove com.backblaze.bzbmenu"
    launchctl remove com.backblaze.bzbmenu
}
