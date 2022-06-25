@namespace "matrix"

function read(filename, mtx,    nr, n, i, line, row) {
    nr = 0
    while ((getline < filename) > 0) {
        nr++
        for (i = 1; i <= NF; i++)
            mtx[nr][i] = $i
    }
    close(filename)
}

function row(mtx, rownum,    len, r, i) {
    len = length(mtx[rownum])
    r = mtx[rownum][1]
    for (i = 2; i <= len; i++)
        r = r " " mtx[rownum][i]
    return r
}

function column(mtx, colnum,    len, c, i) {
    len = length(mtx)
    c = mtx[1][colnum]
    for (i = 2; i <= len; i++)
        c = c " " mtx[i][colnum]
    return c
}
