#
# Backblaze related stuff.
#
# Authors:
#   Zhiming Wang <zmwangx@gmail.com>
#

pmodload "cliutils"

backblaze-stop () {
    print_command "sudo launchctl unload /Library/LaunchDaemons/com.backblaze.bzserv.plist"
    sudo launchctl unload /Library/LaunchDaemons/com.backblaze.bzserv.plist
    print_command "launchctl unload ~/Library/LaunchAgents/com.backblaze.bzbmenu.plist"
    launchctl unload ~/Library/LaunchAgents/com.backblaze.bzbmenu.plist
}
