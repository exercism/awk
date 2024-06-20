# Variables declared on the command line
#       start
#       end

BEGIN {
    split("fly,spider,bird,cat,dog,goat,cow,horse", critters, /,/)
    
    exclamations["fly"] = "I don't know why she swallowed the fly. Perhaps she'll die."
    exclamations["spider"] = "It wriggled and jiggled and tickled inside her."
    exclamations["bird"] = "How absurd to swallow a bird!"
    exclamations["cat"] = "Imagine that, to swallow a cat!"
    exclamations["dog"] = "What a hog, to swallow a dog!"
    exclamations["goat"] = "Just opened her throat and swallowed a goat!"
    exclamations["cow"] = "I don't know how she swallowed a cow!"
    exclamations["horse"] = "She's dead, of course!"

    separator = ""
    for (i = start; i <= end; i++) {
        printf "%s", separator
        verse(i)
        separator = "\n"
    }
}

function verse(i    ,j) {
    printf "I know an old lady who swallowed a %s.\n", critters[i]
    print exclamations[critters[i]]
    if (critters[i] == "horse") return
    if (critters[i] != "fly") {
        for (j = i - 1; j >= 1; j--) {
            printf "She swallowed the %s to catch the %s", critters[j + 1], critters[j]
            if (critters[j] == "spider")
                printf " that wriggled and jiggled and tickled inside her"
            printf ".\n"
        }
        print exclamations["fly"]
    }
}
