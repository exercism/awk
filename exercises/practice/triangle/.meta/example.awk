# These variables are initialized on the command line (using '-v'):
# - type

{
    # A triangle must have non-zero size.
    perimeter = $1 + $2 + $3
    if (perimeter == 0) {
        print("false")
        exit(0)
    }

    # Any one side cannot be larger than both other sides.
    for (i = 1; i <= 3; i++) {
        if (2 * $i > perimeter) {
            print("false")
            exit(0)
        }
    }

    switch (type) {
    case "equilateral":
        result = ($1 == $2 && $2 == $3)
        break
    case "isosceles":
        result = ($1 == $2 || $2 == $3 || $1 == $3)
        break
    case "scalene":
        result = ($1 != $2 && $2 != $3 && $1 != $3)
        break
    }

    print(result ? "true" : "false")
}
