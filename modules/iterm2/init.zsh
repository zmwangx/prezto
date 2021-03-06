#
# iTerm2 shell integration.
#
# Pulled from http://iterm2.com/misc/zsh_startup.in on Jul 3, 2015. More
# information about iTerm 2's shell integration can be found on
# https://iterm2.com/shell_integration.html.
#
# Improved by Zhiming Wang.
#
# Authors:
#   George Nachman <gnachman@gmail.com>
#   Zhiming Wang <zmwangx@gmail.com>
#

[[ $TERM == dumb ]] && return 1

if [[ -o login ]]; then
  if [ x"$TERM" != "xscreen" ]; then
    # Indicates start of command output. Runs just before command executes.
    iterm2_before_cmd_executes() {
      printf "\033]133;C\007"
    }

    iterm2_set_user_var() {
      printf "\033]1337;SetUserVar=%s=%s\007" "$1" $(printf "%s" "$2" | base64)
    }

    # Users can write their own version of this method. It should call
    # iterm2_set_user_var but not produce any other output.
    # e.g., iterm2_set_user_var currentDirectory $PWD
    # Accessible in iTerm2 (in a badge now, elsewhere in the future) as
    # \(user.currentDirectory).
    iterm2_print_user_vars() {
    }

    iterm2_print_state_data() {
      printf "\033]1337;RemoteHost=$USER@$iterm2_hostname\007"
      printf "\033]1337;CurrentDir=$PWD\007"
      iterm2_print_user_vars
    }

    # Report return code of command; runs after command finishes but before prompt
    iterm2_after_cmd_executes() {
      printf "\033]133;D;$?\007"
      iterm2_print_state_data
    }

    iterm2_precmd() {
      iterm2_after_cmd_executes

      # The user or another precmd may have changed PS1 (e.g., powerline-shell).
      # Ensure that our escape sequences are added back in.
      ITERM2_SAVED_PS1="$PS1"
      local iterm2_prompt_start_marker=$'\033]133;A\007'
      local iterm2_prompt_end_marker=$'\033]133;B\007'
      PS1="%{${iterm2_prompt_start_marker}%}${ITERM2_SAVED_PS1}%{${iterm2_prompt_end_marker}%}"
    }

    iterm2_preexec() {
      PS1="$ITERM2_SAVED_PS1"
      iterm2_before_cmd_executes
    }

    # If hostname -f is slow on your system, set iterm2_hostname prior to sourcing this script.
    [[ -z $iterm2_hostname ]] && iterm2_hostname=$(hostname -f)

    # hook up
    add-zsh-hook precmd iterm2_precmd
    add-zsh-hook preexec iterm2_preexec

    iterm2_print_state_data
    printf "\033]1337;ShellIntegrationVersion=1\007"
  fi
fi
