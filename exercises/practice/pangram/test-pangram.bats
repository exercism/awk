#!/usr/bin/env bats
load bats-extra

# Check if the given string is a pangram

populate_test_file() {
    echo "$*" > input.txt
}

teardown() {
    rm -f input.txt
}

@test "empty sentence" {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file ""
  run gawk -f pangram.awk input.txt
  assert_success
  assert_output "false"
}

@test "perfect lower case" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file "abcdefghijklmnopqrstuvwxyz"
  run gawk -f pangram.awk input.txt
  assert_success
  assert_output "true"
}

@test "only lower case" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file "the quick brown fox jumps over the lazy dog"
  run gawk -f pangram.awk input.txt
  assert_success
  assert_output "true"
}

@test "missing the letter 'x'" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file "a quick movement of the enemy will jeopardize five gunboats"
  run gawk -f pangram.awk input.txt
  assert_success
  assert_output "false"
}

@test "missing the letter 'h'" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file "five boxing wizards jump quickly at it"
  run gawk -f pangram.awk input.txt
  assert_success
  assert_output "false"
}

@test "with underscores" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file "the_quick_brown_fox_jumps_over_the_lazy_dog"
  run gawk -f pangram.awk input.txt
  assert_success
  assert_output "true"
}

@test "with numbers" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file "the 1 quick brown fox jumps over the 2 lazy dogs"
  run gawk -f pangram.awk input.txt
  assert_success
  assert_output "true"
}

@test "missing letters replaced by numbers" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file "7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog"
  run gawk -f pangram.awk input.txt
  assert_success
  assert_output "false"
}

@test "mixed case and punctuation" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file "\"Five quacking Zephyrs jolt my wax bed.\""
  run gawk -f pangram.awk input.txt
  assert_success
  assert_output "true"
}

@test "a-m and A-M are 26 different characters but not a pangram" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file "abcdefghijklm ABCDEFGHIJKLM"
  run gawk -f pangram.awk input.txt
  assert_success
  assert_output "false"
}
