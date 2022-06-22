#!/usr/bin/env gawk -f

# These variables are initialized on the command line (using '-v'):
# - name

BEGIN {
    split("Alice Bob Charlie David Eve Fred Ginny Harriet Ileana Joseph Kincaid Larry", names)

    plants["G"] = "grass"
    plants["C"] = "clover"
    plants["V"] = "violets"
    plants["R"] = "radishes"

    FPAT = ".."
}

{
    for (i = 1; i <= NF; i++)
        plots[names[i]] = plots[names[i]] $i
}

END {
    n = split(plots[name], p, "")
    printf "%s", plants[p[1]]
    for (i = 2; i <= n; i++)
        printf " %s", plants[p[i]]
    printf "\n"
}
