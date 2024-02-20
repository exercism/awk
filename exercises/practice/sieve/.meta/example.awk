#!/usr/bin/env gawk -f

{
    limit = $1
    marks[0] = 0; delete marks[0]
    for (i = 2; i <= limit; i++) {
        marks[i] = i
    }

    # multiples of 2
    for (p = 4; p <= limit; p += 2) {
        marks[p] = 0
    }
    # multiples of odd numbered (potential) primes
    for (p = 3; p * p <= limit; p += 2) {
        if (marks[p]) {
            for (q = p * p; q <= limit; q += 2 * p) {
                marks[q] = 0
            }
        }
    }

    primes = ""
    for (p = 2; p <= limit; p++) {
        if (marks[p]) {
            primes = primes "," p
        }
    }

    print substr(primes, 2)
}
