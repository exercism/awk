#!/usr/bin/env gawk -f

BEGIN {
    PROCINFO["sorted_in"] = "@val_str_asc"
    lower_key = tolower(key)
    comparitor = encode(lower_key)
}

function encode(word,    letters, i, encoded) {
    split(word, letters, "")
    for (i in letters)
        encoded = encoded letters[i]
    return encoded
}

# process the candidate words
{lower_word = tolower($0)}
lower_word != lower_key && encode(lower_word) == comparitor
