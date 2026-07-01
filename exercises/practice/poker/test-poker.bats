#!/usr/bin/env bats
load bats-extra

# generated on 2026-06-30T20:53:15+00:00

@test "single hand always wins" {
    # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
4S 5S 7H 8D JC
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
4S 5S 7H 8D JC
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "highest card out of all hands wins" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
3S 4S 5D 6H JH
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
4D 5S 6S 8D 3C
2S 4C 7S 9H 10H
3S 4S 5D 6H JH
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "a tie has multiple winners" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
3S 4S 5D 6H JH
3H 4H 5C 6C JD
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
4D 5S 6S 8D 3C
2S 4C 7S 9H 10H
3S 4S 5D 6H JH
3H 4H 5C 6C JD
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "multiple hands with the same high cards, tie compares next highest ranked, down to last card" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
3S 5H 6S 8D 7H
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
3S 5H 6S 8D 7H
2S 5D 6D 8C 7S
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "winning high card hand also has the lowest card" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
2S 5H 6S 8D 7H
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
2S 5H 6S 8D 7H
3S 4D 6D 8C 7S
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "one pair beats high card" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
2S 4H 6S 4D JH
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
4S 5H 6C 8D KH
2S 4H 6S 4D JH
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "highest pair wins" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
2S 4H 6C 4D JD
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
4S 2H 6S 2D JH
2S 4H 6C 4D JD
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "both hands have the same pair, high card wins" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
4H 4S AH JC 3D
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
4H 4S AH JC 3D
4C 4D AS 5D 6C
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "two pairs beats one pair" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
4S 5H 4C 8C 5C
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
2S 8H 6S 8D JH
4S 5H 4C 8C 5C
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "both hands have two pairs, highest ranked pair wins" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
2S 8H 2D 8D 3H
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
2S 8H 2D 8D 3H
4S 5H 4C 8S 5D
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "both hands have two pairs, with the same highest ranked pair, tie goes to low pair" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
JD QH JS 8D QC
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
2S QS 2C QD JH
JD QH JS 8D QC
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "both hands have two identically ranked pairs, tie goes to remaining card (kicker)" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
JD QH JS 8D QC
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
JD QH JS 8D QC
JS QS JC 2D QD
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "both hands have two pairs that add to the same value, win goes to highest pair" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
7H 7S 2H 2S AC
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
6S 6H 3S 3H AS
7H 7S 2H 2S AC
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "two pairs first ranked by largest pair" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
6S 2S 6H 7C 2C
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
5C 2S 5S 4H 4C
6S 2S 6H 7C 2C
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "three of a kind beats two pair" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
4S 5H 4C 8S 4H
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
2S 8H 2H 8D JH
4S 5H 4C 8S 4H
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "both hands have three of a kind, tie goes to highest ranked triplet" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
4S AH AS 8C AD
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
2S 2H 2C 8D JH
4S AH AS 8C AD
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "with multiple decks, two players can have same three of a kind, ties go to highest remaining cards" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
4S AH AS 8C AD
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
5S AH AS 7C AD
4S AH AS 8C AD
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "a straight beats three of a kind" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
3S 4D 2S 6D 5C
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
4S 5H 4C 8D 4H
3S 4D 2S 6D 5C
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "aces can end a straight (10 J Q K A)" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
10D JH QS KD AC
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
4S 5H 4C 8D 4H
10D JH QS KD AC
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "aces can start a straight (A 2 3 4 5)" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
4D AH 3S 2D 5C
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
4S 5H 4C 8D 4H
4D AH 3S 2D 5C
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "aces cannot be in the middle of a straight (Q K A 2 3)" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
2C 3D 7H 5H 2S
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
2C 3D 7H 5H 2S
QS KH AC 2D 3S
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "both hands with a straight, tie goes to highest ranked card" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
5S 7H 8S 9D 6H
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
4S 6C 7S 8D 5H
5S 7H 8S 9D 6H
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "even though an ace is usually high, a 5-high straight is the lowest-scoring straight" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
2H 3C 4D 5D 6H
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
2H 3C 4D 5D 6H
4S AH 3S 2D 5H
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "flush beats a straight" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
2S 4S 5S 6S 7S
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
4C 6H 7D 8D 5H
2S 4S 5S 6S 7S
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "both hands have a flush, tie goes to high card, down to the last one if necessary" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
2H 7H 8H 9H 6H
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
2H 7H 8H 9H 6H
3S 5S 6S 7S 8S
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "full house beats a flush" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
4S 5H 4C 5D 4H
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
3H 6H 7H 8H 5H
4S 5H 4C 5D 4H
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "both hands have a full house, tie goes to highest-ranked triplet" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
5H 5S 5D 8S 8D
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
4H 4S 4D 9S 9D
5H 5S 5D 8S 8D
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "with multiple decks, both hands have a full house with the same triplet, tie goes to the pair" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
5H 5S 5D 9S 9D
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
5H 5S 5D 9S 9D
5H 5S 5D 8S 8D
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "four of a kind beats a full house" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
3S 3H 2S 3D 3C
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
4S 5H 4D 5D 4H
3S 3H 2S 3D 3C
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "both hands have four of a kind, tie goes to high quad" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
4S 5H 5S 5D 5C
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
2S 2H 2C 8D 2D
4S 5H 5S 5D 5C
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "with multiple decks, both hands with identical four of a kind, tie determined by kicker" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
3S 3H 4S 3D 3C
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
3S 3H 2S 3D 3C
3S 3H 4S 3D 3C
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "straight flush beats four of a kind" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
7S 8S 9S 6S 10S
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
4S 5H 5S 5D 5C
7S 8S 9S 6S 10S
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "aces can end a straight flush (10 J Q K A)" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
10C JC QC KC AC
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
KC AH AS AD AC
10C JC QC KC AC
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "aces can start a straight flush (A 2 3 4 5)" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
4H AH 3H 2H 5H
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
KS AH AS AD AC
4H AH 3H 2H 5H
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "aces cannot be in the middle of a straight flush (Q K A 2 3)" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
2C AC QC 10C KC
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
2C AC QC 10C KC
QH KH AH 2H 3H
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "both hands have a straight flush, tie goes to highest-ranked card" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
5S 7S 8S 9S 6S
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
4H 6H 7H 8H 5H
5S 7S 8S 9S 6S
END_INPUT
    assert_success
    assert_output "$expected"
}

@test "even though an ace is usually high, a 5-high straight flush is the lowest-scoring straight flush" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END_EXPECT
2H 3H 4H 5H 6H
END_EXPECT
)
    run gawk -f poker.awk <<END_INPUT
2H 3H 4H 5H 6H
4D AD 3D 2D 5D
END_INPUT
    assert_success
    assert_output "$expected"
}

