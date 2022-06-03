#!/usr/bin/env bats
load bats-extra

populate_test_file() {
    echo "$1" > input.txt
    echo "$2" >> input.txt
}

teardown() {
    rm -f input.txt
}

@test 'empty strands' {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file '' ''
  run gawk -f hamming.awk input.txt
  assert_success
  assert_output "0"
}

@test 'single letter identical strands' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'A' 'A'
  run gawk -f hamming.awk input.txt
  assert_success
  assert_output "0"
}

@test 'single letter different strands' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'G' 'T'
  run gawk -f hamming.awk input.txt
  assert_success
  assert_output "1"
}

@test 'long identical strands' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'GGACTGAAATCTG' 'GGACTGAAATCTG'
  run gawk -f hamming.awk input.txt
  assert_success
  assert_output "0"
}

@test 'long different strands' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'GGACGGATTCTG' 'AGGACGGATTCT'
  run gawk -f hamming.awk input.txt
  assert_success
  assert_output "9"
}

@test 'disallow first strand longer' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'AATG' 'AAA'
  run gawk -f hamming.awk input.txt
  assert_failure
  assert_output --partial "strands must be of equal length"
}

@test 'disallow second strand longer' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'ATA' 'AGTG'
  run gawk -f hamming.awk input.txt
  assert_failure
  assert_output --partial "strands must be of equal length"
}

@test 'disallow empty first strand' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file '' 'G'
  run gawk -f hamming.awk input.txt
  assert_failure
  assert_output --partial "strands must be of equal length"
}

@test 'disallow empty second strand' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'G' ''
  run gawk -f hamming.awk input.txt
  assert_failure
  assert_output --partial "strands must be of equal length"
}
