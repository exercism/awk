#!/usr/bin/env bats
load bats-extra

# generated on 2026-06-30T15:57:42+00:00

@test "first prime" {
    # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f nth-prime.awk -v n=1
    assert_success
    assert_output "2"
}

@test "second prime" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f nth-prime.awk -v n=2
    assert_success
    assert_output "3"
}

@test "sixth prime" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f nth-prime.awk -v n=6
    assert_success
    assert_output "13"
}

@test "big prime" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f nth-prime.awk -v n=10001
    assert_success
    assert_output "104743"
}

@test "there is no zeroth prime" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f nth-prime.awk -v n=0
    assert_failure
    assert_output "invalid input"
}
