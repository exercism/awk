#!/usr/bin/env bats
load bats-extra

# generated on 2026-06-30T17:58:47+00:00

# The two large tests require the -M option to handle big numbers.
# Refer to the instructions of the Grains exercise:
#   https://exercism.org/tracks/awk/exercises/grains

@test "Zero is an Armstrong number" {
  # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f armstrong-numbers.awk -v num=0
  assert_success
  assert_output "true"
}

@test "Single-digit numbers are Armstrong numbers" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f armstrong-numbers.awk -v num=5
  assert_success
  assert_output "true"
}

@test "There are no two-digit Armstrong numbers" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f armstrong-numbers.awk -v num=10
  assert_success
  assert_output "false"
}

@test "Three-digit number that is an Armstrong number" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f armstrong-numbers.awk -v num=153
  assert_success
  assert_output "true"
}

@test "Three-digit number that is not an Armstrong number" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f armstrong-numbers.awk -v num=100
  assert_success
  assert_output "false"
}

@test "Four-digit number that is an Armstrong number" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f armstrong-numbers.awk -v num=9474
  assert_success
  assert_output "true"
}

@test "Four-digit number that is not an Armstrong number" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f armstrong-numbers.awk -v num=9475
  assert_success
  assert_output "false"
}

@test "Seven-digit number that is an Armstrong number" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f armstrong-numbers.awk -v num=9926315
  assert_success
  assert_output "true"
}

@test "Seven-digit number that is not an Armstrong number" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f armstrong-numbers.awk -v num=9926314
  assert_success
  assert_output "false"
}

@test "Armstrong number containing seven zeroes" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -M -f armstrong-numbers.awk -v num=186709961001538790100634132976990
  assert_success
  assert_output "true"
}

@test "The largest and last Armstrong number" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -M -f armstrong-numbers.awk -v num=115132219018763992565095597973971522401
  assert_success
  assert_output "true"
}

