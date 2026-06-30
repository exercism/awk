#!/usr/bin/env bats
load bats-extra

# generated on 2026-06-30T17:59:42+00:00

@test 'year not divisible by 4 in common year' {
  # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f leap.awk <<< "2015"

  assert_success
  assert_output "false"
}

@test 'year divisible by 2, not divisible by 4 in common year' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f leap.awk <<< "1970"

  assert_success
  assert_output "false"
}

@test 'year divisible by 4, not divisible by 100 in leap year' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f leap.awk <<< "1996"

  assert_success
  assert_output "true"
}

@test 'year divisible by 4 and 5 is still a leap year' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f leap.awk <<< "1960"

  assert_success
  assert_output "true"
}

@test 'year divisible by 100, not divisible by 400 in common year' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f leap.awk <<< "2100"

  assert_success
  assert_output "false"
}

@test 'year divisible by 100 but not by 3 is still not a leap year' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f leap.awk <<< "1900"

  assert_success
  assert_output "false"
}

@test 'year divisible by 400 is leap year' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f leap.awk <<< "2000"

  assert_success
  assert_output "true"
}

@test 'year divisible by 400 but not by 125 is still a leap year' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f leap.awk <<< "2400"

  assert_success
  assert_output "true"
}

@test 'year divisible by 200, not divisible by 400 in common year' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f leap.awk <<< "1800"

  assert_success
  assert_output "false"
}

