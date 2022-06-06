#!/usr/bin/env gawk -f

$1 == "total" {
    # This needs the `-M` option for arbitrary precision arithmetic.
    print ((2 ^ 64) - 1)
    next
}
$1 < 1 || $1 > 64 {
    print "square must be between 1 and 64" > "/dev/stderr"
    exit 1
}
{
    print 2 ^ ($1 - 1)
}
