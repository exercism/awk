#!/usr/bin/env gawk -f

@include "assert"

BEGIN {
    FS = "|" 
    M = split("abcdefghijklmnopqrstuvwxyz", Alphabet, "")
    for (i = 1; i <= M; i++)
        AlphaIdx[Alphabet[i]] = i
}

{
    a = $2
    b = $3
    assert(gcd(a, M) == 1, "a and m must be coprime.")
}
$1 == "encode" {
    fun = "encrypt"
    post = "grouped"
}
function encrypt(x) { return floorMod(a * x + b, M) }

$1 == "decode" {
    a_inv = mmi(a, M)
    fun = "decrypt"
    post = "identity"
}
function decrypt(y) { return floorMod(a_inv * (y - b), M) }

{
    n = split(tolower(gensub(/[^[:alnum:]]/, "", "g", $4)), chars, "")
    output = ""

    for (i = 1; i <= n; i++) {
        if (chars[i] in AlphaIdx) {
            idx = @fun(AlphaIdx[chars[i]] - 1)
            output = output Alphabet[idx + 1]
        }
        else
            output = output chars[i]
    }
    print @post(output)
}

############################################################
function gcd(x, y) {
    if (y == 0) return x
    return gcd(y, x % y)
}

function mmi(a, m,    _mmi, i) {
    _mmi = 0
    for (i = 1; i <= m; i++) {
        _mmi = (_mmi + a) % m
        if (_mmi == 1) return i
    }
    assert(0, "can't find MMI of "a" and "m)
}

# return a value in the range `0 <= x < m`
function floorMod(n, m) {
    return (n % m + m) % m
}

############################################################
function grouped(str,    result, i) {
    result = substr(str, i, 5)
    for (i = 6; i <= length(str); i += 5)
        result = result " " substr(str, i, 5)
    return result
}

function identity(x) {
    return x
}
