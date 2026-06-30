#!/usr/bin/env bats
load bats-extra

# generated on 2026-06-30T04:41:50+00:00

@test "slices of one from one" {
    # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f series.awk -v len=1 <<< "1"
    assert_success
    assert_output "1"
}

@test "slices of one from two" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f series.awk -v len=1 <<< "12"
    assert_success
    assert_output "1 2"
}

@test "slices of two" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f series.awk -v len=2 <<< "35"
    assert_success
    assert_output "35"
}

@test "slices of two overlap" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f series.awk -v len=2 <<< "9142"
    assert_success
    assert_output "91 14 42"
}

@test "slices can include duplicates" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f series.awk -v len=3 <<< "777777"
    assert_success
    assert_output "777 777 777 777"
}

@test "slices of a long series" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f series.awk -v len=5 <<< "918493904243"
    assert_success
    assert_output "91849 18493 84939 49390 93904 39042 90424 04243"
}

@test "slice length is too large" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f series.awk -v len=6 <<< "12345"
    assert_failure
    assert_output --partial "slice length cannot be greater than series length"
}

@test "slice length is way too large" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f series.awk -v len=42 <<< "12345"
    assert_failure
    assert_output --partial "slice length cannot be greater than series length"
}

@test "slice length cannot be zero" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f series.awk -v len=0 <<< "12345"
    assert_failure
    assert_output --partial "slice length cannot be zero"
}

@test "slice length cannot be negative" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f series.awk -v len=-1 <<< "123"
    assert_failure
    assert_output --partial "slice length cannot be negative"
}

@test "empty series is invalid" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f series.awk -v len=1 <<< ""
    assert_failure
    assert_output --partial "series cannot be empty"
}
