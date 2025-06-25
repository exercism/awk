BEGIN {
    FS = ""
    FLOWER = 99
}

{
    for (i = 1; i <= NF; i++)
        board[NR][i] = ($i == "*" ? FLOWER : 0)
}

END {
    nrows = NR
    ncols = NF

    # annotate
    for (i = 1; i <= nrows; i++)
        for (j = 1; j <= ncols; j++)
            if (board[i][j] == FLOWER) 
                for (di = -1; di <= 1; di++)
                    for (dj = -1; dj <= 1; dj++)
                        if (1 <= i + di && i + di <= nrows &&
                            1 <= j + dj && j + dj <= ncols &&
                            board[i + di][j + dj] != FLOWER)
                        {
                            board[i + di][j + dj] += 1
                        }

    for (i = 1; i <= nrows; i++) {
        for (j = 1; j <= ncols; j++) {
            if (board[i][j] == 0) 
                printf "."
            else if (board[i][j] == FLOWER)
                printf "*"
            else
                printf "%d", board[i][j]
        }
        print ""
    }
}
