#!/usr/bin/env gawk -f

@include "assert"

BEGIN { FS = "," }

$2 == 0 {
    print 1
    next
}

{
    len = length($1)
    span = $2

    assert(span <= len, "span must be smaller than string length")
    assert($1 ~ /^[[:digit:]]+$/, "input must only contain digits")
    assert(span > 0, "span must not be negative")

    mx = 0
    for (i = 1; i <= len - span + 1; i++)
        mx = max(mx, product(substr($1, i, span)))
    print mx
}

function max(a, b) { return (a > b ? a : b) }

function product(str,    prod, digits, n, i) {
    prod = 1
    n = split(str, digits, "")
    for (i = 1; i <= n; i++)
        prod *= digits[i]
    return prod
}
