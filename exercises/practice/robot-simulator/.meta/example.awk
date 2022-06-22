#!/usr/bin/env gawk -f

# These variables are initialized on the command line (using '-v'):
# - x
# - y
# - dir

BEGIN {
    OK = 0
    FAIL = 1
    status = OK

    # Input variables: x, y, dir
    # handle default values
    x = 0 + x
    y = 0 + y
    if (dir == "") dir = "north"

    if (!(dir == "north" || dir == "east" || dir == "south" || dir == "west")) {
        print "invalid direction" > "/dev/stderr"
        status = FAIL
        exit
    }
}

$1 !~ /^[RAL]$/ {
    printf "invalid instruction" > "/dev/stderr"
    status = FAIL
    exit
}

$1 == "R" && dir == "north" { dir = "east";  next }
$1 == "R" && dir == "east"  { dir = "south"; next }
$1 == "R" && dir == "south" { dir = "west";  next }
$1 == "R" && dir == "west"  { dir = "north"; next }

$1 == "L" && dir == "north" { dir = "west";  next }
$1 == "L" && dir == "east"  { dir = "north"; next }
$1 == "L" && dir == "south" { dir = "east";  next }
$1 == "L" && dir == "west"  { dir = "south"; next }

$1 == "A" && dir == "north" { y += 1; next }
$1 == "A" && dir == "east"  { x += 1; next }
$1 == "A" && dir == "south" { y -= 1; next }
$1 == "A" && dir == "west"  { x -= 1; next }

END {
    if (status == OK) print x, y, dir
    exit status
}
