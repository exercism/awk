{
    plainText = tolower(gensub(/[^[:alnum:]]/, "", "g"))

    len = length(plainText)
    side = int(sqrt(len))
    cols = side * side < len ? side + 1 : side
    rows = side * cols < len ? side + 1 : side

    NF=0
    for (i = 0; i < rows * cols; ++i) {
        symbol = i >= len ? " " : substr(plainText, i + 1, 1)
        chunk = 1 + i % cols
        $chunk = $chunk symbol
    }
    print
}
