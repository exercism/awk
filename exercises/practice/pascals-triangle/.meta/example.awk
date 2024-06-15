$1 > 0 {
    triangle[1][1] = 1
    print "1"

    for (i = 2; i <= $1; i++) {
        for (j = 1; j <= i; j++) {
            triangle[i][j] = 0 + triangle[i-1][j-1] + triangle[i-1][j]
            printf "%s%d", (j == 1 ? "" : " "), triangle[i][j]
        }
        print ""
    }
}
