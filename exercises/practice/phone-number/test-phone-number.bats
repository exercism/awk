#!/usr/bin/env bats
load bats-extra

@test "cleans the number" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f phone-number.awk <<< "(223) 456-7890"
    assert_success
    assert_output "2234567890"
}

@test "cleans numbers with dots" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f phone-number.awk <<< "223.456.7890"
    assert_success
    assert_output "2234567890"
}

@test "cleans numbers with multiple spaces" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f phone-number.awk <<< "223 456   7890   "
    assert_success
    assert_output "2234567890"
}

@test "invalid when 9 digits" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f phone-number.awk <<< "123456789"
    assert_failure
    assert_output "must not be fewer than 10 digits"
}

@test "invalid when 11 digits does not start with a 1" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f phone-number.awk <<< "22234567890"
    assert_failure
    assert_output "11 digits must start with 1"
}

@test "valid when 11 digits and starting with 1" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f phone-number.awk <<< "12234567890"
    assert_success
    assert_output "2234567890"
}

@test "valid when 11 digits and starting with 1 even with punctuation" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f phone-number.awk <<< "+1 (223) 456-7890"
    assert_success
    assert_output "2234567890"
}

@test "invalid when more than 11 digits" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f phone-number.awk <<< "321234567890"
    assert_failure
    assert_output "must not be greater than 11 digits"
}

@test "invalid with letters" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f phone-number.awk <<< "523-abc-7890"
    assert_failure
    assert_output "letters not permitted"
}

@test "invalid with punctuations" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f phone-number.awk <<< "523-@:!-7890"
    assert_failure
    assert_output "punctuations not permitted"
}

@test "invalid if area code starts with 0" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f phone-number.awk <<< "(023) 456-7890"
    assert_failure
    assert_output "area code cannot start with zero"
}

@test "invalid if area code starts with 1" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f phone-number.awk <<< "(123) 456-7890"
    assert_failure
    assert_output "area code cannot start with one"
}

@test "invalid if exchange code starts with 0" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f phone-number.awk <<< "(223) 056-7890"
    assert_failure
    assert_output "exchange code cannot start with zero"
}

@test "invalid if exchange code starts with 1" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f phone-number.awk <<< "(223) 156-7890"
    assert_failure
    assert_output "exchange code cannot start with one"
}

@test "invalid if area code starts with 0 on valid 11-digit number" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f phone-number.awk <<< "1 (023) 456-7890"
    assert_failure
    assert_output "area code cannot start with zero"
}

@test "invalid if area code starts with 1 on valid 11-digit number" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f phone-number.awk <<< "1 (123) 456-7890"
    assert_failure
    assert_output "area code cannot start with one"
}

@test "invalid if exchange code starts with 0 on valid 11-digit number" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f phone-number.awk <<< "1 (223) 056-7890"
    assert_failure
    assert_output "exchange code cannot start with zero"
}

@test "invalid if exchange code starts with 1 on valid 11-digit number" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f phone-number.awk <<< "1 (223) 156-7890"
    assert_failure
    assert_output "exchange code cannot start with one"
}
