# use zsh/Functions/Misc/run-help rather than the lame alias to man
(( $+aliases[run-help] )) && unalias run-help
autoload -Uz run-help
