# These variables are initialized on the command line (using '-v'):
# - len

BEGIN {
    FS = ""
}

!NF      { print "series cannot be empty" > "/dev/stderr"; exit(1) }
len == 0 { print "slice length cannot be zero" > "/dev/stderr"; exit(1) }
len < 0  { print "slice length cannot be negative" > "/dev/stderr"; exit(1) }
len > NF { print "slice length cannot be greater than series length" > "/dev/stderr"; exit(1) }

{
    out = ""
    for (start = 1; start <= NF - len + 1; start++ ) {
        if (start > 1)
            out = out " "
        for (i = 0; i < len; i++)
            out = out $(start + i)
    }
    print out
}
