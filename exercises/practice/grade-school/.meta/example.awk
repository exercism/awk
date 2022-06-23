#!/usr/bin/env gawk -f

# These variables are initialized on the command line (using '-v'):
# - action
# - grade

BEGIN {
    PROCINFO["sorted_in"] = "roster_sort"
    FS = ","
}

!($1 in directory) {
    count++
    directory[$1] = $2
}

END {
    if (count)
        print count, "student(s) added"

    switch (action) {
        case "roster":
            for (name in directory)
                print name
            break
        case "grade":
            for (name in directory)
                if (directory[name] == grade)
                    print name
            break
    }
}

# index is the name, value is the grade
function roster_sort(i1, v1, i2, v2) {
    if (v1 != v2) return v1 - v2                 # sort first by grade
    if (i1 < i2) return -1; else return i1 > i2  # then by name
}
