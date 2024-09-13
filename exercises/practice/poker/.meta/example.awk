BEGIN {
    FPAT = "[1-9JQKA]"
    PROCINFO["sorted_in"] = "@ind_str_asc"
    BestRank = "X"
}
{
    Flush = /(.*S){5}|(.*D){5}|(.*C){5}|(.*H){5}/
    Hand = Rank = ""
    delete Cards
    for (i = 1; i <= NF; i++)
        Cards[substr("ABCDEFGHIJKLM", index("AKQJ198765432", $i), 1)]++
    for (key in Cards)
        Hand = Hand key Cards[key]
}
"A1B1C1D1E1F1G1H1I1J1K1L1M1 A1J1K1L1M1" ~ Hand {
    Rank = (Flush ? "A" : "E") (Hand ~ /^A1J1/ ? "J" : Hand)
}
!Rank && match(Hand, /(.1)?(.4)(.1)?/, m) {
    Rank = "B"m[2]m[1]m[3]
}
!Rank && match(Hand, /(.*)?(.3)(.*)?/, m){
    Rank = (Hand ~ /2/ ? "C" : "F")m[2]m[1]m[3]
}
!Rank && match(Hand, /(.1)?(.2)(.1)?(.2)(.1)?/, m) {
    Rank = "G"m[2]m[4]m[1]m[3]m[5]
}
!Rank && match(Hand, /^(.*)?(.2)(.*)?$/, m) {
    Rank = "H"m[2]m[1]m[3]
}
!Rank {
    Rank = (Flush ? "D" : "I") Hand
}
Rank == BestRank {
    BestHand = BestHand "\n" $0
}
Rank < BestRank {
    BestRank = Rank
    BestHand = $0
}
END {
    print BestHand
}
