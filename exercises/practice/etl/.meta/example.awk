#!/usr/bin/env gawk -f

{
    gsub(/"/, "")
    n = split($0, items, /[:,][[:blank:]]*/)
    for (i = 2; i <= n; i++)
        if (items[i] ~ /^[[:alpha:]]$/)
            score[tolower(items[i])] = items[1]
}

END {
    PROCINFO["sorted_in"] = "@ind_str_asc"
    OFS = ","
    for (letter in score)
        print letter, score[letter]
}
