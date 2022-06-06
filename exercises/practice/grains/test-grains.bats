#!/usr/bin/env bats
load bats-extra

populate_test_file() {
    echo "$1" > input.txt
}

teardown() {
    rm -f input.txt
}

@test "1" {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 1
  run gawk -f grains.awk input.txt
  assert_success
  assert_output "1"
}

@test "2" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 2
  run gawk -f grains.awk input.txt
  assert_success
  assert_output "2"
}

@test "3" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 3
  run gawk -f grains.awk input.txt
  assert_success
  assert_output "4"
}

@test "4" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 4
  run gawk -f grains.awk input.txt
  assert_success
  assert_output "8"
}

@test "16" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 16
  run gawk -f grains.awk input.txt
  assert_success
  assert_output "32768"
}

@test "32" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 32
  run gawk -f grains.awk input.txt
  assert_success
  assert_output "2147483648"
}

@test "64" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 64
  run gawk -f grains.awk input.txt
  assert_success
  assert_output "9223372036854775808"
}

@test "square 0 raises an exception" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 0
  run gawk -f grains.awk input.txt
  assert_failure
  assert_output "square must be between 1 and 64"
}

@test "negative square raises an exception" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file -1
  run gawk -f grains.awk input.txt
  assert_failure
  assert_output "square must be between 1 and 64"
}

@test "square greater than 64 raises an exception" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 65
  run gawk -f grains.awk input.txt
  assert_failure
  assert_output "square must be between 1 and 64"
}

@test "returns the total number of grains on the board" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file total
  run gawk -M -f grains.awk input.txt
  assert_success
  assert_output "18446744073709551615"
}
