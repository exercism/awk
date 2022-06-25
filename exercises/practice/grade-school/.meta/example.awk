#!/usr/bin/env gawk -f

# These variables are initialized on the command line (using '-v'):
# - action
# - grade

BEGIN {
    PROCINFO["sorted_in"] = "roster_sort"
    FS = ","
}

!($1 in directory) {
    directory[$1] = $2
}

END {
    switch (action) {
        case "roster":
            for (name in directory)
                out = out "," name
            print substr(out, 2)
            break

        case "grade":
            for (name in directory)
                if (directory[name] == grade)
                    out = out "," name
            print substr(out, 2)
            break
    }
}

# index is the name, value is the grade
function roster_sort(i1, v1, i2, v2) {
    if (v1 != v2) return v1 - v2                 # sort first by grade
    if (i1 < i2) return -1; else return i1 > i2  # then by name
}
