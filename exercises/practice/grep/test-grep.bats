#!/usr/bin/env bats
load bats-extra

setup() {

    cat > iliad.txt <<END_ILIAD
Achilles sing, O Goddess! Peleus' son;
His wrath pernicious, who ten thousand woes
Caused to Achaia's host, sent many a soul
Illustrious into Ades premature,
And Heroes gave (so stood the will of Jove)
To dogs and to all ravening fowls a prey,
When fierce dispute had separated once
The noble Chief Achilles from the son
Of Atreus, Agamemnon, King of men.
END_ILIAD

    cat > midsummer-night.txt <<END_MIDSUMMER
I do entreat your grace to pardon me.
I know not by what power I am made bold,
Nor how it may concern my modesty,
In such a presence here to plead my thoughts;
But I beseech your grace that I may know
The worst that may befall me in this case,
If I refuse to wed Demetrius.
END_MIDSUMMER

    cat > paradise-lost.txt <<END_PARADISE
Of Mans First Disobedience, and the Fruit
Of that Forbidden Tree, whose mortal tast
Brought Death into the World, and all our woe,
With loss of Eden, till one greater Man
Restore us, and regain the blissful Seat,
Sing Heav'nly Muse, that on the secret top
Of Oreb, or of Sinai, didst inspire
That Shepherd, who first taught the chosen Seed
END_PARADISE
}

teardown() {
    rm -f iliad.txt midsummer-night.txt paradise-lost.txt
}

# Test grepping a single file

@test "One file, one match, no flags" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v pattern="Agamemnon" iliad.txt

    assert_success
    assert_output "Of Atreus, Agamemnon, King of men."
}

@test "One file, one match, print line numbers flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="n" -v pattern="Forbidden" paradise-lost.txt

    assert_success
    assert_output "2:Of that Forbidden Tree, whose mortal tast"
}

@test "One file, one match, case-insensitive flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="i" -v pattern="FORBIDDEN" paradise-lost.txt

    assert_success
    assert_output "Of that Forbidden Tree, whose mortal tast"
}

@test "One file, one match, print file names flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="l" -v pattern="Forbidden" paradise-lost.txt

    assert_success
    assert_output "paradise-lost.txt"
}

@test "One file, one match, match entire lines flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v pattern="With loss of Eden, till one greater Man" paradise-lost.txt

    assert_success
    assert_output "With loss of Eden, till one greater Man"
}

@test "One file, one match, multiple flags" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="n i x" -v pattern="OF ATREUS, Agamemnon, KIng of MEN." iliad.txt

    assert_success
    assert_output "9:Of Atreus, Agamemnon, King of men."
}

@test "One file, several matches, no flags" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v pattern="may" midsummer-night.txt

    assert_success
    assert_line --index 0 -- "Nor how it may concern my modesty,"
    assert_line --index 1 -- "But I beseech your grace that I may know"
    assert_line --index 2 -- "The worst that may befall me in this case,"
    assert_equal "${#lines[@]}" 3
}

@test "One file, several matches, print line numbers flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="n" -v pattern="may" midsummer-night.txt

    assert_success
    assert_line --index 0 -- "3:Nor how it may concern my modesty,"
    assert_line --index 1 -- "5:But I beseech your grace that I may know"
    assert_line --index 2 -- "6:The worst that may befall me in this case,"
    assert_equal "${#lines[@]}" 3
}

@test "One file, several matches, match entire lines flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="x" -v pattern="may" midsummer-night.txt

    assert_failure
    assert_output ""
}

@test "One file, several matches, case-insensitive flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="i" -v pattern="ACHILLES" iliad.txt

    assert_success
    assert_line --index 0 -- "Achilles sing, O Goddess! Peleus' son;"
    assert_line --index 1 -- "The noble Chief Achilles from the son"
    assert_equal "${#lines[@]}" 2
}

@test "One file, several matches, inverted flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="v" -v pattern="Of" paradise-lost.txt

    assert_success
    assert_line --index 0 -- "Brought Death into the World, and all our woe,"
    assert_line --index 1 -- "With loss of Eden, till one greater Man"
    assert_line --index 2 -- "Restore us, and regain the blissful Seat,"
    assert_line --index 3 -- "Sing Heav'nly Muse, that on the secret top"
    assert_line --index 4 -- "That Shepherd, who first taught the chosen Seed"
    assert_equal "${#lines[@]}" 5
}

