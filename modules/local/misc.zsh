#
# Miscellaneous stuff that doesn't fit elsewhere.
#

# I'm not a big fan of seeing ^C or ^Z echoed to terminal. When you ^C or ^Z,
# either they work as expected, in which case echoing to terminal is pointless;
# or they don't, in which case seeing the echos just add to your annoyance.
stty -ctlecho
