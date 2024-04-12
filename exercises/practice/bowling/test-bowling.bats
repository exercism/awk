#!/usr/bin/env bats
load bats-extra

@test "should be able to score a game with all zeros" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"

    assert_success
    assert_output "0"
}

@test "should be able to score a game with no strikes or spares" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6"

    assert_success
    assert_output "90"
}

@test "a spare followed by zeros is worth ten points" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "6 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"

    assert_success
    assert_output "10"
}

@test "points scored in the roll after a spare are counted twice" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "6 4 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"

    assert_success
    assert_output "16"
}

@test "consecutive spares each get a one roll bonus" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "5 5 3 7 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"

    assert_success
    assert_output "31"
}

@test "a spare in the last frame gets a one roll bonus that is counted once" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 7"

    assert_success
    assert_output "17"
}

@test "a strike earns ten points in a frame with a single roll" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"

    assert_success
    assert_output "10"
}

@test "points scored in the two rolls after a strike are counted twice as a bonus" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "10 5 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"

    assert_success
    assert_output "26"
}

@test "consecutive strikes each get the two roll bonus" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "10 10 10 5 3 0 0 0 0 0 0 0 0 0 0 0 0"

    assert_success
    assert_output "81"
}

@test "a strike in the last frame gets a two roll bonus that is counted once" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 7 1"

    assert_success
    assert_output "18"
}

@test "rolling a spare with the two roll bonus does not get a bonus roll" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 7 3"

    assert_success
    assert_output "20"
}

@test "strikes with the two roll bonus do not get bonus rolls" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 10"

    assert_success
    assert_output "30"
}

@test "last two strikes followed by only last bonus with non strike points" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 0 1"

    assert_success
    assert_output "31"
}

@test "a strike with the one roll bonus after a spare in the last frame does not get a bonus" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 10"

    assert_success
    assert_output "20"
}

@test "all strikes is a perfect game" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "10 10 10 10 10 10 10 10 10 10 10 10"

    assert_success
    assert_output "300"
}

@test "rolls cannot score negative points" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "-1"

    assert_failure
    assert_output "Negative roll is invalid"
}

@test "a roll cannot score more than 10 points" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "11"

    assert_failure
    assert_output "Pin count exceeds pins on the lane"
}

@test "two rolls in a frame cannot score more than 10 points" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "5 6"

    assert_failure
    assert_output "Pin count exceeds pins on the lane"
}

@test "bonus roll after a strike in the last frame cannot score more than 10 points" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 11"

    assert_failure
    assert_output "Pin count exceeds pins on the lane"
}

@test "two bonus rolls after a strike in the last frame cannot score more than 10 points" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 5 6"

    assert_failure
    assert_output "Pin count exceeds pins on the lane"
}

@test "an unstarted game cannot be scored" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< ""

    assert_failure
    assert_output "Score cannot be taken until the end of the game"
}

@test "an incomplete game cannot be scored" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "0 0"

    assert_failure
    assert_output "Score cannot be taken until the end of the game"
}

@test "cannot roll if game already has ten frames" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"

    assert_failure
    assert_output "Cannot roll after game is over"
}

@test "bonus rolls for a strike in the last frame must be rolled before score can be calculated" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10"

    assert_failure
    assert_output "Score cannot be taken until the end of the game"
}

@test "both bonus rolls for a strike in the last frame must be rolled before score can be calculated" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f bowling.awk <<< "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10"

    assert_failure
    assert_output "Score cannot be taken until the end of the game"
}

@test "bonus roll for a spare in the last frame must be rolled before score can be calculated" {
    run gawk -f bowling.awk <<< "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3"
    assert_failure
    assert_output "Score cannot be taken until the end of the game"
}

@test "cannot roll after bonus roll for spare" {
    run gawk -f bowling.awk <<< "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 2 2"
    assert_failure
    assert_output "Cannot roll after game is over"
}

@test "cannot roll after bonus rolls for strike" {
    run gawk -f bowling.awk <<< "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 3 2 2"
    assert_failure
    assert_output "Cannot roll after game is over"
}
