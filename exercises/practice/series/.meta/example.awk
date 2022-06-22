# These variables are initialized on the command line (using '-v'):
# - len

BEGIN {
    FS = ""
}

! NF {
    print("series cannot be empty")
    exit(1)
}

len > NF || len < 1 {
    print("invalid length")
    exit(1)
}

{
    out = ""
    for (start = 1; start <= NF - len + 1; start++ ) {
        if (start > 1)
            out = out " "
        for (i = 0; i < len; i++)
            out = out $(start + i)
    }
    print(out)
}
