#!/usr/bin/env bats
load bats-extra

@test "single digit strings can not be valid" {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "1"
  assert_success
  assert_output "false"
}

@test "a single zero is invalid" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "0"
  assert_success
  assert_output "false"
}

@test "a simple valid SIN that remains valid if reversed" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "059"
  assert_success
  assert_output "true"
}

@test "a simple valid SIN that becomes invalid if reversed" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "59"
  assert_success
  assert_output "true"
}

@test "a valid Canadian SIN" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "055 444 285"
  assert_success
  assert_output "true"
}

@test "invalid Canadian SIN" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "055 444 286"
  assert_success
  assert_output "false"
}

@test "invalid credit card" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "8273 1232 7352 0569"
  assert_success
  assert_output "false"
}

@test  "invalid long number with an even remainder" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "1 2345 6789 1234 5678 9012"
  assert_success
  assert_output "false"
}

@test  "invalid long number with a remainder divisible by 5" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "1 2345 6789 1234 5678 9013"
  assert_success
  assert_output "false"
}

@test "valid number with an even number of digits" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "095 245 88"
  assert_success
  assert_output "true"
}

@test "valid number with an odd number of spaces" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "234 567 891 234"
  assert_success
  assert_output "true"
}

@test "valid strings with a non-digit included become invalid" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "055a 444 285"
  assert_success
  assert_output "false"
}

@test "valid strings with punctuation included become invalid" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "055-444-285"
  assert_success
  assert_output "false"
}

@test "valid strings with symbols included become invalid" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "055£ 444$ 285"
  assert_success
  assert_output "false"
}

@test "single zero with space is invalid" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< " 0"
  assert_success
  assert_output "false"
}

@test "more than a single zero is valid" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "0000 0"
  assert_success
  assert_output "true"
}

@test "input digit 9 is correctly converted to output digit 9" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "091"
  assert_success
  assert_output "true"
}

@test "very long input is valid" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "9999999999 9999999999 9999999999 9999999999"
  assert_success
  assert_output "true"
}

@test "valid luhn with an odd number of digits and non zero first digit" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "109"
  assert_success
  assert_output "true"
}

@test "using ascii value for non-doubled non-digit isn't allowed" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "055b 444 285"
  assert_success
  assert_output "false"
}

@test "using ascii value for doubled non-digit isn't allowed" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< ":9"
  assert_success
  assert_output "false"
}

@test "non-numeric, non-space char in the middle with a sum that's divisible by 10 isn't allowed" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f luhn.awk <<< "59%59"
  assert_success
  assert_output "false"
}
