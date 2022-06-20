#!/usr/bin/env gawk -f
#
# A translation of this lovely recursive javascript solution
# https://exercism.org/tracks/javascript/exercises/say/solutions/515ab00bc90f46b0bde3732d9317a46b

BEGIN {
    small[0] = "zero";   small[10] = "ten"
    small[1] = "one";    small[11] = "eleven"
    small[2] = "two";    small[12] = "twelve"
    small[3] = "three";  small[13] = "thirteen"
    small[4] = "four";   small[14] = "fourteen"
    small[5] = "five";   small[15] = "fifteen"
    small[6] = "six";    small[16] = "sixteen"
    small[7] = "seven";  small[17] = "seventeen"
    small[8] = "eight";  small[18] = "eighteen"
    small[9] = "nine";   small[19] = "nineteen"

    tens[2] = "twenty";  tens[6] = "sixty"
    tens[3] = "thirty";  tens[7] = "seventy"
    tens[4] = "forty";   tens[8] = "eighty"
    tens[5] = "fifty";   tens[9] = "ninety"
}

{ print say($0) }

function say(n) {
    if (n < 0 || n >= 1000000000000) 
        die("input out of range")

    if (n < 20)            return small[n]
    if (n < 100)           return say_small(n)
    if (n < 1000)          return say_large(n, 100, "hundred")
    if (n < 1000000)       return say_large(n, 1000, "thousand")
    if (n < 1000000000)    return say_large(n, 1000000, "million")
    if (n < 1000000000000) return say_large(n, 1000000000, "billion")
}

function say_small(n,    r) {
    r = n % 10
    return tens[int(n / 10)] (r == 0 ? "" : "-" small[r])
}

function say_large(n, divisor, label,    r) {
    r = n % divisor
    return say(int(n / divisor)) " " label (r == 0 ? "" : " " say(r))
}

function die(msg) {
    print msg > "/dev/stderr"
    exit 1
}
