BEGIN {
    split("black brown red orange yellow green blue violet grey white", colors)
}

function value(color) {
    for (i = 1; i <= length(colors); i++)
        if (colors[i] == color)
            return i - 1
    print("invalid color")
    exit(1)
}

{
    print(value($1) * 10 +  value($2))
}

