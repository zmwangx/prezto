# autoenv

Inspired by [kennethreitz/autoenv](https://github.com/kennethreitz/autoenv),
but purer and more powerful. Implementation is completely independent and
shares no similarity whatsoever.

* **Purity**: Pure Zsh code that takes advantage of Zsh; no cross-shell
  compatibility baggage (including the pain introduced by the lowest common
  denominator feature set).

* **Power**: Unlike kennethreitz/autoenv which sources `.env` once and leaves
  it in your env forever, this implementation allows automatic purging of
  per-project env as soon as you leave the directory tree.

## Usage

Put an `.env` file in a directory, and it will be sourced upon entry of the
directory. There are two special functions:

* `autoenv-insert-paths`: Take paths as arguments, and insert them to the
  beginning of `$PATH`. `$PWD/` is automatically prepended to relative
  paths. Paths inserted this way persist when you `cd` into subdirectories and
  are automatically removed from `$PATH` (i.e., the `$path` array) upon leaving
  the directory tree.

* `autoenv-purge`: This is an optional user-defined function used to clean up
  the environment. If it is defined in `.env`, then its body is automatically
  executed upon leaving the directory tree. Again, paths inserted by
  `autoenv-insert-paths` are automatically taken care of, so you don't need
  `autoenv-purge` to deal with them.

## Examples

* The most common use case might be to insert a local helper directory into the
  `$path` array. This is a one-liner:

  ```zsh
  autoenv-insert-paths bin libexec
  ```

  inserts `$PWD/bin` and `$PWD/libexec` to your search path, and they are
  automatically dropped when you leave the directory tree.

* You might want to set some environment variables when you're working inside a
  directory tree, and drop them when you leave. This is also easy. For
  instance, `/usr/local/.env` might look like this:

  ```zsh
  export HOMEBREW_DEVELOPER=not-for-the-faint-hearted

  autoenv-purge () unset HOMEBREW_DEVELOPER
  ```

* More simple examples can be found in [`tests/`](tests).

* Be imaginative!

## Customizations

* `zstyle :prezto:module:autoenv quiet on` to make `autoenv` quieter, that is,
  suppress some automated notification messages. Output from sourcing `.env` or
  executing `autoenv-purge` is not suppressed.

* `zstyle :prezto:module:autoenv debug on` to turn on debug mode, which prints
  additional debugging info (e.g. the internal directory stack) upon directory
  changes.

## Authors
* [Zhiming Wang](https://github.com/zmwangx)
