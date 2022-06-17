@load "ordchr"

BEGIN {
    FS = ""
    OFS = ""
    A = ord("A")
    a = ord("a")
}

{
    out = ""
    for (i = 1; i <= NF; i++) {
        if ("A" <= $i && $i <= "Z")
            $i = chr((ord($i) - A + distance) % 26 + A)
        else if ("a" <= $i && $i <= "z")
            $i = chr((ord($i) - a + distance) % 26 + a)
    }
    print
}
