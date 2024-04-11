# These variables are initialized on the command line (using '-v'):
# - startBottles
# - takeDown

BEGIN {
    split("One Two Three Four Five Six Seven Eight Nine Ten", Numbers)

    while (takeDown--) {
        print_verse(startBottles--)
        if (takeDown) print ""
    }
}

function print_verse(bottles) {
    print first_line(bottles)
    print first_line(bottles)
    print "And if one green bottle should accidentally fall,"
    print last_line(bottles - 1)
}

function first_line(bottles) {
    return Numbers[bottles] hanging(bottles) ","
}

function last_line(bottles) {
    return "There'll be " tolower(bottles == 0 ? "no" : Numbers[bottles]) hanging(bottles) "."
}

function hanging(bottles) {
    return " green bottle" (bottles == 1 ? "" : "s") " hanging on the wall"
}
