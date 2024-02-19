$1 < 1 {
    print "Error: Only positive numbers are allowed" > "/dev/stderr"
    exit 1
}

{ 
    n = $1
    steps = 0
    while (n > 1) {
        steps++
        n = (n % 2 == 0) ? n / 2 : 3 * n + 1
    }
    print steps
}
