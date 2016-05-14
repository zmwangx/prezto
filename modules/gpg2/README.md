# gpg2

Helpers to make `gpg2` easier to use in a tty-only setting.

## Functions

* `gpgauth`: Use `gpg2` to sign a tmpfile which is deleted afterwards. `gpg-agent` will prompt for the passphrase if necessary. Used to populate `gpg-agent`'s cache, or reset the timer of the cached entry. This is especially useful for making signed commits with magit, since `gpg-agent` cannot prompt for passphrase within Emacs. (There is [`pinentry`](https://elpa.gnu.org/packages/pinentry.html) for Emacs on ELPA, but I had no luck with it.)

## Authors
* [Zhiming Wang](https://github.com/zmwangx)
