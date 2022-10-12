#!/usr/bin/env bats
load bats-extra

# The `assert_line` test does not care about _order_, just that the line
# exists in the output.

@test "count one word" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f word-count.awk <<< "word"
    assert_success
    assert_line "word: 1"
    assert_equal "${#lines[@]}" 1
}

@test "count one of each word" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f word-count.awk <<< "one of each"
    assert_success
    assert_line "one: 1"
    assert_line "of: 1"
    assert_line "each: 1"
    assert_equal "${#lines[@]}" 3
}

@test "multiple occurrences of a word" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f word-count.awk <<< "one fish two fish red fish blue fish"
    assert_success
    assert_line "one: 1"
    assert_line "fish: 4"
    assert_line "two: 1"
    assert_line "red: 1"
    assert_line "blue: 1"
    assert_equal "${#lines[@]}" 5
}

@test "handles cramped lists" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f word-count.awk <<< "one,two,three"
    assert_success
    assert_line "one: 1"
    assert_line "two: 1"
    assert_line "three: 1"
    assert_equal "${#lines[@]}" 3
}

@test "handles expanded lists" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f word-count.awk << END_INPUT
one,
two,
three
END_INPUT
    assert_success
    assert_line "one: 1"
    assert_line "two: 1"
    assert_line "three: 1"
    assert_equal "${#lines[@]}" 3
}

@test "ignore punctuation" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f word-count.awk <<< "car: carpet as java: javascript!!&@$%^&"
    assert_success
    assert_line "car: 1"
    assert_line "carpet: 1"
    assert_line "as: 1"
    assert_line "java: 1"
    assert_line "javascript: 1"
    assert_equal "${#lines[@]}" 5
}

@test "include numbers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f word-count.awk <<< "testing, 1, 2 testing"
    assert_success
    assert_line "testing: 2"
    assert_line "1: 1"
    assert_line "2: 1"
    assert_equal "${#lines[@]}" 3
}

@test "normalize case" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f word-count.awk <<< "go Go GO Stop stop"
    assert_success
    assert_line "go: 3"
    assert_line "stop: 2"
    assert_equal "${#lines[@]}" 2
}

@test "with apostrophes" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f word-count.awk <<< "'First: don't laugh. Then: don't cry. You're getting it.'"
    assert_success
    assert_line "first: 1"
    assert_line "don't: 2"
    assert_line "laugh: 1"
    assert_line "then: 1"
    assert_line "cry: 1"
    assert_line "you're: 1"
    assert_line "getting: 1"
    assert_line "it: 1"
    assert_equal "${#lines[@]}" 8
}

@test "with quotations" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f word-count.awk <<< "Joe can't tell between 'large' and large."
    assert_success
    assert_line "joe: 1"
    assert_line "can't: 1"
    assert_line "tell: 1"
    assert_line "between: 1"
    assert_line "large: 2"
    assert_line "and: 1"
    assert_equal "${#lines[@]}" 6
}

@test "substrings from the beginning" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f word-count.awk <<< "Joe can't tell between apple, app and a."
    assert_success
    assert_line "joe: 1"
    assert_line "can't: 1"
    assert_line "tell: 1"
    assert_line "apple: 1"
    assert_line "app: 1"
    assert_line "and: 1"
    assert_line "a: 1"
    assert_equal "${#lines[@]}" 8
}

@test "multiple spaces not detected as a word" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f word-count.awk <<< " multiple   whitespaces"
    assert_success
    assert_line "multiple: 1"
    assert_line "whitespaces: 1"
    assert_equal "${#lines[@]}" 2
}

@test "alternating word separators are not detected as a word" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f word-count.awk <<< $',\n,one,\n ,two \n \'three\''
    assert_success
    assert_line "one: 1"
    assert_line "two: 1"
    assert_line "three: 1"
    assert_equal "${#lines[@]}" 3
}

@test "quotation for word with apostrophe" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f word-count.awk <<< "can, can't, 'can't'"
    assert_success
    assert_line "can: 1"
    assert_line "can't: 2"
    assert_equal "${#lines[@]}" 2
}
