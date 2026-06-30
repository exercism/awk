#!/usr/bin/env bats
load bats-extra

# generated on 2026-06-30T17:59:26+00:00

@test "grains on square 1" {
  # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f grains.awk <<< 1
  assert_success
  assert_output "1"
}

@test "grains on square 2" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f grains.awk <<< 2
  assert_success
  assert_output "2"
}

@test "grains on square 3" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f grains.awk <<< 3
  assert_success
  assert_output "4"
}

@test "grains on square 4" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f grains.awk <<< 4
  assert_success
  assert_output "8"
}

@test "grains on square 16" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f grains.awk <<< 16
  assert_success
  assert_output "32768"
}

@test "grains on square 32" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f grains.awk <<< 32
  assert_success
  assert_output "2147483648"
}

@test "grains on square 64" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f grains.awk <<< 64
  assert_success
  assert_output "9223372036854775808"
}

@test "square 0 is invalid" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f grains.awk <<< 0
  assert_failure
  assert_output "square must be between 1 and 64"
}

@test "negative square is invalid" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f grains.awk <<< -1
  assert_failure
  assert_output "square must be between 1 and 64"
}

@test "square greater than 64 is invalid" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f grains.awk <<< 65
  assert_failure
  assert_output "square must be between 1 and 64"
}

@test "returns the total number of grains on the board" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -M -f grains.awk <<< total
  assert_success
  assert_output "18446744073709551615"
}

