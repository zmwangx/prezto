#
# Defines sane environment variables for z and load it into the shell.
#
# Authors:
#   Zhiming Wang <zmwangx@gmail.com>
#

# Set $_Z_CMD to change the command name (default z).
_Z_CMD=j

# Set $_Z_DATA to change the datafile (default $HOME/.z).
_z_data_home=${XDG_DATA_HOME:-$HOME/.local/share}/z
mkdir -p $_z_data_home
_Z_DATA=$_z_data_home/index
touch $_Z_DATA
unset _z_data_home

# Set $_Z_NO_RESOLVE_SYMLINKS to prevent symlink resolution.
_Z_NO_RESOLVE_SYMLINKS=yes

# Set $_Z_NO_PROMPT_COMMAND to handle PROMPT_COMMAND/precmd yourself.

# Set $_Z_EXCLUDE_DIRS to an array of directory trees to exclude.
_Z_EXCLUDE_DIRS=(
    /tmp
)

# Set $_Z_OWNER to allow usage when in 'sudo -s' mode.

# Load.
#
# I don't care about others; for me, I know what `brew --prefix` would return
# in each case, so no need to do a costly external call.
function {
    local z
    for z in /usr/local/etc/profile.d/z.sh $HOME/.linuxbrew/etc/profile.d/z.sh /etc/profile.d/z.sh; do
        [[ -f $z ]] && source $z && return
    done
}
