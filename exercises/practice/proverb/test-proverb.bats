#!/usr/bin/env bats
load bats-extra

# generated on 2026-06-30T15:58:05+00:00

@test "zero pieces" {
    # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$( cat <<EOF
EOF
)
    run gawk -f proverb.awk <<< ""
    assert_success
    assert_output "$expected"
}

@test "one piece" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$( cat <<EOF
And all for the want of a nail.
EOF
)
    run gawk -f proverb.awk <<< "nail"
    assert_success
    assert_output "$expected"
}

@test "two pieces" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$( cat <<EOF
For want of a nail the shoe was lost.
And all for the want of a nail.
EOF
)
    run gawk -f proverb.awk <<< "nail shoe"
    assert_success
    assert_output "$expected"
}

@test "three pieces" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$( cat <<EOF
For want of a nail the shoe was lost.
For want of a shoe the horse was lost.
And all for the want of a nail.
EOF
)
    run gawk -f proverb.awk <<< "nail shoe horse"
    assert_success
    assert_output "$expected"
}

@test "full proverb" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$( cat <<EOF
For want of a nail the shoe was lost.
For want of a shoe the horse was lost.
For want of a horse the rider was lost.
For want of a rider the message was lost.
For want of a message the battle was lost.
For want of a battle the kingdom was lost.
And all for the want of a nail.
EOF
)
    run gawk -f proverb.awk <<< "nail shoe horse rider message battle kingdom"
    assert_success
    assert_output "$expected"
}

@test "four pieces modernized" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$( cat <<EOF
For want of a pin the gun was lost.
For want of a gun the soldier was lost.
For want of a soldier the battle was lost.
And all for the want of a pin.
EOF
)
    run gawk -f proverb.awk <<< "pin gun soldier battle"
    assert_success
    assert_output "$expected"
}
