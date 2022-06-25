#!/usr/bin/env gawk -f

BEGIN {
    # the scores will be in a numerically indexed array to maintain
    # the insertion order.
    # This controls the sorting for the "personal top 3" action:
    PROCINFO["sorted_in"] = "@val_num_desc"
}

$0 == "list" {
    for (i = 1; i <= n; i++)
        print scores[i]
    next
}
$0 == "latest" {
    print scores[n]
    next
}
$0 == "personalBest" {
    print max
    next
}
$0 == "personalTopThree" {
    count = 0
    for (i in scores) {
        print scores[i]
        if (++count == 3) break
    }
    next
}
max == "" || max < $0 {
    max = $0
}
{
    scores[++n] = $0
}
