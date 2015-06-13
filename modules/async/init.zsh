# add external directory to fpath for autoload
fpath=("${0:h}/external" $fpath)
autoload -Uz async
