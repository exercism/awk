@include "join"

BEGIN {
    FS = ","

    n = split("eggs,peanuts,shellfish,strawberries,tomatoes,chocolate,pollen,cats", tmp)
    for (i = 1; i <= n; i++)
        allergies[tmp[i]] = i - 1

    PROCINFO["sorted_in"] = "@val_num_asc"
}

$2 == "allergic_to" {
    print is_allergic_to($1, $3) ? "true" : "false"
}

$2 == "list" {
    n = list_allergies($1, list)
    print join(list, 1, n, FS)
}

function is_allergic_to(score, allergen) {
    return and(rshift(score, allergies[allergen]), 1) == 1
}

function list_allergies(score, result,    i) {
    for (allergen in allergies)
        if (is_allergic_to(score, allergen))
            result[++i] = allergen
    return 0 + i
}

