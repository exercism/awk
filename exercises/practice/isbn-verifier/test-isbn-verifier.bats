#!/usr/bin/env bats
load bats-extra

@test "valid isbn" {
  # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< "3-598-21508-8"
  assert_success
  assert_output "true"
}

@test "invalid isbn check digit" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< "3-598-21508-9"
  assert_success
  assert_output "false"
}

@test "valid isbn with a check digit of 10" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< "3-598-21507-X"
  assert_success
  assert_output "true"
}

@test "check digit is a character other than X" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< "3-598-21507-A"
  assert_success
  assert_output "false"
}

@test "invalid check digit in isbn is not treated as zero" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< "4-598-21507-B"
  assert_success
  assert_output "false"
}

@test "invalid character in isbn is not treated as zero" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< "3-598-P1581-X"
  assert_success
  assert_output "false"
}

@test "X is only valid as a check digit" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< "3-598-2X507-9"
  assert_success
  assert_output "false"
}

@test "valid isbn without separating dashes" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< "3598215088"
  assert_success
  assert_output "true"
}

@test "isbn without separating dashes and X as check digit" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< "359821507X"
  assert_success
  assert_output "true"
}

@test "isbn without check digit and dashes" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< "359821507"
  assert_success
  assert_output "false"
}

@test "too long isbn and no dashes" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< "3598215078X"
  assert_success
  assert_output "false"
}

@test "too short isbn" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< "00"
  assert_success
  assert_output "false"
}

@test "isbn without check digit" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< "3-598-21507"
  assert_success
  assert_output "false"
}

@test "check digit of X should not be used for 0" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< "3-598-21515-X"
  assert_success
  assert_output "false"
}

@test "empty isbn" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< ""
  assert_success
  assert_output "false"
}

@test "input is 9 characters" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< "134456729"
  assert_success
  assert_output "false"
}

@test "invalid characters are not ignored after checking length" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< "3132P34035"
  assert_success
  assert_output "false"
}

@test "invalid characters are not ignored before checking length" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< "3598P215088"
  assert_success
  assert_output "false"
}

@test "input is too long but contains a valid isbn" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f isbn-verifier.awk <<< "98245726788"
  assert_success
  assert_output "false"
}
