#!/usr/bin/env gawk -f

# These variables are initialized on the command line (using '-v'):
# - action

@include "assert"
@include "join"

BEGIN {
    SHIFT = 7
    MSB = 128   # 0b10000000 
    MASK = 127  # 0b01111111

    assert(action == "encode" || action == "decode", "unknown action")
}

action == "encode" {
    delete bytes
    for (i = NF; i >= 1; i--) {
        n = strtonum("0x" $i)
        msb = 0
        do {
            byte = or(and(n, MASK), msb)
            push(bytes, sprintf("%02X", byte))
            msb = MSB
            n = rshift(n, SHIFT)
        } while (n > 0)
    }
    reverse(bytes)
    print join(bytes, 1, length(bytes))
}

action == "decode" {
    byte = strtonum("0x" $NF)
    assert(and(byte, MSB) == 0, "incomplete byte sequence")

    delete numbers
    num = 0
    for (i = 1; i <= NF; i++) {
        byte = strtonum("0x" $i)
        num = lshift(num, SHIFT) + and(byte, MASK)
        if (and(byte, MSB) == 0) {
            push(numbers, sprintf("%02X", num))
            num = 0
        }
    }
    print join(numbers, 1, length(numbers))
}

############################################################
function push(a, e,    i) {
    i = (typeof(a) == "untyped" ? 0 : length(a)) + 1
    a[i] = e
}

function reverse(a,    i, j, mid, tmp) {
    j = length(a)
    mid = rshift(j, 1)
    for (i = 1; i <= mid; i++) {
        tmp = a[j]
        a[j] = a[i]
        a[i] = tmp
        j--
    }
}
