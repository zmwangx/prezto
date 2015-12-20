# transmission

Shortcuts for working with `transmission-daemon` and `transmission-remote`.

## Aliases and functions

* `tmsd` for starting the daemon;
* `tmsd-stop` for stopping the daemon;
* `tms` is alias for `transmission-remote`;
* `tmsa [torrent|magnet]...` for adding torrents;
* `tmsi spec...` for retrieving torrent info;
* `tmsf spec...` for listing torrent files;
* `tmse spec fileno_list` for excluding files from torrent;
* `tmsp spec...` for pausing torrents;
* `tmsr spec...` for resuming torrents;
* `tmsv spec...` for verifying torrents;
* `tms-remove spec...` for removing transfers.

Here `spec` a torrent specification recognized by
`transmission-remote`. Accepted torrent specs include, but may not be limited
to, `all`, `active`, torrent hash, numeric ID or ID range, or comma-delimited
list of specs.

## Authors
* [Zhiming Wang](https://github.com/zmwangx)
