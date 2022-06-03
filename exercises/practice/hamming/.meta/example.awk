#!/usr/bin/env gawk -f

BEGIN {
    FS = ""     # each char is a separate field
}
NR == 1 {
    len = NF
    for (i=1; i<=NF; i++)
        first[i] = $i
    next
}
len != NF {
    print "strands must be of equal length" >"/dev/stderr"
    exit 1
}
{
    diff = 0
    for (i=1; i<=NF; i++)
        if ($i != first[i])
            diff++
    print diff
}
