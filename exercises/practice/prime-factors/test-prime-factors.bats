#!/usr/bin/env bats
load bats-extra

# local version: 1.1.0.0

@test "no factors" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prime-factors.awk <<< 1
    assert_success
    assert_output ""
}

@test "prime number" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prime-factors.awk <<< 2
    assert_success
    assert_output "2"
}

@test "another prime number" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prime-factors.awk <<< 3
    assert_success
    assert_output "3"
}

@test "square of a prime" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prime-factors.awk <<< 9
    assert_success
    assert_output "3 3"
}

@test "product of first prime" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prime-factors.awk <<< 4
    assert_success
    assert_output "2 2"
}

@test "cube of a prime" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prime-factors.awk <<< 8
    assert_success
    assert_output "2 2 2"
}

@test "product of second prime" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prime-factors.awk <<< 27
    assert_success
    assert_output "3 3 3"
}

@test "product of third prime" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prime-factors.awk <<< 625
    assert_success
    assert_output "5 5 5 5"
}

@test "product of first and second primes" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prime-factors.awk <<< 6
    assert_success
    assert_output "2 3"
}

@test "product of primes and non-primes" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prime-factors.awk <<< 12
    assert_success
    assert_output "2 2 3"
}

@test "product of primes" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prime-factors.awk <<< 901255
    assert_success
    assert_output "5 17 23 461"
}

@test "factors include a large prime" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prime-factors.awk <<< 93819012551
    assert_success
    assert_output "11 9539 894119"
}
