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
        vertices_right_of(top_left, vr)  # populate vr array
        vertices_below(top_left, vb)     # populate vb array

        for (top_right in vr) {
            for (bottom_left in vb) {
                bottom_right = coord(row(bottom_left), col(top_right))
                if (bottom_right in Vertices &&
                    is_rectangle(top_left, bottom_right))
                        count++
            }
        }

        delete vr
        delete vb
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

function is_rectangle(tl, br,    r1, r2, c1, c2) {
    r1 = row(tl); c1 = col(tl)
    r2 = row(br); c2 = col(br)
    return  is_complete_horizontal(r1, c1, c2) &&
            is_complete_horizontal(r2, c1, c2) &&
            is_complete_vertical(c1, r1, r2) &&
            is_complete_vertical(c2, r1, r2)
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
