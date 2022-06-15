#!/usr/bin/env bats
load bats-extra

# input: bucket 1 size, bucket 2 size, goal, start name
# output: moves, "winner" bucket name, "other" bucket amount

@test "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket one" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f two-bucket.awk <<< '3,5,1,one'
    assert_success
    assert_output '4,one,5'
}

@test "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket two" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f two-bucket.awk <<< '3,5,1,two'
    assert_success
    assert_output '8,two,3'
}

@test "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket one" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f two-bucket.awk <<< '7,11,2,one'
    assert_success
    assert_output '14,one,11'
}

@test "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket two" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f two-bucket.awk <<< '7,11,2,two'
    assert_success
    assert_output '18,two,7'
}

@test "Measure one step using bucket one of size 1 and bucket two of size 3 - start with bucket two" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f two-bucket.awk <<< '1,3,3,two'
    assert_success
    assert_output '1,two,0'
}

@test "Measure using bucket one of size 2 and bucket two of size 3 - start with bucket one and end with bucket two" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f two-bucket.awk <<< '2,3,3,one'
    assert_success
    assert_output '2,two,2'
}

@test "Not possible to reach the goal" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f two-bucket.awk <<< '6,15,5,one'
    assert_failure
    assert_output --partial 'invalid goal'
}

@test "With the same buckets but a different goal, then it is possible" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f two-bucket.awk <<< '6,15,9,one'
    assert_success
    assert_output '10,two,0'
}

@test "Goal larger than both buckets is impossible" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f two-bucket.awk <<< '5,7,8,one'
    assert_failure
    assert_output --partial 'invalid goal'
}
