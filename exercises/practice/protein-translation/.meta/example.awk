BEGIN {
    translation["AUG"] = "Methionine"
    translation["UUU"] = "Phenylalanine"
    translation["UUC"] = "Phenylalanine"
    translation["UUA"] = "Leucine"
    translation["UUG"] = "Leucine"
    translation["UCU"] = "Serine"
    translation["UCC"] = "Serine"
    translation["UCA"] = "Serine"
    translation["UCG"] = "Serine"
    translation["UAU"] = "Tyrosine"
    translation["UAC"] = "Tyrosine"
    translation["UGU"] = "Cysteine"
    translation["UGC"] = "Cysteine"
    translation["UGG"] = "Tryptophan"
    translation["UAA"] = "STOP"
    translation["UAG"] = "STOP"
    translation["UGA"] = "STOP"

    FPAT = "..."
}

{
    out = ""
    for (i = 1; i <= NF; i++) {
        if (! translation[$i]) {
            print("Invalid codon")
            exit(1)
        }
        if (translation[$i] == "STOP")
            break
        if (i > 1)
            out = out " "
        out = out translation[$i]
    }
    if (length % 3 && translation[$i] != "STOP") {
        print("Invalid codon")
        exit(1)
    }

    print(out)
}
