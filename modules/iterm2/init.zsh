#
# iTerm2 shell integration.
#
# Pulled from http://iterm2.com/misc/zsh_startup.in on May 17, 2015. More
# information about iTerm 2's shell integration can be found on
# https://iterm2.com/shell_integration.html.
#
# Authors:
#   George Nachman <gnachman@gmail.com>
#

if [[ -o login ]]; then
  if [ x"$TERM" != "xscreen" ]; then
    # Indicates start of command output. Runs just before command executes.
    iterm2_before_cmd_executes() {
      printf "\033]133;C\007"
    }

    # Report return code of command; runs after command finishes but before prompt
    iterm2_after_cmd_executes() {
      printf "\033]133;D;$?\007"
      printf "\033]1337;RemoteHost=$USER@`hostname -f`\007\033]1337;CurrentDir=$PWD\007"
    }

    # Mark start of prompt
    iterm2_prompt_start() {
      printf "\033]133;A\007"
    }

    # Mark end of prompt
    iterm2_prompt_end() {
      printf "\033]133;B\007"
    }

    PS1="%{$(iterm2_prompt_start)%}$PS1%{$(iterm2_prompt_end)%}"

    iterm2_precmd() {
      iterm2_after_cmd_executes
    }

    iterm2_preexec() {
      iterm2_before_cmd_executes
    }

    [[ -z $precmd_functions ]] && precmd_functions=()
    precmd_functions=($precmd_functions iterm2_precmd)

    [[ -z $preexec_functions ]] && preexec_functions=()
    preexec_functions=($preexec_functions iterm2_preexec)

    printf "\033]1337;RemoteHost=$USER@`hostname -f`\007"
    printf "\033]1337;CurrentDir=$PWD\007"
    printf "\033]1337;ShellIntegrationVersion=1\007"
  fi
fi
