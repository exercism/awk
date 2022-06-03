#!/usr/bin/env gawk -f

BEGIN {
    result = ""
    if (num % 3 == 0) result = result "Pling"
    if (num % 5 == 0) result = result "Plang"
    if (num % 7 == 0) result = result "Plong"
    print result ? result : num
}
