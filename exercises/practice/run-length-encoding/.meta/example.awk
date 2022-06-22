#!/usr/bin/env gawk -f

# These variables are initialized on the command line (using '-v'):
# - type

BEGIN {
    switch (type) {
        case "encode":
            FPAT="."
            processor="encoder"
            break
        case "decode":
            FPAT="[[:digit:]]*[^[:digit:]]"
            processor="decoder"
            break
        default:
            exit 2
    }
}

function encoder(    i, n, prev) {
    for (i = 1; i <= NF; i++) {
        if ($i == prev) {
            n++
        } else {
            if (i > 1) {
                printf "%s%s", (n == 1 ? "" : n), prev
            }
            prev = $i
            n = 1
        }
    }
    printf "%s%s\n", (n == 1 ? "" : n), prev
}

function decoder(    i, j, m, len) {
    for (i = 1; i <= NF; i++) {
        if (match($i, /([[:digit:]]*)(.)/, m)) {
            len = m[1] == "" ? 1 : m[1]
            for (j = 1; j <= len; j++) {
                printf "%s", m[2]
            }
        }
    }
    printf "\n"
}

NF { @processor() }
