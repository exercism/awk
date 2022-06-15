#!/usr/bin/env bats
load bats-extra

setup() {
    # note that the redirection `<<-` (with the hyphen) allows
    # leading _tabs_ at the start of lines to improve readability:
    # don't change the tabs to spaces.

    cat > iliad.txt <<-END_ILIAD
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

    cat > midsummer-night.txt <<-END_MIDSUMMER
	I do entreat your grace to pardon me.
	I know not by what power I am made bold,
	Nor how it may concern my modesty,
	In such a presence here to plead my thoughts;
	But I beseech your grace that I may know
	The worst that may befall me in this case,
	If I refuse to wed Demetrius.
	END_MIDSUMMER

    cat > paradise-lost.txt <<-END_PARADISE
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
    assert_output "Nor how it may concern my modesty,
But I beseech your grace that I may know
The worst that may befall me in this case,"
}

@test "One file, several matches, print line numbers flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="n" -v pattern="may" midsummer-night.txt

    assert_success
    assert_output "3:Nor how it may concern my modesty,
5:But I beseech your grace that I may know
6:The worst that may befall me in this case,"
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
    assert_output "Achilles sing, O Goddess! Peleus' son;
The noble Chief Achilles from the son"
}

@test "One file, several matches, inverted flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="v" -v pattern="Of" paradise-lost.txt

    assert_success
    assert_output "Brought Death into the World, and all our woe,
With loss of Eden, till one greater Man
Restore us, and regain the blissful Seat,
Sing Heav'nly Muse, that on the secret top
That Shepherd, who first taught the chosen Seed"
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
    assert_output "Achilles sing, O Goddess! Peleus' son;
His wrath pernicious, who ten thousand woes
Caused to Achaia's host, sent many a soul
And Heroes gave (so stood the will of Jove)
To dogs and to all ravening fowls a prey,
When fierce dispute had separated once
The noble Chief Achilles from the son
Of Atreus, Agamemnon, King of men."
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
    assert_output "midsummer-night.txt:Nor how it may concern my modesty,
midsummer-night.txt:But I beseech your grace that I may know
midsummer-night.txt:The worst that may befall me in this case,"
}

@test "Multiple files, several matches, print line numbers flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="n" -v pattern="that" iliad.txt midsummer-night.txt paradise-lost.txt

    assert_success
    assert_output "midsummer-night.txt:5:But I beseech your grace that I may know
midsummer-night.txt:6:The worst that may befall me in this case,
paradise-lost.txt:2:Of that Forbidden Tree, whose mortal tast
paradise-lost.txt:6:Sing Heav'nly Muse, that on the secret top"
}

@test "Multiple files, one match, print file names flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="l" -v pattern="who" iliad.txt midsummer-night.txt paradise-lost.txt

    assert_success
    assert_output "iliad.txt
paradise-lost.txt"
}

@test "Multiple files, several matches, case-insensitive flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="i" -v pattern="TO" iliad.txt midsummer-night.txt paradise-lost.txt

    assert_success
    assert_output "iliad.txt:Caused to Achaia's host, sent many a soul
iliad.txt:Illustrious into Ades premature,
iliad.txt:And Heroes gave (so stood the will of Jove)
iliad.txt:To dogs and to all ravening fowls a prey,
midsummer-night.txt:I do entreat your grace to pardon me.
midsummer-night.txt:In such a presence here to plead my thoughts;
midsummer-night.txt:If I refuse to wed Demetrius.
paradise-lost.txt:Brought Death into the World, and all our woe,
paradise-lost.txt:Restore us, and regain the blissful Seat,
paradise-lost.txt:Sing Heav'nly Muse, that on the secret top"
}

@test "Multiple files, several matches, inverted flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="v" -v pattern="a" iliad.txt midsummer-night.txt paradise-lost.txt

    assert_success
    assert_output "iliad.txt:Achilles sing, O Goddess! Peleus' son;
iliad.txt:The noble Chief Achilles from the son
midsummer-night.txt:If I refuse to wed Demetrius."
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
    assert_output "iliad.txt
paradise-lost.txt"
}

@test "Multiple files, several matches, inverted and match entire lines flags" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="x v" -v pattern="Illustrious into Ades premature," iliad.txt midsummer-night.txt paradise-lost.txt

    assert_success
    assert_output "iliad.txt:Achilles sing, O Goddess! Peleus' son;
iliad.txt:His wrath pernicious, who ten thousand woes
iliad.txt:Caused to Achaia's host, sent many a soul
iliad.txt:And Heroes gave (so stood the will of Jove)
iliad.txt:To dogs and to all ravening fowls a prey,
iliad.txt:When fierce dispute had separated once
iliad.txt:The noble Chief Achilles from the son
iliad.txt:Of Atreus, Agamemnon, King of men.
midsummer-night.txt:I do entreat your grace to pardon me.
midsummer-night.txt:I know not by what power I am made bold,
midsummer-night.txt:Nor how it may concern my modesty,
midsummer-night.txt:In such a presence here to plead my thoughts;
midsummer-night.txt:But I beseech your grace that I may know
midsummer-night.txt:The worst that may befall me in this case,
midsummer-night.txt:If I refuse to wed Demetrius.
paradise-lost.txt:Of Mans First Disobedience, and the Fruit
paradise-lost.txt:Of that Forbidden Tree, whose mortal tast
paradise-lost.txt:Brought Death into the World, and all our woe,
paradise-lost.txt:With loss of Eden, till one greater Man
paradise-lost.txt:Restore us, and regain the blissful Seat,
paradise-lost.txt:Sing Heav'nly Muse, that on the secret top
paradise-lost.txt:Of Oreb, or of Sinai, didst inspire
paradise-lost.txt:That Shepherd, who first taught the chosen Seed"
}

# awk-specific tests: actual regular expressions

@test "regular expression" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="i n" -v pattern="i.*d." midsummer-night.txt

    assert_success
    assert_output "1:I do entreat your grace to pardon me.
2:I know not by what power I am made bold,
3:Nor how it may concern my modesty,
4:In such a presence here to plead my thoughts;
7:If I refuse to wed Demetrius."
}

# awk-specific tests: actual regular expressions
@test "same regular expression with -x flag" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grep.awk -v flags="i n x" -v pattern="i.*d." midsummer-night.txt

    assert_success
    assert_output "2:I know not by what power I am made bold,"
}
