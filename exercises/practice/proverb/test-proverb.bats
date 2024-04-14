#!/usr/bin/env bats
load bats-extra

@test "zero pieces" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f proverb.awk <<< ""

    assert_success
    assert_equal "${#lines[@]}" 0
}

@test "one piece" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f proverb.awk <<< "nail"

    assert_success
    assert_line --index 0 -- "And all for the want of a nail."
    assert_equal "${#lines[@]}" 1
}

@test "two pieces" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f proverb.awk <<< "nail shoe"

    assert_success
    assert_line --index 0 -- "For want of a nail the shoe was lost."
    assert_line --index 1 -- "And all for the want of a nail."
    assert_equal "${#lines[@]}" 2
}

@test "three pieces" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f proverb.awk <<< "nail shoe horse"

    assert_success
    assert_line --index 0 -- "For want of a nail the shoe was lost."
    assert_line --index 1 -- "For want of a shoe the horse was lost."
    assert_line --index 2 -- "And all for the want of a nail."
    assert_equal "${#lines[@]}" 3
}

@test "full proverb" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f proverb.awk <<< "nail shoe horse rider message battle kingdom"

    assert_success
    assert_line --index 0 -- "For want of a nail the shoe was lost."
    assert_line --index 1 -- "For want of a shoe the horse was lost."
    assert_line --index 2 -- "For want of a horse the rider was lost."
    assert_line --index 3 -- "For want of a rider the message was lost."
    assert_line --index 4 -- "For want of a message the battle was lost."
    assert_line --index 5 -- "For want of a battle the kingdom was lost."
    assert_line --index 6 -- "And all for the want of a nail."
    assert_equal "${#lines[@]}" 7
}

@test "four pieces modernized" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f proverb.awk <<< "pin gun soldier battle"

    assert_success
    assert_line --index 0 -- "For want of a pin the gun was lost."
    assert_line --index 1 -- "For want of a gun the soldier was lost."
    assert_line --index 2 -- "For want of a soldier the battle was lost."
    assert_line --index 3 -- "And all for the want of a pin."
    assert_equal "${#lines[@]}" 4
}
