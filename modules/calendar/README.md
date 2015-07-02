Calendar
========

Provides aliases and functions for easier calendar access (based on the `cal`
command).

Supported `cal` implementations:

* [FreeBSD implementation](https://www.freebsd.org/cgi/man.cgi?query=cal) (also
  seen in more recent Debians)
* [OS X implementation](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/cal.1.html)
  (older implementaion from FreeBSD 6.0)


Functions and aliases
---------------------

* Year calendars: one may access the year calendar of a year between 2000 and
  2099 with four digits or two digits; e.g., `15` or `2015` prints the year
  calendar of 2015.

  ```
  > 15
                              2015
        January               February               March
  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
               1  2  3   1  2  3  4  5  6  7   1  2  3  4  5  6  7
   4  5  6  7  8  9 10   8  9 10 11 12 13 14   8  9 10 11 12 13 14
  11 12 13 14 15 16 17  15 16 17 18 19 20 21  15 16 17 18 19 20 21
  18 19 20 21 22 23 24  22 23 24 25 26 27 28  22 23 24 25 26 27 28
  25 26 27 28 29 30 31                        29 30 31


         April                  May                   June
  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
            1  2  3  4                  1  2      1  2  3  4  5  6
   5  6  7  8  9 10 11   3  4  5  6  7  8  9   7  8  9 10 11 12 13
  12 13 14 15 16 17 18  10 11 12 13 14 15 16  14 15 16 17 18 19 20
  19 20 21 22 23 24 25  17 18 19 20 21 22 23  21 22 23 24 25 26 27
  26 27 28 29 30        24 25 26 27 28 29 30  28 29 30
                        31

          July                 August              September
  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
            1  2  3  4                     1         1  2  3  4  5
   5  6  7  8  9 10 11   2  3  4  5  6  7  8   6  7  8  9 10 11 12
  12 13 14 15 16 17 18   9 10 11 12 13 14 15  13 14 15 16 17 18 19
  19 20 21 22 23 24 25  16 17 18 19 20 21 22  20 21 22 23 24 25 26
  26 27 28 29 30 31     23 24 25 26 27 28 29  27 28 29 30
                        30 31

        October               November              December
  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
               1  2  3   1  2  3  4  5  6  7         1  2  3  4  5
   4  5  6  7  8  9 10   8  9 10 11 12 13 14   6  7  8  9 10 11 12
  11 12 13 14 15 16 17  15 16 17 18 19 20 21  13 14 15 16 17 18 19
  18 19 20 21 22 23 24  22 23 24 25 26 27 28  20 21 22 23 24 25 26
  25 26 27 28 29 30 31  29 30                 27 28 29 30 31
  ```

* Month calendars: one may access the month calendar of the current year with
  full or abbreviated (three-character) month names; e.g., `jan` or `january`
  prints the calendar of January:

  ```
  > jan
      January 2015
  Su Mo Tu We Th Fr Sa
  1  2  3
  4  5  6  7  8  9 10
  11 12 13 14 15 16 17
  18 19 20 21 22 23 24
  25 26 27 28 29 30 31

  ```

  One may specify options recognized by `cal`. On recent FreeBSD
  implementations, one may pass a two-digit number as the last argument, and
  `jan`, `january`, etc. will recognize that as a year number from the 21st
  century, and print the month calendar from the year specified, e.g.:

  ```
  > jan 16        # output generated on Ubuntu 12.04
      January 2016
  Su Mo Tu We Th Fr Sa
  1  2
  3  4  5  6  7  8  9
  10 11 12 13 14 15 16
  17 18 19 20 21 22 23
  24 25 26 27 28 29 30
  31
  ```

* `cal3`: on implementations supporting the `-3` option, `cal3` is an alias for
  `cal -3`.
