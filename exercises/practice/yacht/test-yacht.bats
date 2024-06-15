#!/usr/bin/env bats
load bats-extra

@test "Yacht" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "5,5,5,5,5,yacht"
    assert_success
    assert_output 50
}

@test "Not Yacht" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "1,3,3,2,5,yacht"
    assert_success
    assert_output 0
}

@test "Ones" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "1,1,1,3,5,ones"
    assert_success
    assert_output 3
}

@test "Ones, out of order" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "3,1,1,5,1,ones"
    assert_success
    assert_output 3
}

@test "No ones" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "4,3,6,5,5,ones"
    assert_success
    assert_output 0
}

@test "Twos" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "2,3,4,5,6,twos"
    assert_success
    assert_output 2
}

@test "Fours" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "1,4,1,4,1,fours"
    assert_success
    assert_output 8
}

@test "Yacht counted as threes" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "3,3,3,3,3,threes"
    assert_success
    assert_output 15
}

@test "Yacht of 3s counted as fives" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "3,3,3,3,3,fives"
    assert_success
    assert_output 0
}

@test "Fives" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "1,5,3,5,3,fives"
    assert_success
    assert_output 10
}

@test "Sixes" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "2,3,4,5,6,sixes"
    assert_success
    assert_output 6
}

@test "Full house two small, three big" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "2,2,4,4,4,full house"
    assert_success
    assert_output 16
}

@test "Full house three small, two big" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "5,3,3,5,3,full house"
    assert_success
    assert_output 19
}

@test "Two pair is not a full house" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "2,2,4,4,5,full house"
    assert_success
    assert_output 0
}

@test "Four of a kind is not a full house" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "1,4,4,4,4,full house"
    assert_success
    assert_output 0
}

@test "Yacht is not a full house" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "2,2,2,2,2,full house"
    assert_success
    assert_output 0
}

@test "Four of a Kind" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "6,6,4,6,6,four of a kind"
    assert_success
    assert_output 24
}

@test "Yacht can be scored as Four of a Kind" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "3,3,3,3,3,four of a kind"
    assert_success
    assert_output 12
}

@test "Full house is not Four of a Kind" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "3,3,3,5,5,four of a kind"
    assert_success
    assert_output 0
}

@test "Little Straight" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "3,5,4,1,2,little straight"
    assert_success
    assert_output 30
}

@test "Little Straight as Big Straight" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "1,2,3,4,5,big straight"
    assert_success
    assert_output 0
}

@test "Four in order but not a little straight" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "1,1,2,3,4,little straight"
    assert_success
    assert_output 0
}

@test "No pairs but not a little straight" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "1,2,3,4,6,little straight"
    assert_success
    assert_output 0
}

@test "Minimum is 1, maximum is 5, but not a little straight" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "1,1,3,4,5,little straight"
    assert_success
    assert_output 0
}

@test "Big Straight" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "4,6,2,5,3,big straight"
    assert_success
    assert_output 30
}

@test "Big Straight as little straight" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "6,5,4,3,2,little straight"
    assert_success
    assert_output 0
}

@test "No pairs but not a big straight" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "6,5,4,3,1,big straight"
    assert_success
    assert_output 0
}

@test "Choice" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "3,3,5,6,6,choice"
    assert_success
    assert_output 23
}

@test "Yacht as choice" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f yacht.awk <<< "2,2,2,2,2,choice"
    assert_success
    assert_output 10
}
