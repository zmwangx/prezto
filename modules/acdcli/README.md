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
* `acdcli-batch-rename`: batch rename remote files.

## DIY

Add an executable to search path or define a function with a name of the form
`acdcli-action`, and it will be available as an action for `acd_cli` and
equivalents. Note that internal actions always take precedence over external
ones, and among external actions, functions take precedence over commands.

Since the invocation of external actions is the same as that of internal
actions, i.e., they are possibly preceded by global options to `acd_cli`
(`--verbose`, `--debug`, `--no-log`, etc.), it is recommended that external
actions also handle global options. To ease the parsing burden on external
action authors, the array of global options and their arguments as seen on the
command line (i.e., all arguments between `acd_cli` and the action name) is
serialized into a colon-delimited string<sup>1</sup> and passed to the external
action (be it a function or an executable) as an environment variable
`ACDCLI_GLOBAL_OPTS`, which could be optionally ignored — only the positional
arguments are absolutely relevant to an external action. It is recommended,
however, that all global options be passed to invocations of internal actions
(within the external action) even if they have no special meaning to an
external action. This can be easily achieved through the following:

```zsh
local global_options
global_options=( ${(s/:/)ACDCLI_GLOBAL_OPTS} )
```

Then invoke internal actions through

```zsh
command acdcli $global_options action blah blah ...
```

To define completion for an external aciton, use an autoloaded function of the
form `_acdcli-action` that handles a command line like `action [options]
[arguments]`. As a very basic example, see
[`_acdcli-open`](functions/_acdcli-open).

The autoloaded completers [`__acdcli_nodes`](functions/__acdcli_nodes),
[`__acdcli_dirs`](functions/__acdcli_dirs), and
[`__acdcli_trashes`](functions/__acdcli_trashes) are always at your disposal.

---

<sup>1</sup> An environment variable must be a scalar, so the array of global
options and their arguments must be serialized somehow, unless we resort to
`eval`, which is not a good idea when the environment variable potentially
comes from an untrusted source. I wasn't able to think of a perfect
serialization format that is trivial to serialize *and* deserialize, so I just
resorted to picking a good delimiter. On this front, colon is a widely-used
delimiter, and I chose it because it is rarely — hopefully never — seen in
paths (although there's currently no global option to `acd_cli` that accepts a
path as argument, it is conceivable that `--config-file` or a similar option
will be added in the near future when configuration file is implemented).

## Authors

* [Zhiming Wang](https://github.com/zmwangx)
