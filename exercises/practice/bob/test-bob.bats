#!/usr/bin/env bats
load bats-extra

populate_test_file() {
    echo -e "$1" > input.txt
}

teardown() {
    rm -f input.txt
}

@test "stating something" {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'Tom-ay-to, tom-aaaah-to.'
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Whatever."
}

@test "shouting" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'WATCH OUT!'
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Whoa, chill out!"
}

@test "shouting gibberish" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'FCECDFCAAB'
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Whoa, chill out!"
}

@test "asking a question" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'Does this cryogenic chamber make me look fat?'
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Sure."
}

@test "asking a numeric question" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'You are, what, like 15?'
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Sure."
}

@test "asking gibberish" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'fffbbcbeab?'
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Sure."
}

@test "talking forcefully" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file "Hi there!"
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Whatever."
}

@test "using acronyms in regular speech" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file "It's OK if you don't want to go work for NASA."
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Whatever."
}

@test "forceful question" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file "WHAT'S GOING ON?"
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Calm down, I know what I'm doing!"
}

@test "shouting numbers" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file '1, 2, 3 GO!'
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Whoa, chill out!"
}

@test "no letters" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file '1, 2, 3'
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Whatever."
}

@test "question with no letters" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file '4?'
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Sure."
}

@test "shouting with special characters" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!'
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Whoa, chill out!"
}

@test "shouting with no exclamation mark" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'I HATE THE DENTIST'
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Whoa, chill out!"
}

@test "statement containing question mark" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'Ending with ? means a question.'
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Whatever."
}

@test "non-letters with question" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file ':) ?'
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Sure."
}

@test "prattling on" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'Wait! Hang on. Are you going to be OK?'
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Sure."
}

@test "silence" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file ''
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Fine. Be that way!"
}

@test "prolonged silence" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file '          '
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Fine. Be that way!"
}

@test "alternate silence" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file '\t\t\t\t\t\t\t\t\t\t'
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Fine. Be that way!"
}

@test "multiple line question" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file '\nDoes this cryogenic chamber make me look fat?\nNo'
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Whatever."
}

@test "starting with whitespace" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file '         hmmmmmmm...'
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Whatever."
}

@test "ending with whitespace" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'Okay if like my  spacebar  quite a bit?   '
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Sure."
}

@test "other whitespace" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file '\n\r \t'
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Fine. Be that way!"
}

@test "non-question ending with whitespace" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'This is a statement ending with whitespace      '
  run gawk -f bob.awk input.txt
  assert_success
  assert_output "Whatever."
}

@test "no input is silence" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f bob.awk </dev/null
  assert_success
  assert_output "Fine. Be that way!"
}
