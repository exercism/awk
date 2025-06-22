BEGIN {
    FPAT = "[0-9]|X$"
}
NF != 10 {
    print "false"
    next
}
$NF == "X" {
    $NF = 10
}
{
    check_sum = 0
    for (i = 1; i <= NF; ++i) {
        check_sum += (11 - i) * $i
    }
    print check_sum % 11 ? "false" : "true"
}
