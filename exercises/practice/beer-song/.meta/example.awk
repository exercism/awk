#!/usr/bin/env gawk -f

# These variables are initialized on the command line (using '-v'):
# - verse
# - start
# - stop

BEGIN {
    if (typeof(verse) != "untyped")
        start = stop = verse

    for (v = start; v >= stop; v--)
        do_verse(v)
}

function do_verse(v,    b1, b2) {
    b1 = bottles(v)
    b2 = bottles(v == 0 ? 99 : v - 1)

    printf "%s of beer on the wall, %s of beer.\n", b1, tolower(b1)
    printf "%s, %s of beer on the wall.\n", action(v), tolower(b2)
}

function bottles(n) {
    switch (n) {
        case 0: return "No more bottles"; break
        case 1: return "1 bottle"; break
        default: return n " bottles"; break
    }
}

function action(n) {
    switch (n) {
        case 0: return "Go to the store and buy some more"; break
        case 1: return "Take it down and pass it around"; break
        default: return "Take one down and pass it around"; break
    }
}
