BEGIN {FS = ","}

{
    delete dice
    delete count
    sum = 0
    for (i = 1; i <= 5; i++) {
        dice[i] = $i
        count[$i] = 1 + count[$i]
        sum = sum + $i
    }
}

$6 == "ones"   { print 0 + count[1] }
$6 == "twos"   { print 0 + count[2] * 2 }
$6 == "threes" { print 0 + count[3] * 3 }
$6 == "fours"  { print 0 + count[4] * 4 }
$6 == "fives"  { print 0 + count[5] * 5 }
$6 == "sixes"  { print 0 + count[6] * 6 }

$6 == "yacht"  { print length(count) == 1 ? 50 : 0 }
$6 == "choice" { print sum }

$6 == "full house" {
    n = asort(count)
    print n == 2 && count[1] == 2 && count[2] == 3 ? sum : 0
}

$6 == "four of a kind" {
    for (i = 1; i <= 6; i++)
        if (count[i] >= 4) {
            print 4 * i
            next
        }
    print 0
}

$6 == "little straight" { print straight(0) }
$6 == "big straight"    { print straight(1) }

function straight(offset,     i) {
    asort(dice)
    for (i = 1; i <= 5; i++)
        if (dice[i] != i + offset)
            return 0
    return 30
}
