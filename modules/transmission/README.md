# transmission

Shortcuts for working with `transmission-daemon`, `transmission-remote` and
`transmission-show`.

## Aliases and functions

* `tmsd` for starting the daemon;
* `tmsd-stop` for stopping the daemon;
* `tms` is alias for `transmission-remote`;
* `tmsa [torrent|magnet]...` for adding torrents;
* `tmsi spec...` for retrieving torrent info;
* `tmsf spec...` for listing files in torrents;
* `tmse spec fileno_list` for excluding files from torrent;
* `tmsp spec...` for pausing torrents;
* `tmsr spec...` for resuming torrents;
* `tmsv spec...` for verifying torrents;
* `tms-remove spec...` for removing transfers;
* `tms-rm` abbreviated form of `tms-remove`;
* `tms-files torrent` for listing files in a torrent without queueing it for
  download.

Here `spec` a torrent specification recognized by
`transmission-remote`. Accepted torrent specs include, but may not be limited
to, `all`, `active`, torrent hash, numeric ID or ID range, or comma-delimited
list of specs.

## Authors
* [Zhiming Wang](https://github.com/zmwangx)
