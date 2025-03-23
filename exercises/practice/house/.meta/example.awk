#!/usr/bin/awk -f

# These variables are initialized on the command line (using '-v'):
# - start, end

BEGIN {
    if (start < 1 || end > 12 || start > end) {
        print "Error: invalid range. Start must be >= 1, end <= 12, and start <= end."
        exit 1
    }

    Phrase[0] = "the house that Jack built"
    Phrase[1] = "the malt that lay in"
    Phrase[2] = "the rat that ate"
    Phrase[3] = "the cat that killed"
    Phrase[4] = "the dog that worried"
    Phrase[5] = "the cow with the crumpled horn that tossed"
    Phrase[6] = "the maiden all forlorn that milked"
    Phrase[7] = "the man all tattered and torn that kissed"
    Phrase[8] = "the priest all shaven and shorn that married"
    Phrase[9] = "the rooster that crowed in the morn that woke"
    Phrase[10] = "the farmer sowing his corn that kept"
    Phrase[11] = "the horse and the hound and the horn that belonged to"

    for (v = start; v <= end; v++)
        print single_verse(v)
}

function single_verse(i,   out) {
    while (i--) out = out Phrase[i] (i ? " " : ".")
    return "This is " out
}
