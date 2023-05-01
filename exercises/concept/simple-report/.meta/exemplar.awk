BEGIN {
    FS = ","
}

{ 
    n1 = $3 $4
    n2 = $5 $6
    avg = (n1 + n2) / 2
    print "#" $1 ", " $2 " = " avg
}
