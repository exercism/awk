@load "ordchr"
@include "join"

BEGIN { A = ord("A") }

$1 ~ /^[A-Z]$/ {
    num = ord($1) - A + 1
    size = 2 * num - 1

    for (i = 1; i <= num; i++) {
        for (j = 1; j <= num; j++) {
            char = i == j ? chr(A + i - 1) : " "
            row[num - j + 1] = row[num + j - 1] = char
        }
        line = join(row, 1, length(row), SUBSEP)
        diamond[size - i + 1] = diamond[i] = line
    }

    print join(diamond, 1, length(diamond), ORS)
}
