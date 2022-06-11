#!/usr/bin/env gawk -f

# read the input into memory
{
    n = split($0, chars, "")
    for (i = 1; i <= n; i++) {
        Board[NR, i] = chars[i]
        if (chars[i] == "+")
            Vertices[NR, i] = 1
    }
}

END {
    PROCINFO["sorted_in"] = "coord_order"
    count = 0

    for (top_left in Vertices) {
        delete rs
        vertices_right_of(top_left, rs)
        delete bs
        vertices_below(top_left, bs)

        for (top_right in rs) {
            for (bottom_left in bs) {
                bottom_right = coord(row(bottom_left), col(top_right))
                if (bottom_right in Vertices &&
                    is_rectangle(top_left, top_right, bottom_left, bottom_right))
                        count++
            }
        }
    }

    print count
}

############################################################
function vertices_right_of(v1, vs,    r1, c1, r2, c2, v) {
    r1 = row(v1); c1 = col(v1)
    for (v in Vertices) {
        r2 = row(v); c2 = col(v)
        if (r1 == r2 && c1 < c2)
            vs[v] = 1
    }
}

function vertices_below(v1, vs,    r1, c1, r2, c2, v) {
    r1 = row(v1); c1 = col(v1)
    for (v in Vertices) {
        r2 = row(v); c2 = col(v)
        if (r1 < r2 && c1 == c2)
            vs[v] = 1
    }
}

function is_rectangle(tl, tr, bl, br,    rs, cs) {
    rs[1] = row(tl); cs[1] = col(tl)
    rs[2] = row(tr); cs[2] = col(tr)
    rs[3] = row(bl); cs[3] = col(bl)
    rs[4] = row(br); cs[4] = col(br)
    return  is_complete_horizontal(rs[1], cs[1], cs[2]) &&
            is_complete_horizontal(rs[3], cs[3], cs[4]) &&
            is_complete_vertical(cs[1], rs[1], rs[3]) &&
            is_complete_vertical(cs[2], rs[2], rs[4])
}

function is_complete_horizontal(row, col1, col2,    c) {
    for (c = col1; c <= col2; c++)
        if (Board[row, c] !~ /[+-]/)
            return 0
    return 1
}

function is_complete_vertical(col, row1, row2,    r) {
    for (r = row1; r <= row2; r++)
        if (Board[r, col] !~ /[+|]/)
            return 0
    return 1
}

############################################################
# Coordinate functions
# ref: https://www.gnu.org/software/gawk/manual/html_node/User_002dmodified.html#index-SUBSEP-variable
function coord(row, col) { return row SUBSEP col }
function row(coord,   a) { split(coord, a, SUBSEP); return a[1] }
function col(coord,   a) { split(coord, a, SUBSEP); return a[2] }

# https://www.gnu.org/software/gawk/manual/html_node/Controlling-Array-Traversal.html
function coord_order(i1, v1, i2, v2,    row1, col1, row2, col2, a) {
    row1 = row(i1); col1 = col(i1)
    row2 = row(i2); col2 = col(i2)
    if (row1 < row2) return -1
    if (row1 > row2) return +1
    if (col1 < col2) return -1
    if (col1 > col2) return +1
    return 0
}
