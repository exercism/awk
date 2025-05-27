NR == 1 {
    Cols = NF
    for (i = 1; i<= Cols; i++) {
        ColsMinimum[i] = $i
    }
}
{
    row_max = $1
    for (i = 2; i <= Cols; i++) {
        if ($i > row_max) row_max = $i
    }
    RowsMaximum[NR] = row_max

    for (i = 1; i <= Cols; i++) {
        if ($i < ColsMinimum[i]) {
            ColsMinimum[i] = $i
        }
    }
}
END {
    for (row = 1; row <= NR; row++) {
        for (col = 1; col <= Cols; col++) {
            if (RowsMaximum[row] == ColsMinimum[col]) {
                print row, col
            }
        }
    }
}
