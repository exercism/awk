#!/usr/bin/env bats
load bats-extra

setup() {
    echo > empty.txt
    echo "Alice" > one.txt

    echo "John Smith" > two.txt
    echo "Mary Ann" >> two.txt
}

teardown() {
    rm empty.txt one.txt two.txt
}


@test "no file given" {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip

  # The above line controls whether to skip the test.
  # Normally, we skip every test except for the first one
  # (the first one is always commented out).  This allows for
  # a person to focus on solving a test at a time: you can
  # comment out or delete the
  # `[[ $BATS_RUN_SKIPPED == "true" ]] || skip`
  # line to run the test when you are ready.
  #
  # You can also run all the tests by setting the
  # `$BATS_RUN_SKIPPED` environment variable, like this:
  #
  #     $ BATS_RUN_SKIPPED=true bats test-two-fer.bats

  run gawk -f two-fer.awk < /dev/null
  assert_success
  assert_output "One for you, one for me."
}

@test "empty file given" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f two-fer.awk empty.txt
  assert_success
  assert_output "One for you, one for me."
}

@test "a name given" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f two-fer.awk one.txt
  assert_success
  assert_output "One for Alice, one for me."
}

@test "multiple names given" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f two-fer.awk two.txt
  assert_success
  assert_output "One for Mary Ann, one for me."
}
