#!/usr/bin/env gawk -f

BEGIN {
    action[++n] = "wink"
    action[++n] = "double blink"
    action[++n] = "close your eyes"
    action[++n] = "jump"
    shake[1] = 1
}

{
    for (i in shake)
        delete shake[i]

    for (i = 1; i <= n; i++)
        if (bit($1, i))
            push(shake, action[i])

    if (bit($1, n + 1))
        reverse(shake)

    print join(shake)
}

############################################################
function bit(val, i) {
    return and(val, lshift(1, i - 1))
}

function push(array, element) {
    array[length(array) + 1] = element
}

function reverse(array,    i, j, tmp) {
    len = length(array)
    for (i = 1; i <= int(len / 2); i++) {
        j = len - i + 1
        tmp = array[j]
        array[j] = array[i]
        array[i] = tmp
    }
}

function join(array,    result, i) {
    result = array[1]
    for (i = 2; i <= length(array); i++)
        result = result "," array[i]
    return result
}
