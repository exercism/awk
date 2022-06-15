#!/usr/bin/env gawk -f

BEGIN {
    opts["n"] = 0       # include line number
    opts["l"] = 0       # only filenames containing matches
    opts["v"] = 0       # invert matches

    n = split(flags, fs)
    for (i = 1; i <= n; i++) {
        switch (fs[i]) {
            case "i":   # case insensitive
                IGNORECASE = 1
                break
            case "x":   # whole line match
                pattern = "^" pattern "$"
                break
            default:
                opts[fs[i]] = 1
        }
    }
    count = 0
}

xor($0 ~ pattern, opts["v"]) {
    count++
    if (opts["l"]) {
        print FILENAME
        nextfile
    } else {
        output = $0
        if (opts["n"]) output = FNR ":" output
        if (ARGC > 2)  output = FILENAME ":" output
        print output
    }
}

END {
    exit(!count)
}
