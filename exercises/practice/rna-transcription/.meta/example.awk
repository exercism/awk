BEGIN {
    FS = ""
    translation["G"] = "C"
    translation["C"] = "G"
    translation["A"] = "U"
    translation["T"] = "A"

}

{
    out = ""
    for (i = 1; i <= NF; i++) {
        if ($i in translation) {
            out = out translation[$i]
        } else {
            print("Invalid nucleotide detected.")
            exit(1)
        }
    }
    print(out)
}
