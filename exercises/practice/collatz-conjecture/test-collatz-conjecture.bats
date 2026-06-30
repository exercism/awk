#!/usr/bin/env bats
load bats-extra

# generated on 2026-06-30T17:59:07+00:00

@test "zero steps for one" {
  # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f collatz-conjecture.awk <<< "1"
  assert_success
  assert_output "0"
}

@test "divide if even" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f collatz-conjecture.awk <<< "16"
  assert_success
  assert_output "4"
}

@test "even and odd steps" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f collatz-conjecture.awk <<< "12"
  assert_success
  assert_output "9"
}

@test "large number of even and odd steps" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f collatz-conjecture.awk <<< "1000000"
  assert_success
  assert_output "152"
}

@test "zero is an error" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f collatz-conjecture.awk <<< "0"
  assert_failure
  assert_output "Error: Only positive integers are allowed"
}

@test "negative value is an error" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f collatz-conjecture.awk <<< "-15"
  assert_failure
  assert_output "Error: Only positive integers are allowed"
}

