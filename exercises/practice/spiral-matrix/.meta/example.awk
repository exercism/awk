@include "join.awk"

# `size` variable comes from command-line

BEGIN {
    x = y = 1
    dx = 0
    dy = 1

    for (i = 1; i <= size * size; i++) {
        m[x][y] = i
        if (x + dx < 1 || x + dx > size ||
            y + dy < 1 || y + dy > size ||
            m[x + dx][y + dy] != "")
        {
            tmp = dx
            dx = dy
            dy = -tmp
        }
        x += dx
        y += dy
    }

    for (x = 1; x <= size; x++) {
        print join(m[x], 1, size)
    }
}