@test "One file, no matches, various flags" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="n l x i" -v pattern="Gandalf" iliad.txt

    assert_failure
    assert_output ""
}

@test "One file, one match, file flag takes precedence over line flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="n l" -v pattern="ten" iliad.txt

    assert_success
    assert_output "iliad.txt"
}

@test "One file, several matches, inverted and match entire lines flags" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="x v" -v pattern="Illustrious into Ades premature," iliad.txt

    assert_success
    assert_line --index 0 -- "Achilles sing, O Goddess! Peleus' son;"
    assert_line --index 1 -- "His wrath pernicious, who ten thousand woes"
    assert_line --index 2 -- "Caused to Achaia's host, sent many a soul"
    assert_line --index 3 -- "And Heroes gave (so stood the will of Jove)"
    assert_line --index 4 -- "To dogs and to all ravening fowls a prey,"
    assert_line --index 5 -- "When fierce dispute had separated once"
    assert_line --index 6 -- "The noble Chief Achilles from the son"
    assert_line --index 7 -- "Of Atreus, Agamemnon, King of men."
    assert_equal "${#lines[@]}" 8
}

# Multiple files

@test "Multiple files, one match, no flags" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v pattern="Agamemnon" iliad.txt midsummer-night.txt paradise-lost.txt

    assert_success
    assert_output "iliad.txt:Of Atreus, Agamemnon, King of men."
}

@test "Multiple files, several matches, no flags" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v pattern="may" iliad.txt midsummer-night.txt paradise-lost.txt

    assert_success
    assert_line --index 0 -- "midsummer-night.txt:Nor how it may concern my modesty,"
    assert_line --index 1 -- "midsummer-night.txt:But I beseech your grace that I may know"
    assert_line --index 2 -- "midsummer-night.txt:The worst that may befall me in this case,"
    assert_equal "${#lines[@]}" 3
}

@test "Multiple files, several matches, print line numbers flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="n" -v pattern="that" iliad.txt midsummer-night.txt paradise-lost.txt

    assert_success
    assert_line --index 0 -- "midsummer-night.txt:5:But I beseech your grace that I may know"
    assert_line --index 1 -- "midsummer-night.txt:6:The worst that may befall me in this case,"
    assert_line --index 2 -- "paradise-lost.txt:2:Of that Forbidden Tree, whose mortal tast"
    assert_line --index 3 -- "paradise-lost.txt:6:Sing Heav'nly Muse, that on the secret top"
    assert_equal "${#lines[@]}" 4
}

@test "Multiple files, one match, print file names flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="l" -v pattern="who" iliad.txt midsummer-night.txt paradise-lost.txt

    assert_success
    assert_line --index 0 -- "iliad.txt"
    assert_line --index 1 -- "paradise-lost.txt"
    assert_equal "${#lines[@]}" 2
}

@test "Multiple files, several matches, case-insensitive flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="i" -v pattern="TO" iliad.txt midsummer-night.txt paradise-lost.txt

    assert_success
    assert_line --index 0 -- "iliad.txt:Caused to Achaia's host, sent many a soul"
    assert_line --index 1 -- "iliad.txt:Illustrious into Ades premature,"
    assert_line --index 2 -- "iliad.txt:And Heroes gave (so stood the will of Jove)"
    assert_line --index 3 -- "iliad.txt:To dogs and to all ravening fowls a prey,"
    assert_line --index 4 -- "midsummer-night.txt:I do entreat your grace to pardon me."
    assert_line --index 5 -- "midsummer-night.txt:In such a presence here to plead my thoughts;"
    assert_line --index 6 -- "midsummer-night.txt:If I refuse to wed Demetrius."
    assert_line --index 7 -- "paradise-lost.txt:Brought Death into the World, and all our woe,"
    assert_line --index 8 -- "paradise-lost.txt:Restore us, and regain the blissful Seat,"
    assert_line --index 9 -- "paradise-lost.txt:Sing Heav'nly Muse, that on the secret top"
    assert_equal "${#lines[@]}" 10
}

@test "Multiple files, several matches, inverted flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="v" -v pattern="a" iliad.txt midsummer-night.txt paradise-lost.txt

    assert_success
    assert_line --index 0 -- "iliad.txt:Achilles sing, O Goddess! Peleus' son;"
    assert_line --index 1 -- "iliad.txt:The noble Chief Achilles from the son"
    assert_line --index 2 -- "midsummer-night.txt:If I refuse to wed Demetrius."
    assert_equal "${#lines[@]}" 3
}

