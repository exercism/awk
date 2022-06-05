#!/usr/bin/env bats
load bats-extra

@test 'Zero is Armstrong numbers' {
  # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f armstrong-numbers.awk -v num=0 </dev/null
  assert_success
  assert_output "true"
}

@test 'Single digits are Armstrong numbers' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f armstrong-numbers.awk -v num=5 </dev/null
  assert_success
  assert_output "true"
}

@test 'There are no two digit Armstrong numbers' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f armstrong-numbers.awk -v num=10 </dev/null
  assert_success
  assert_output "false"
}

@test 'A three digit number that is an Armstrong number' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f armstrong-numbers.awk -v num=153 </dev/null
  assert_success
  assert_output "true"
}

@test 'A three digit number that is not an Armstrong number' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f armstrong-numbers.awk -v num=100 </dev/null
  assert_success
  assert_output "false"
}

@test 'A four digit number that is an Armstrong number' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f armstrong-numbers.awk -v num=9474 </dev/null
  assert_success
  assert_output "true"
}

@test 'A four digit number that is not an Armstrong number' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f armstrong-numbers.awk -v num=9475 </dev/null
  assert_success
  assert_output "false"
}

@test 'A seven digit number that is an Armstrong number' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f armstrong-numbers.awk -v num=9926315 </dev/null
  assert_success
  assert_output "true"
}

@test 'A seven digit number that is not an Armstrong number' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f armstrong-numbers.awk -v num=9926314 </dev/null
  assert_success
  assert_output "false"
}
