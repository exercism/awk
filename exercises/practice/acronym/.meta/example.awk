#!/usr/bin/env gawk -f

BEGIN {
    # field separator is whitespace or hyphen
    FS = "[[:blank:]-]+"
}
{
    acr = ""
    for (i=1; i<=NF; i++) {
        gsub(/[^[:alpha:]]/, "", $i)    # remove non-letters
        acr = acr substr($i, 1, 1)      # and take the first letter
    }
    print toupper(acr)
}
