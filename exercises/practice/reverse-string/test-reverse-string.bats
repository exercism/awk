#!/usr/bin/env bats
load bats-extra

# generated on 2026-06-30T04:26:11+00:00

@test "an empty string" {
  # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f reverse-string.awk <<< ""
  assert_success
  assert_output ""
}

@test "a word" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f reverse-string.awk <<< "robot"
  assert_success
  assert_output "tobor"
}

@test "a capitalized word" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f reverse-string.awk <<< "Ramen"
  assert_success
  assert_output "nemaR"
}

@test "a sentence with punctuation" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f reverse-string.awk <<< "I'm hungry!"
  assert_success
  assert_output "!yrgnuh m'I"
}

@test "a palindrome" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f reverse-string.awk <<< "racecar"
  assert_success
  assert_output "racecar"
}

@test "an even-sized word" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f reverse-string.awk <<< "drawer"
  assert_success
  assert_output "reward"
}
