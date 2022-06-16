#!/usr/bin/env gawk -f

BEGIN {
    digit[" _ | ||_|"] = "0"
    digit["     |  |"] = "1"
    digit[" _  _||_ "] = "2"
    digit[" _  _| _|"] = "3"
    digit["   |_|  |"] = "4"
    digit[" _ |_  _|"] = "5"
    digit[" _ |_ |_|"] = "6"
    digit[" _   |  |"] = "7"
    digit[" _ |_||_|"] = "8"
    digit[" _ |_| _|"] = "9"

    status = 0

    # initialize `pipes` as an array
    pipes[1]

    # instead of splitting using a separator, split based on 
    # the _contents_ of the fields: a field is 3 characters
    FPAT = "..."
}

length($0) % 3 != 0 {
    print "Number of input columns is not a multiple of three" > "/dev/stderr"
    status = 1
    exit
}

# at the first line of the group of 4, clear the `pipes` array
NR % 4 == 1 { for (i in pipes) delete pipes[i] }

# for lines 1-3 of the group of 4, collect the symbols to assemble the digits
NR % 4 != 0 { for (i = 1; i <= NF; i++) pipes[i] = pipes[i] $i }

# every 4th line, process the data from the previous 3 lines
NR % 4 == 0 {
    num = ""
    for (i = 1; i <= length(pipes); i++) {
        dgt = (pipes[i] in digit) ? digit[pipes[i]] : "?"
        num = num dgt
    }
    rows[++n] = num
}

END {
    if (status == 0) {
        if (NR % 4 != 0) {
            print "Number of input lines is not a multiple of four" > "/dev/stderr"
            status = 1
        }
        else if (length(rows)) {
            printf "%s", rows[1]
            for (i = 2; i <= length(rows); i++) printf ",%s", rows[i]
            printf "\n"
        }
    }
    exit status
}
