BEGIN {
    dec["M"] = 1000; dec["CM"] = 900; dec["D"] = 500; dec["CD"] = 400
    dec["C"] = 100 ; dec["XC"] = 90 ; dec["L"] = 50 ; dec["XL"] = 40
    dec["X"] = 10  ; dec["IX"] = 9  ; dec["V"] = 5  ; dec["IV"] = 4
    dec["I"] = 1
    PROCINFO["sorted_in"] = "@val_num_desc"
}

{
    n = $1
    roman = ""
    for (r in dec) {
        while (n >= dec[r]) {
            roman = roman r
            n -= dec[r]
        }
    }
    print roman
}
