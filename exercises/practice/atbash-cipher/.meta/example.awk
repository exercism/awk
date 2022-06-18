BEGIN {
    FPAT = "[[:alpha:][:digit:]]"
    OFS = ""
    split("abcdefghijklmnopqrstuvwxyz", letters, //)
    for (i = 1; i <= 26; i++)
        translation[letters[i]] = letters[27 - i]
    for (i = 0; i <= 9; i++)
        translation[i] = i
}

{
    $0 = tolower($0)
    for (i = 1; i <= NF; i++)
        $i = translation[$i]

    if (direction == "decode") {
        print
        exit
    }
    
    # For encoding, chunk output into blocks of 5.
    for (i = 1; i <= length($0); i += 5) {
        if (out) {
            out = out " "
        }
        out = out substr($0, i, 5)
    }
    print(out)
}
