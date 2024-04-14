{
    for (i = 1; i < NF; i++)
        print "For want of a " $i " the " $(i + 1) " was lost."
}
NF {
    print "And all for the want of a " $1 "."
}
