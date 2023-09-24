#!/usr/bin/env bats
load bats-extra

@test "no matches" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f anagram.awk -v key=diaper <<WORD_LIST
hello
world
zombies
pants
WORD_LIST

    assert_success
    refute_output     # no output
}

@test "detects two anagrams" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f anagram.awk -v key=solemn <<WORD_LIST
lemons
cherry
melons
WORD_LIST

    assert_success
    assert_line "lemons"
    assert_line "melons"
    assert_equal ${#lines[@]} 2   # output has just 2 lines
}

@test "does not detect anagram subsets" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f anagram.awk -v key=good <<WORD_LIST
dog
goody
WORD_LIST

    assert_success
    refute_output
}

@test "detects anagram" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f anagram.awk -v key=listen <<WORD_LIST
enlists
google
inlets
banana
WORD_LIST

    assert_success
    assert_line "inlets"
    assert_equal ${#lines[@]} 1
}

@test "detects three anagrams" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f anagram.awk -v key=allergy <<WORD_LIST
gallery
ballerina
regally
clergy
largely
leading
WORD_LIST

    assert_success
    assert_line "gallery"
    assert_line "regally"
    assert_line "largely"
    assert_equal ${#lines[@]} 3
}

@test "detects multiple anagrams with different case" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f anagram.awk -v key=nose <<WORD_LIST
Eons
ONES
WORD_LIST

    assert_success
    assert_line "Eons"
    assert_line "ONES"
    assert_equal ${#lines[@]} 2
}

@test "does not detect non-anagrams with identical checksum" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f anagram.awk -v key=mass <<WORD_LIST
last
WORD_LIST

    assert_success
    refute_output
}

@test "detects anagrams case-insensitively" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f anagram.awk -v key=Orchestra <<WORD_LIST
cashregister
Carthorse
radishes
WORD_LIST

    assert_success
    assert_line "Carthorse"
    assert_equal ${#lines[@]} 1
}

@test "detects anagrams using case-insensitive subject" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f anagram.awk -v key=Orchestra <<WORD_LIST
cashregister
carthorse
radishes
WORD_LIST

    assert_success
    assert_line "carthorse"
    assert_equal ${#lines[@]} 1
}

@test "detects anagrams using case-insensitive possible matches" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f anagram.awk -v key=orchestra <<WORD_LIST
cashregister
Carthorse
radishes
WORD_LIST

    assert_success
    assert_line "Carthorse"
    assert_equal ${#lines[@]} 1
}

@test "does not detect a anagram if the original word is repeated" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f anagram.awk -v key=go <<WORD_LIST
goGoGO
WORD_LIST

    assert_success
    refute_output
}

@test "anagrams must use all letters exactly once" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f anagram.awk -v key=tapper <<WORD_LIST
patter
WORD_LIST

    assert_success
    refute_output
}

@test "words are not anagrams of themselves" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f anagram.awk -v key=BANANA <<WORD_LIST
BANANA
WORD_LIST

    assert_success
    refute_output
}

@test "words are not anagrams of themselves even if letter case is partially different" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f anagram.awk -v key=BANANA <<WORD_LIST
Banana
WORD_LIST

    assert_success
    refute_output
}

@test "words are not anagrams of themselves even if letter case is completely different" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f anagram.awk -v key=BANANA <<WORD_LIST
banana
WORD_LIST

    assert_success
    refute_output
}

@test "words other than themselves can be anagrams" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f anagram.awk -v key=LISTEN <<WORD_LIST
LISTEN
Silent
WORD_LIST

    assert_success
    assert_line "Silent"
    assert_equal ${#lines[@]} 1
}
