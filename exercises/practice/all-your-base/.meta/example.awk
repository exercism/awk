# These variables are initialized on the command line (using '-v'):
# - ibase
# - obase

function die(msg) {
    print msg > "/dev/stderr"
    exit 1
}

BEGIN {
    if (ibase < 2) die("input base must be >= 2")
    if (obase < 2) die("output base must be >= 2")
}

{
    # Sum up the ibase words to form a decimal value.
    val = 0
    for (i = NF; i; i-- ) {
        if ($i >= ibase) die("all digits must satisfy 0 <= d < input base")
        if ($i < 0) die("all digits must satisfy 0 <= d < input base")
        base = ibase ^ (NF - i)
        val += $i * base
    }

    # Handle default for no looping (0 value) or no entry (empty in empty out)
    if (val == 0 && NF > 0) parts[0] = 0

    # Convert from decimal to obase words.
    i = 0
    while (val) {
        parts[i++] = val % obase
        val = (val - parts[i - 1]) / obase
    }

    # Combine the output parts into a string.
    out = parts[0]
    for (j = 1; j < i; j++)
        out = parts[j] " " out
    if (out == 0)
        out = "0"
    print out
}

