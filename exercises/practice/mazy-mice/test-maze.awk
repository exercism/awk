#!/usr/bin/env gawk -f
#
# Copyright (c) 2023 Jegors Čemisovs
# License: MIT License
# Repository: https://github.com/rabestro/awk-maze-generator
#
# These variables are initialized on the command line (using '-v'):
# - Rows
# - Cols
#
function die(message) {print message > "/dev/stderr"; exit 1}
function assert(condition, message) {if (!condition) die(message)}

BEGIN {
    ExpectedCols = Cols * 2 + 1
    ExpectedRows = Rows * 2 + 1
    FPAT = "."
    OFS = ""
}
NF != ExpectedCols {
    die("Error: expected " ExpectedCols " columns, got " NF " at line " NR)
}
NR > ExpectedRows {
    die("Error: expected no more then " ExpectedRows " rows, got " NR)
}
{
    ++Height
}
Height == 1 && !/┌[─┬]+┐/ {
    die("Error: an invalid pattern of the top border")
}
$1 == "⇨" {
    assert(!StartRow, "Error: multiple start points at line " NR)
    assert(Height % 2 == 0, "Error: start point must be at the even row")
    StartRow = Height
}
$NF == "⇨" {
    if (EndRow) die("Error: multiple end points at line " NR)
    assert(Height % 2 == 0, "Error: end point must be at the even row")
    EndRow = Height
}
{
    for (; NF; --NF) Grid[Height, NF] = $NF
}
ENDFILE {
    assert(StartRow, "Error: no start point")
    assert(EndRow, "Error: no end point")
    assert(Height == ExpectedRows, "Error: expected " ExpectedRows " rows, got " Height)
    check_symbols()
    fill_spaces(2, 2)
    check_vertices()
    print "The maze is perfect."
}

function check_symbols(   row,col,cell) {
    for (row = ExpectedRows; row; --row)
        for (col = ExpectedCols; col; --col) {
            cell = Grid[row, col]
            if (row == 1 || row == ExpectedRows || col == 1 || col == ExpectedCols) {
                assert(cell != " ", "Error: border at " row "," col " is empty")
            }
            if (row % 2 == 0 && col % 2 == 0) {
                assert(cell == " ", "Error: vertex at " row "," col " is not empty")
            }
            if (cell != " " && cell != "⇨") {
                assert(cell == symbol(row, col), "Error: invalid symbol '" cell "' at " row "," col ". Expected: '" symbol(row, col) "'")
            }
        }
}

function symbol(row, col,   n,e,s,w) {
    n = row > 1 && Grid[row - 1, col] != " "
    e = col < ExpectedCols && Grid[row, col + 1] != " "
    s = row < ExpectedRows && Grid[row + 1, col] != " "
    w = col > 1 && Grid[row, col - 1] != " "
    return substr(" │─└││┌├─┘─┴┐┤┬┼", 1 + n + 2 * e + 4 * s + 8 * w, 1)
}

function fill_spaces(row, col,   directions,randDir,dx,dy) {
    assert(Grid[row, col] == " ", "Error: an extra passage detected at " row "," col)
    Grid[row, col] = "·"

    directions = "NESW"
    while (length(directions)) {
        randDir = substr(directions, 1, 1)
        sub(randDir, "", directions)
        dx = dy = 0
        if (randDir == "N") dy = -1
        if (randDir == "E") dx = 1
        if (randDir == "S") dy = 1
        if (randDir == "W") dx = -1
        if (Grid[row + dy, col + dx] == " ") {
            Grid[row + dy, col + dx] = "·"
            fill_spaces(row + 2 * dy, col + 2 * dx)
        }
    }
}

function check_vertices(   row,col) {
    for (row = 2; row < ExpectedRows; row += 2)
        for (col = 2; col < ExpectedCols; col += 2)
            assert(Grid[row, col] != " ", "Error: vertex at " row "," col " is not reachable")
}
