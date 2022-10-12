# These variables are initialized on the command line (using '-v'):
# - num

function is_armstrong(num,    len, sum) {
    len = split(num, digits, "")
    for (i=1; i <= len; i++) {
        sum += digits[i] ^ len
    }
    return sum == num
}

BEGIN {
    print is_armstrong(num) ? "true" : "false"
}

