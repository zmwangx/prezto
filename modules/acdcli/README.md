# acdcli

Define shell extension mechanism and completions for
[`acd_cli`](https://github.com/yadayada/acd_cli/).

## Functions

* `acdcli`, `acd_cli`, `acd_cli.py`: shell wrapper for `acdcli` with support
  for external actions of the form `acdcli-action`. As an example, if a
  function or command `acdcli-open` is available, then an action `open` is
  added to `acdcli`;

* `acdcli-open`.

## Actions

* `open`: open remote directories in the web interface.

## DIY

Add an executable to search path or define a function with a name of the form
`acdcli-action`, and it will be available as an action for `acd_cli` and
equivalents. Note that internal actions always take precedence on external
ones, and among external actions, functions take precedence over commands.

To define completion for an external aciton, use an autoloaded function of the
form `_acdcli_action` that handles a command line like `action [options]
[arguments]`. As a very basic example, see
[`_acdcli_open`](functions/_acdcli_open).

The autoloaded completers [`__acdcli_nodes`](functions/__acdcli_nodes),
[`__acdcli_dirs`](functions/__acdcli_dirs), and
[`__acdcli_trashes`](functions/__acdcli_trashes) are always at your disposal.

## Authors

* [Zhiming Wang](https://github.com/zmwangx)
