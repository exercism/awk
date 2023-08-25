BEGIN { result = "false" }

function luhn_digit(digit, double,    doubled) {
    if (!double) return digit
    doubled = digit * 2
    return doubled - (doubled > 9 ? 9 : 0)
}

# remove whitespace
{ gsub(/[[:blank:]]+/, "") }

# only valid if 2 or more digits
/^[[:digit:]]{2,}$/ {
    double = 0
    sum = 0
    for (i = length(); i >= 1; i--) {
        sum += luhn_digit(substr($0, i, 1), double)
        double = !double
    }
    result = (sum % 10 == 0) ? "true" : "false"
}

END { print result }
