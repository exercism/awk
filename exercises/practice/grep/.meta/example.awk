# These variables are initialized on the command line (using '-v'):
# - flags
# - pattern

BEGIN {
    opts["n"] = 0       # include line number
    opts["l"] = 0       # only filenames containing matches
    opts["v"] = 0       # invert matches
    opts["x"] = 0       # whole line matching
    opts["i"] = 0       # case insensitive

    n = split(flags, fs)
    for (i = 1; i <= n; i++) opts[fs[i]] = 1
    if (opts["i"]) IGNORECASE = 1
    count = 0
}

match($0, pattern, m) && opts["x"] && m[0] != $0 {
    delete m
}

# if there was a match, the `m` array will have an index `0`
xor((0 in m), opts["v"]) {
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
