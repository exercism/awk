#!/usr/bin/env gawk -f

function is_pangram(str,      letters, letter, chars, n, i) {
    n = split(str, chars, "")
    for (i = 1; i <= n; i++)
        if (chars[i] ~ /[[:alpha:]]/)
            letters[tolower(chars[i])] = 1
    return length(letters) == 26
}

{print is_pangram($0) ? "true" : "false"}
