# Algorithm taken from Wikipedia:
# https://en.wikipedia.org/wiki/Knapsack_problem
# 
# Define m[i,w] to be the maximum value that can be attained
# with weight less than or equal to w using items up to i
# (first i items).
# 
# We can define m[i,w] recursively as follows:
# 
#     m[0,w] = 0
#     m[i,w] = m[i−1,w] if w_{i} > w (the new item is more than the current weight limit)
#     m[i,w] = max (m[i−1,w], m[i−1, w − w_{i}] + v_{i}) if w_{i} ⩽ w


BEGIN {
    FS = "[:,]"
    n = 0
}

$1 == "limit" {
    max_wt = $2
}

$1 == "weight" && $3 == "value" {
    n++
    weight[n] = $2
    value[n] = $4
}

END {
    for (w = 1; w <= max_wt; w++)
        m[0][w] = 0

    for (i = 1; i <= n; i++)
        for (w = 1; w <= max_wt; w++)
            if (weight[i] > w)
                m[i][w] = m[i-1][w]
            else
                m[i][w] = max( m[i-1][w], m[i-1][w-weight[i]] + value[i] )

    print m[n][max_wt]
}

function max(a, b) {
    return a > b ? a : b
}
