# These variables are initialized on the command line (using '-v'):
# - num

function is_armstrong(n,    m, len, sum) {
    m = n
    len = length(n)
    sum = 0
    while (n > 0) {
        sum += (n % 10) ^ len
        n = int(n / 10)
    }
    return sum == m
}

BEGIN {
    print is_armstrong(num) ? "true" : "false"
}
