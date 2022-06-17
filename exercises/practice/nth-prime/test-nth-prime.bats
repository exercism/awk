#!/usr/bin/env bats
load bats-extra

@test "first prime" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
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

@test "hundredth prime" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f nth-prime.awk -v n=100
    assert_success
    assert_output "541"
}

@test "big prime" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f nth-prime.awk -v n=10001 -M
    assert_success
    assert_output "104743"
}

@test "there is no zeroth prime" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f nth-prime.awk -v n=0
    assert_failure
    assert_output "invalid input"
}

@test "there is no negativeth prime" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f nth-prime.awk -v n=-2
    assert_failure
    assert_output "invalid input"
}
