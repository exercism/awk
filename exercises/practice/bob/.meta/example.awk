function rtrim(s) {
    return gensub(/[[:space:]]+$/, "", 1, s)
}
function is_yelling(s) {
    return (s ~ /[[:upper:]]/) && (s !~ /[[:lower:]]/)
}
function is_asking(s) {
    return rtrim(s) ~ /\?$/
}

BEGIN {
    RS = SUBSEP     # unlikely record separator character
                    # slurps the whole file as one record
}
rtrim($0) == "" {
    print "Fine. Be that way!"
    next
}
is_yelling($0) && is_asking($0) {
    print "Calm down, I know what I'm doing!"
    next
}
is_yelling($0) {
    print "Whoa, chill out!"
    next
}
is_asking($0) {
    print "Sure."
    next
}
{
    print "Whatever."
}
END {
    if (NR == 0) print "Fine. Be that way!"
}
