#!/usr/bin/env gawk -f

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
    print max + 0
    next
}
$0 == "personalTopThree" {
    sorted_in = PROCINFO["sorted_in"]
    PROCINFO["sorted_in"] = "@val_num_desc"
    count = 0
    for (i in scores) {
        print scores[i]
        if (++count == 3) break
    }
    PROCINFO["sorted_in"] = sorted_in
    next
}
max == "" || max < $0 {
    max = $0
}
{
    scores[++n] = $0
}
