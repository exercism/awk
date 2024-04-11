#!/usr/bin/env bats
load bats-extra

@test 'first_generic_verse' {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bottle-song.awk -v startBottles=10 -v takeDown=1

    expected="Ten green bottles hanging on the wall,
Ten green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be nine green bottles hanging on the wall."

    assert_success
    assert_output "$expected"
}

@test 'last_generic_verse' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bottle-song.awk -v startBottles=3 -v takeDown=1

    expected="Three green bottles hanging on the wall,
Three green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be two green bottles hanging on the wall."

    assert_success
    assert_output "$expected"
}

@test 'verse_with_2_bottles' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bottle-song.awk -v startBottles=2 -v takeDown=1

    expected="Two green bottles hanging on the wall,
Two green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be one green bottle hanging on the wall."

    assert_success
    assert_output "$expected"
}

@test 'verse_with_1_bottle' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bottle-song.awk -v startBottles=1 -v takeDown=1

    expected="One green bottle hanging on the wall,
One green bottle hanging on the wall,
And if one green bottle should accidentally fall,
There'll be no green bottles hanging on the wall."

    assert_success
    assert_output "$expected"
}

@test 'first_two_verses' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bottle-song.awk -v startBottles=10 -v takeDown=2

    expected="Ten green bottles hanging on the wall,
Ten green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be nine green bottles hanging on the wall.

Nine green bottles hanging on the wall,
Nine green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be eight green bottles hanging on the wall."

    assert_success
    assert_output "$expected"
}

@test 'last_three_verses' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bottle-song.awk -v startBottles=3 -v takeDown=3

    expected="Three green bottles hanging on the wall,
Three green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be two green bottles hanging on the wall.

Two green bottles hanging on the wall,
Two green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be one green bottle hanging on the wall.

One green bottle hanging on the wall,
One green bottle hanging on the wall,
And if one green bottle should accidentally fall,
There'll be no green bottles hanging on the wall."

    assert_success
    assert_output "$expected"
}

@test 'all_verses' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bottle-song.awk -v startBottles=10 -v takeDown=10

    expected="Ten green bottles hanging on the wall,
Ten green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be nine green bottles hanging on the wall.

Nine green bottles hanging on the wall,
Nine green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be eight green bottles hanging on the wall.

Eight green bottles hanging on the wall,
Eight green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be seven green bottles hanging on the wall.

Seven green bottles hanging on the wall,
Seven green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be six green bottles hanging on the wall.

Six green bottles hanging on the wall,
Six green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be five green bottles hanging on the wall.

Five green bottles hanging on the wall,
Five green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be four green bottles hanging on the wall.

Four green bottles hanging on the wall,
Four green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be three green bottles hanging on the wall.

Three green bottles hanging on the wall,
Three green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be two green bottles hanging on the wall.

Two green bottles hanging on the wall,
Two green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be one green bottle hanging on the wall.

One green bottle hanging on the wall,
One green bottle hanging on the wall,
And if one green bottle should accidentally fall,
There'll be no green bottles hanging on the wall."

    assert_success
    assert_output "$expected"
}