@test "Multiple files, one match, match entire lines flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="x" -v pattern="But I beseech your grace that I may know" iliad.txt midsummer-night.txt paradise-lost.txt

    assert_success
    assert_output "midsummer-night.txt:But I beseech your grace that I may know"
}

@test "Multiple files, one match, multiple flags" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="n i x" -v pattern="WITH LOSS OF EDEN, TILL ONE GREATER MAN" iliad.txt midsummer-night.txt paradise-lost.txt

    assert_success
    assert_output "paradise-lost.txt:4:With loss of Eden, till one greater Man"
}

@test "Multiple files, no matches, various flags" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="n l i x" -v pattern="Frodo" iliad.txt midsummer-night.txt paradise-lost.txt

    assert_failure
    assert_output ""
}

@test "Multiple files, several matches, file flag takes precedence over line number flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="n l" -v pattern="who" iliad.txt midsummer-night.txt paradise-lost.txt

    assert_success
    assert_line --index 0 -- "iliad.txt"
    assert_line --index 1 -- "paradise-lost.txt"
    assert_equal "${#lines[@]}" 2
}

@test "Multiple files, several matches, inverted and match entire lines flags" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="x v" -v pattern="Illustrious into Ades premature," iliad.txt midsummer-night.txt paradise-lost.txt

    assert_success
    assert_line --index 0 -- "iliad.txt:Achilles sing, O Goddess! Peleus' son;"
    assert_line --index 1 -- "iliad.txt:His wrath pernicious, who ten thousand woes"
    assert_line --index 2 -- "iliad.txt:Caused to Achaia's host, sent many a soul"
    assert_line --index 3 -- "iliad.txt:And Heroes gave (so stood the will of Jove)"
    assert_line --index 4 -- "iliad.txt:To dogs and to all ravening fowls a prey,"
    assert_line --index 5 -- "iliad.txt:When fierce dispute had separated once"
    assert_line --index 6 -- "iliad.txt:The noble Chief Achilles from the son"
    assert_line --index 7 -- "iliad.txt:Of Atreus, Agamemnon, King of men."
    assert_line --index 8 -- "midsummer-night.txt:I do entreat your grace to pardon me."
    assert_line --index 9 -- "midsummer-night.txt:I know not by what power I am made bold,"
    assert_line --index 10 -- "midsummer-night.txt:Nor how it may concern my modesty,"
    assert_line --index 11 -- "midsummer-night.txt:In such a presence here to plead my thoughts;"
    assert_line --index 12 -- "midsummer-night.txt:But I beseech your grace that I may know"
    assert_line --index 13 -- "midsummer-night.txt:The worst that may befall me in this case,"
    assert_line --index 14 -- "midsummer-night.txt:If I refuse to wed Demetrius."
    assert_line --index 15 -- "paradise-lost.txt:Of Mans First Disobedience, and the Fruit"
    assert_line --index 16 -- "paradise-lost.txt:Of that Forbidden Tree, whose mortal tast"
    assert_line --index 17 -- "paradise-lost.txt:Brought Death into the World, and all our woe,"
    assert_line --index 18 -- "paradise-lost.txt:With loss of Eden, till one greater Man"
    assert_line --index 19 -- "paradise-lost.txt:Restore us, and regain the blissful Seat,"
    assert_line --index 20 -- "paradise-lost.txt:Sing Heav'nly Muse, that on the secret top"
    assert_line --index 21 -- "paradise-lost.txt:Of Oreb, or of Sinai, didst inspire"
    assert_line --index 22 -- "paradise-lost.txt:That Shepherd, who first taught the chosen Seed"
    assert_equal "${#lines[@]}" 23
}

# awk-specific tests: actual regular expressions

@test "regular expression" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="i n" -v pattern="i.*d." midsummer-night.txt

    assert_success
    assert_line --index 0 -- "1:I do entreat your grace to pardon me."
    assert_line --index 1 -- "2:I know not by what power I am made bold,"
    assert_line --index 2 -- "3:Nor how it may concern my modesty,"
    assert_line --index 3 -- "4:In such a presence here to plead my thoughts;"
    assert_line --index 4 -- "7:If I refuse to wed Demetrius."
    assert_equal "${#lines[@]}" 5
}

# awk-specific tests: actual regular expressions
@test "same regular expression with -x flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="i n x" -v pattern="i.*d." midsummer-night.txt

    assert_success
    assert_output "2:I know not by what power I am made bold,"
}
