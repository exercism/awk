#!/usr/bin/env bats
load bats-extra

# local version: 1.2.0.0

@test "age on Earth" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f space-age.awk <<< "Earth 1000000000"
    assert_success
    assert_output 31.69
}

@test "age on Mercury" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f space-age.awk <<< "Mercury 2134835688"
    assert_success
    assert_output 280.88
}

@test "age on Venus" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f space-age.awk <<< "Venus 189839836"
    assert_success
    assert_output 9.78
}

@test "age on Mars" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f space-age.awk <<< "Mars 2129871239"
    assert_success
    assert_output 35.88
}

@test "age on Jupiter" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f space-age.awk <<< "Jupiter 901876382"
    assert_success
    assert_output 2.41
}

@test "age on Saturn" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f space-age.awk <<< "Saturn 2000000000"
    assert_success
    assert_output 2.15
}

@test "age on Uranus" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f space-age.awk <<< "Uranus 1210123456"
    assert_success
    assert_output 0.46
}

@test "age on Neptune" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f space-age.awk <<< "Neptune 1821023456"
    assert_success
    assert_output 0.35
}

@test "not a planet" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f space-age.awk <<< "Sun 680804807"
    assert_failure
    assert_output --partial "not a planet"
}
