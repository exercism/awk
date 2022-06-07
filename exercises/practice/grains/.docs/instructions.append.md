# Additional

## GNU awk and Arbitrary Precision Arithmetic

By default, numbers in `awk` are represented as double-precision floating
point numbers.  This provides 53 bits of precision (see [Table
16.3][table-16.3] in the manual).  Unfortunately, this is insufficient to
complete this exercise (spoiler alert, one test requires 63 bits of
precision).

"Insufficient precision" looks like this:
```sh
$ gawk 'BEGIN {
  n = 2 ^ 54
  if (n == n + 1)
    print "not enough precision"
  else
    print "OK"
}'
```
```none
not enough precision
```

GNU `awk` has the capability to use arbitrary-precision numbers, if the
relevant libraries have been compiled into the `awk` executable. Check
your awk version, and look for "GNU MPFR":
```sh
$ gawk --version
GNU Awk 5.0.1, API: 2.0 (GNU MPFR 4.0.2, GNU MP 6.2.0)
...
```

If it's present, enable the capability using the `-M` option:
```sh
$ gawk -M 'BEGIN {
  n = 2 ^ 54
  if (n == n + 1)
    print "not enough precision"
  else
    print "OK"
}'
```
```none
OK
```

What if my `awk` doesn't have `-M`?  You'll have to call out to an external
program that can do arbitrary precision arithmetic, like `bc`. See the
section [Using getline into a Variable from a Pipe][getline-pipe] for an
example how to do this.


Further reading: [Arbitrary Precision Arithmetic][arbitrary]


[table-16.3]: https://www.gnu.org/software/gawk/manual/html_node/Math-Definitions.html#table_002dieee_002dformats
[arbitrary]: https://www.gnu.org/software/gawk/manual/html_node/Arbitrary-Precision-Arithmetic.html
[getline-pipe]: https://www.gnu.org/software/gawk/manual/html_node/Getline_002fVariable_002fPipe.html
