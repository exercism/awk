#!/usr/bin/env gawk -f

BEGIN {
    tile["A"]=1; tile["E"]=1; tile["I"]=1; tile["O"]=1; tile["U"]=1
    tile["L"]=1; tile["N"]=1; tile["R"]=1; tile["S"]=1; tile["T"]=1
    tile["D"]=2; tile["G"]=2
    tile["B"]=3; tile["C"]=3; tile["M"]=3; tile["P"]=3
    tile["F"]=4; tile["H"]=4; tile["V"]=4; tile["W"]=4; tile["Y"]=4
    tile["K"]=5
    tile["J"]=8; tile["X"]=8
    tile["Q"]=10; tile["Z"]=10

    # FS cannot contain space
    FS = OFS = ","
}

{
    $1 = toupper($1)
    split($1, letters, //)
    sum = 0
    for (i in letters)
        sum += tile[letters[i]]
     print $1, sum
}
