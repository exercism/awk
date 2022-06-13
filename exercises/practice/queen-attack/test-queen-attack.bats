#!/usr/bin/env bats
load bats-extra

# local version: 2.3.0.0

# Test creation of Queens with invalid positions

@test "queen must have positive row" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f queen-attack.awk <<< "-2 2 7 7"
    assert_failure
    assert_output --partial "invalid"
}

@test "queen must have row on board" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f queen-attack.awk <<< "8 4 7 7"
    assert_failure
    assert_output --partial "invalid"
}

@test "queen must have positive column" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f queen-attack.awk <<< "2 -2 7 7"
    assert_failure
    assert_output --partial "invalid"
}

@test "queen must have column on board" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f queen-attack.awk <<< "4 8 7 7"
    assert_failure
    assert_output --partial "invalid"
}

@test "same position" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f queen-attack.awk <<< "7 7 7 7"
    assert_failure
    assert_output --partial "invalid"
}


# Test the ability of one queen to attack another

@test "can not attack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f queen-attack.awk <<< "2 4 6 6"
    assert_success 
    assert_output "false"
}

@test "can attack on same row" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f queen-attack.awk <<< "2 4 2 6"
    assert_success 
    assert_output "true"
}

@test "can attack on same column" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f queen-attack.awk <<< "4 5 2 5"
    assert_success 
    assert_output "true"
}

@test "can attack on first diagonal" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f queen-attack.awk <<< "2 2 0 4"
    assert_success 
    assert_output "true"
}

@test "can attack on second diagonal" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f queen-attack.awk <<< "2 2 3 1"
    assert_success 
    assert_output "true"
}

@test "can attack on third diagonal" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f queen-attack.awk <<< "2 2 1 1"
    assert_success 
    assert_output "true"
}

@test "can attack on fourth diagonal" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f queen-attack.awk <<< "1 7 0 6"
    assert_success 
    assert_output "true"
}

@test "cannot attack if falling diagonals are only the same when reflected across the longest falling diagonal" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f queen-attack.awk <<< "4 1 2 5"
    assert_success 
    assert_output "false"
}
