#!/usr/bin/env bats
load bats-extra

# generated on 2026-06-30T17:59:57+00:00

@test "Brown and black" {
    # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f resistor-color-duo.awk <<< "brown black"
    assert_success
    assert_output "10"
}

@test "Blue and grey" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f resistor-color-duo.awk <<< "blue grey"
    assert_success
    assert_output "68"
}

@test "Yellow and violet" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f resistor-color-duo.awk <<< "yellow violet"
    assert_success
    assert_output "47"
}

@test "White and red" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f resistor-color-duo.awk <<< "white red"
    assert_success
    assert_output "92"
}

@test "Orange and orange" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f resistor-color-duo.awk <<< "orange orange"
    assert_success
    assert_output "33"
}

@test "Ignore additional colors" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f resistor-color-duo.awk <<< "green brown orange"
    assert_success
    assert_output "51"
}

@test "Black and brown, one-digit" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f resistor-color-duo.awk <<< "black brown"
    assert_success
    assert_output "1"
}

@test "invalid color" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f resistor-color-duo.awk <<< "foo"
    assert_failure
    assert_output --partial "invalid color"
}
