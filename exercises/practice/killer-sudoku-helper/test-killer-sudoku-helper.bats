#!/usr/bin/env bats
load bats-extra

# AWK script input format:
# sum size [exclude_digit1 exclude_digit2 ...]
# Example: 10 2 1 4
# (This means a cage sum of 10, with 2 digits, excluding 1 and 4 from possible options)

# Test case 1: Trivial 1-digit cages - 1
@test "1" {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f killer-sudoku-helper.awk <<< "1 1"
  assert_success
  assert_output "1"
}

# Test case 2: Trivial 1-digit cages - 2
@test "2" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f killer-sudoku-helper.awk <<< "2 1"
  assert_success
  assert_output "2"
}

# Test case 3: Trivial 1-digit cages - 3
@test "3" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f killer-sudoku-helper.awk <<< "3 1"
  assert_success
  assert_output "3"
}

# Test case 4: Trivial 1-digit cages - 4
@test "4" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f killer-sudoku-helper.awk <<< "4 1"
  assert_success
  assert_output "4"
}

# Test case 5: Trivial 1-digit cages - 5
@test "5" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f killer-sudoku-helper.awk <<< "5 1"
  assert_success
  assert_output "5"
}

# Test case 6: Trivial 1-digit cages - 6
@test "6" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f killer-sudoku-helper.awk <<< "6 1"
  assert_success
  assert_output "6"
}

# Test case 7: Trivial 1-digit cages - 7
@test "7" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f killer-sudoku-helper.awk <<< "7 1"
  assert_success
  assert_output "7"
}

# Test case 8: Trivial 1-digit cages - 8
@test "8" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f killer-sudoku-helper.awk <<< "8 1"
  assert_success
  assert_output "8"
}

# Test case 9: Trivial 1-digit cages - 9
@test "9" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f killer-sudoku-helper.awk <<< "9 1"
  assert_success
  assert_output "9"
}

# Test case 10: Cage with sum 45 contains all digits 1:9
@test "Cage with sum 45 contains all digits 1:9" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f killer-sudoku-helper.awk <<< "45 9"
  assert_success
  assert_output "1 2 3 4 5 6 7 8 9"
}

# Test case 11: Cage with only 1 possible combination
@test "Cage with only 1 possible combination" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f killer-sudoku-helper.awk <<< "7 3"
  assert_success
  assert_output "1 2 4"
}

# Test case 12: Cage with several combinations
@test "Cage with several combinations" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f killer-sudoku-helper.awk <<< "10 2"
  assert_success
  assert_line -n 4 # Ensure there are 4 lines of output
  assert_line --index 0 "1 9"
  assert_line --index 1 "2 8"
  assert_line --index 2 "3 7"
  assert_line --index 3 "4 6"
}

# Test case 13: Cage with several combinations that is restricted
@test "Cage with several combinations that is restricted" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f killer-sudoku-helper.awk <<< "10 2 1 4"
  assert_success
  assert_line -n 2 # Ensure there are 2 lines of output
  assert_line --index 0 "2 8"
  assert_line --index 1 "3 7"
}
