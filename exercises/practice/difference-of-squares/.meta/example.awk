function square_of_sum(n,    sum, i) {
    sum = 0
    for (i = 1; i <= n; i++) {
        sum += i
    }
    return sum * sum
}

function sum_of_squares(n,    sum, i) {
    sum = 0
    for (i = 1; i <= n; i++) {
        sum += i * i
    }
    return sum
}

function difference(n) {
    return square_of_sum(n) - sum_of_squares(n)
}

BEGIN { FS = "," }

{
    f = $1
    print @f($2)
}
