#!/usr/bin/env gawk -f

function abs(val) {
    return (val > 0) ? val : -val
}

{
    for (i = 1; i <= NF; i++)
        if ($i < 0 || $i > 7) {
            print "invalid position: row or column is not on the board"
            exit 1
        }
    if ($1 == $3 && $2 == $4) {
        print "invalid position: pieces are on the same tile"
        exit 1
    }
    # Same row or same column.
    if ($1 == $3 || $2 == $4)
        print "true"
    # Same diagonal.
    else if (abs($3 - $1) == abs($4 - $2))
        print "true"
    else
        print "false"
}
