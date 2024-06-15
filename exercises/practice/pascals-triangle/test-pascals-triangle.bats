#!/usr/bin/env bats
load bats-extra

@test "zero rows" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pascals-triangle.awk <<< "0"
    assert_success
    assert_output ""
}

@test "single row" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pascals-triangle.awk <<< "1"
    assert_success
    assert_output "1"
}

@test "two rows" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pascals-triangle.awk <<< "2"
    assert_success
    assert_line -n 0 "1"
    assert_line -n 1 "1 1"
}

@test "three rows" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pascals-triangle.awk <<< "3"
    assert_success
    assert_line -n 0 "1"
    assert_line -n 1 "1 1"
    assert_line -n 2 "1 2 1"
}

@test "four rows" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pascals-triangle.awk <<< "4"
    assert_success
    assert_line -n 0 "1"
    assert_line -n 1 "1 1"
    assert_line -n 2 "1 2 1"
    assert_line -n 3 "1 3 3 1"
}

@test "five rows" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pascals-triangle.awk <<< "5"
    assert_success
    assert_line -n 0 "1"
    assert_line -n 1 "1 1"
    assert_line -n 2 "1 2 1"
    assert_line -n 3 "1 3 3 1"
    assert_line -n 4 "1 4 6 4 1"
}

@test "six rows" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pascals-triangle.awk <<< "6"
    assert_success
    assert_line -n 0 "1"
    assert_line -n 1 "1 1"
    assert_line -n 2 "1 2 1"
    assert_line -n 3 "1 3 3 1"
    assert_line -n 4 "1 4 6 4 1"
    assert_line -n 5 "1 5 10 10 5 1"
}

@test "ten rows" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pascals-triangle.awk <<< "10"
    assert_success
    assert_line -n 0 "1"
    assert_line -n 1 "1 1"
    assert_line -n 2 "1 2 1"
    assert_line -n 3 "1 3 3 1"
    assert_line -n 4 "1 4 6 4 1"
    assert_line -n 5 "1 5 10 10 5 1"
    assert_line -n 6 "1 6 15 20 15 6 1"
    assert_line -n 7 "1 7 21 35 35 21 7 1"
    assert_line -n 8 "1 8 28 56 70 56 28 8 1"
    assert_line -n 9 "1 9 36 84 126 126 84 36 9 1"
}

@test "two triangles" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pascals-triangle.awk << END_INPUT
4
3
END_INPUT
    assert_success
    assert_line -n 0 "1"
    assert_line -n 1 "1 1"
    assert_line -n 2 "1 2 1"
    assert_line -n 3 "1 3 3 1"
    assert_line -n 4 "1"
    assert_line -n 5 "1 1"
    assert_line -n 6 "1 2 1"
}
