BEGIN {
    split("black brown red orange yellow green blue violet grey white", colors)
    split("kilo mega giga", units)
}

function value(color) {
    for (i = 1; i <= length(colors); i++)
        if (colors[i] == color)
            return i - 1
    print("invalid color")
    exit(1)
}

{
    # Compute the resistance.
    ohms = (value($1) * 10 +  value($2)) * 10 ** value($3)
    # Convert to unit values.
    while (ohms && ohms % 1000 == 0) {
        shifted++
        ohms /= 1000
    }
    print(ohms " " units[shifted] "ohms")
}

