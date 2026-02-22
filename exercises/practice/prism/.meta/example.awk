# The first line of input is the starting x, y and angle.
# Any remaining input is the prisms: x, y, angle and ID.
# The program is expected to print out prism IDs, space separated on one line.

function abs(n) {
    return (n > 0) ? n : -n
}

# Starting position
NR == 1 { x = $1; y = $2; a = $3; }

# Prism positions
NR > 1 { prisms[$1]["x"] = $2; prisms[$1]["y"] = $3; prisms[$1]["a"] = $4; }

# Compute the path
END {
    # Loop for hits until no more are found.
    deg_to_rad = 3.141592 / 180
    do {
        found = 0
        distance = 0
        for (id in prisms) {
            # Do not count a prism we just hit.
            if (prisms[id]["x"] == x && prisms[id]["y"] == y) {
                continue
            }
            dx = prisms[id]["x"] - x
            dy = prisms[id]["y"] - y
            r = sqrt(dx * dx + dy * dy)
            # How close did we get to the prism?
            hx = abs(cos(a * deg_to_rad) * r - dx)
            hy = abs(sin(a * deg_to_rad) * r - dy)
            if (hx < 0.1 && hy < 0.1) {
                # Track the closest prism along the laser path
                if (!found || r < distance) {
                    fid = id
                    distance = r
                }
                found = 1
            }
        }
        if (found) {
            x = prisms[fid]["x"]
            y = prisms[fid]["y"]
            a += prisms[fid]["a"]
            out[count++] = fid
        }
    } while (found == 1)

    # Print the prisms we hit, space separated IDs
    if (count) {
        res = out[0]
        for (j = 1; j < count; j++) {
            res = res " " out[j]
        }
        print res
    }
}
