{
    # Find all multiples of each input, from multiple to limit.
    for (i = 1; i <= NF; i++)
        if ($i)
            for (j = $i; j < limit; j += $i)
                multiples[j] = 1

    # Sum up the multiples.
    sum = 0
    for (i in multiples)
        sum += i

    print sum
}
