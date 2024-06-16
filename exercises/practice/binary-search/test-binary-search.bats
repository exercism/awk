#!/usr/bin/env bats
load bats-extra

@test "finds a value in an array with one element" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f binary-search.awk -v value=6 <<< "6"
    assert_success
    assert_output 1
}

@test "finds a value in the middle of an array" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f binary-search.awk -v value=6 <<< "1,3,4,6,8,9,11"
    assert_success
    assert_output 4
}

@test "finds a value at the beginning of an array" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f binary-search.awk -v value=1 <<< "1,3,4,6,8,9,11"
    assert_success
    assert_output 1
}

@test "finds a value at the end of an array" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f binary-search.awk -v value=11 <<< "1,3,4,6,8,9,11"
    assert_success
    assert_output 7
}

@test "finds a value in an array of odd length" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f binary-search.awk -v value=144 <<< "1,3,5,8,13,21,34,55,89,144,233,377,634"
    assert_success
    assert_output 10
}

@test "finds a value in an array of even length" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f binary-search.awk -v value=21 <<< "1,3,5,8,13,21,34,55,89,144,233,377"
    assert_success
    assert_output 6
}

@test "identifies that a value is not included in the array" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f binary-search.awk -v value=7 <<< "1,3,4,6,8,9,11"
    assert_success
    assert_output -1
}

@test "a value smaller than the array's smallest value is not found" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f binary-search.awk -v value=0 <<< "1,3,4,6,8,9,11"
    assert_success
    assert_output -1
}

@test "a value larger than the array's largest value is not found" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f binary-search.awk -v value=13 <<< "1,3,4,6,8,9,11"
    assert_success
    assert_output -1
}

@test "nothing is found in an empty array" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f binary-search.awk -v value=1 <<< ""
    assert_success
    assert_output -1
}

@test "nothing is found when the left and right bounds cross" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f binary-search.awk -v value=0 <<< "1,2"
    assert_success
    assert_output -1
}
