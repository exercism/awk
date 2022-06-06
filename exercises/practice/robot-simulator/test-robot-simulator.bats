#!/usr/bin/env bats
load bats-extra

write_instructions() {
    printf '%s\n' "$@" > instructions.txt
}
teardown() {
    rm -f instructions.txt
}

# A robot is created with a position and a direction.
# The awk program will output the robot's variables: x, y, dir

@test "Robots are created with a position and direction" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f robot-simulator.awk -v x=0 -v y=0 -v dir=north /dev/null
    assert_success
    assert_output "0 0 north"
}
@test "Robots are created with a default position and direction" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f robot-simulator.awk /dev/null
    assert_success
    assert_output "0 0 north"
}

@test "Negative positions are allowed" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f robot-simulator.awk -v x=-1 -v y=-1 -v dir=south /dev/null
    assert_success
    assert_output "-1 -1 south"
}


# rotates the robot's direction 90 degrees clockwise

@test "changes the direction from north to east" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    write_instructions R
    run gawk -f robot-simulator.awk -v dir=north instructions.txt
    assert_success
    assert_output "0 0 east"
}

@test "changes the direction from east to south" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    write_instructions R
    run gawk -f robot-simulator.awk -v dir=east instructions.txt
    assert_success
    assert_output "0 0 south"
}

@test "changes the direction from south to west" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    write_instructions R
    run gawk -f robot-simulator.awk -v dir=south instructions.txt
    assert_success
    assert_output "0 0 west"
}

@test "changes the direction from west to north" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    write_instructions R
    run gawk -f robot-simulator.awk -v dir=west instructions.txt
    assert_success
    assert_output "0 0 north"
}


# rotates the robot's direction 90 degrees counter-clockwise

@test "changes the direction from north to west" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    write_instructions L
    run gawk -f robot-simulator.awk -v dir=north instructions.txt
    assert_success
    assert_output "0 0 west"
}

@test "changes the direction from west to south" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    write_instructions L
    run gawk -f robot-simulator.awk -v dir=west instructions.txt
    assert_success
    assert_output "0 0 south"
}

@test "changes the direction from south to east" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    write_instructions L
    run gawk -f robot-simulator.awk -v dir=south instructions.txt
    assert_success
    assert_output "0 0 east"
}

@test "changes the direction from east to north" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    write_instructions L
    run gawk -f robot-simulator.awk -v dir=east instructions.txt
    assert_success
    assert_output "0 0 north"
}


# moves the robot forward 1 space in the direction it is pointing

@test "increases the y coordinate one when facing north" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    write_instructions A
    run gawk -f robot-simulator.awk -v x=0 -v y=0 -v dir=north instructions.txt
    assert_success
    assert_output "0 1 north"
}

@test "decreases the y coordinate by one when facing south" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    write_instructions A
    run gawk -f robot-simulator.awk -v x=0 -v y=0 -v dir=south instructions.txt
    assert_success
    assert_output "0 -1 south"
}

@test "increases the x coordinate by one when facing east" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    write_instructions A
    run gawk -f robot-simulator.awk -v x=0 -v y=0 -v dir=east instructions.txt
    assert_success
    assert_output "1 0 east"
}

@test "decreases the x coordinate by one when facing west" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    write_instructions A
    run gawk -f robot-simulator.awk -v x=0 -v y=0 -v dir=west instructions.txt
    assert_success
    assert_output "-1 0 west"
}


# Where R = Turn Right, L = Turn Left and A = Advance, the
# robot can follow a series of instructions and end up with
# the correct position and direction

@test "instructions to move east and north from README" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    write_instructions R A A L A L
    run gawk -f robot-simulator.awk -v x=7 -v y=3 -v dir=north instructions.txt
    assert_success
    assert_output "9 4 west"
}

@test "instructions to move west and north" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    write_instructions L A A A R A L A
    run gawk -f robot-simulator.awk -v x=0 -v y=0 -v dir=north instructions.txt
    assert_success
    assert_output "-4 1 west"
}

@test "instructions to move west and south" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    write_instructions R R A A A A A L A
    run gawk -f robot-simulator.awk -v x=2 -v y=-7 -v dir=east instructions.txt
    assert_success
    assert_output "-3 -8 south"
}

@test "instructions to move east and north" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    write_instructions L A A A R R R A L L L L
    run gawk -f robot-simulator.awk -v x=8 -v y=4 -v dir=south instructions.txt
    assert_success
    assert_output "11 5 north"
}


# error conditions

@test "invalid direction" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f robot-simulator.awk -v dir=foo /dev/null
    assert_failure
    assert_output "invalid direction"
}

@test "invalid instructions" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    write_instructions L R A X
    run gawk -f robot-simulator.awk instructions.txt
    assert_failure
    assert_output "invalid instruction"
}
