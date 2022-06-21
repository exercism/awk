#!/usr/bin/env bats
load bats-extra

# The awk program will receive two lines of input
# 1. the list of denominations
# 2. the amount to provide change
#
# The output is expected to be a space separated list
# of coins, sorted in ascending order

@test "change for 1 cent" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f change.awk <<END_INPUT
1 5 10 25
1
END_INPUT
    assert_success
    assert_output "1"
}

@test "single coin change" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f change.awk <<END_INPUT
1 5 10 25 100
25
END_INPUT
    assert_success
    assert_output "25"
}

@test "multiple coin change" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f change.awk <<END_INPUT
1 5 10 25 100
15
END_INPUT
    assert_success
    assert_output "5 10"
}

@test "change with Lilliputian Coins" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f change.awk <<END_INPUT
1 4 15 20 50
23
END_INPUT
    assert_success
    assert_output "4 4 15"
}

@test "change with Lower Elbonia Coins" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f change.awk <<END_INPUT
1 5 10 21 25
63
END_INPUT
    assert_success
    assert_output "21 21 21"
}

@test "large target values" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f change.awk <<END_INPUT
1 2 5 10 20 50 100
999
END_INPUT
    assert_success
    assert_output "2 2 5 20 20 50 100 100 100 100 100 100 100 100 100"
}

@test "possible change without unit coins available" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f change.awk <<END_INPUT
2 5 10 20 50
21
END_INPUT
    assert_success
    assert_output "2 2 2 5 10"
}

@test "another possible change without unit coins available" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f change.awk <<END_INPUT
4 5
27
END_INPUT
    assert_success
    assert_output "4 4 4 5 5 5"
}

@test "no coins make 0 change" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f change.awk <<END_INPUT
1 5 10 21 25
0
END_INPUT
    assert_success
    assert_output ""
}

@test "error testing for change smaller than the smallest of coins" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f change.awk <<END_INPUT
5 10
3
END_INPUT
    assert_failure
    assert_output "can't make target with given coins"
}

@test "error if no combination can add up to target" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f change.awk <<END_INPUT
5 10
94
END_INPUT
    assert_failure
    assert_output "can't make target with given coins"
}

@test "cannot find negative change values" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f change.awk <<END_INPUT
1 2 5
-5
END_INPUT
    assert_failure
    assert_output "target can't be negative"
}
