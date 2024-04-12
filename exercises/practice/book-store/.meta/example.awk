BEGIN {
    for (i = 5; i; --i)
        Books[i] = 0

    Price[1] = 8 * 100
    Price[2] = 8 * 95
    Price[3] = 8 * 90
    Price[4] = 8 * 80
    Price[5] = 8 * 75
}
{
    ++Books[$1]
}
END {
    n = asort(Books)

    for (i = 5; i; --i)
        Group[i] = Books[6 - i] - Books[5 - i]

    combined = Group[3] < Group[5] ? Group[3] : Group[5]
    Group[3] -= combined
    Group[5] -= combined
    Group[4] += 2 * combined

    for (i = 5; i; --i)
        total += Price[i] * Group[i] * i

    print total
}
