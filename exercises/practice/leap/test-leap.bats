#!/usr/bin/env bats
load bats-extra

teardown() {
    rm -f year.txt
}

@test 'year not divisible by 4: common year' {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
  echo "2015" > year.txt
  run gawk -f leap.awk year.txt

  assert_success
  assert_output "false"
}

@test 'year divisible by 2, not divisible by 4 in common year' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  echo "1970" > year.txt
  run gawk -f leap.awk year.txt

  assert_success
  assert_output "false"
}

@test 'year divisible by 4, not divisible by 100: leap year' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  echo "1996" > year.txt
  run gawk -f leap.awk year.txt

  assert_success
  assert_output "true"
}

@test 'year divisible by 4 and 5 is still a leap year' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  echo "1960" > year.txt
  run gawk -f leap.awk year.txt

  assert_success
  assert_output "true"
}

@test 'year divisible by 100, not divisible by 400: common year' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  echo "2100" > year.txt
  run gawk -f leap.awk year.txt

  assert_success
  assert_output "false"
}

@test 'year divisible by 100 but not by 3 is still not a leap year' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  echo "1900" > year.txt
  run gawk -f leap.awk year.txt

  assert_success
  assert_output "false"
}

@test 'year divisible by 400: leap year' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  echo "2000" > year.txt
  run gawk -f leap.awk year.txt

  assert_success
  assert_output "true"
}

@test 'year divisible by 400 but not by 125 is still a leap year' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  echo "2400" > year.txt
  run gawk -f leap.awk year.txt

  assert_success
  assert_output "true"
}

@test 'year divisible by 200, not divisible by 400 in common year' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  echo "1800" > year.txt
  run gawk -f leap.awk year.txt

  assert_success
  assert_output "false"
}
