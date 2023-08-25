BEGIN {
    split("1 2 3 4 5 6 7 8 9", digits[0]); digits[0][0] = 0
    split("2 4 6 8 1 3 5 7 9", digits[1]); digits[1][0] = 0
    result = "false"
}

# remove whitespace
{ gsub(/[[:blank:]]+/, "") }

# only valid if 2 or more digits
/^[[:digit:]]{2,}$/ {
    double = 0
    sum = 0
    for (i = length(); i >= 1; i--) {
        sum += digits[double][substr($0, i, 1)]
        double = !double
    }
    result = (sum % 10 == 0) ? "true" : "false"
}

END { print result }
