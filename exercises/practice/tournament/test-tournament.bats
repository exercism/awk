#!/usr/bin/env bats
load bats-extra

# Assert that running the program with input $1 generates output $2.
assert_in_to_out() {
    run gawk -f tournament.awk <<< "$1"
    assert_success
    assert_output "$2"
}

@test "just the header if no input" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip

    input=""

    expected="Team                           | MP |  W |  D |  L |  P"

    assert_in_to_out "$input" "$expected"
}

@test "a win is three points, a loss is zero points" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    input="Allegoric Alaskans;Blithering Badgers;win"

    expected="\
Team                           | MP |  W |  D |  L |  P
Allegoric Alaskans             |  1 |  1 |  0 |  0 |  3
Blithering Badgers             |  1 |  0 |  0 |  1 |  0"

    assert_in_to_out "$input" "$expected"
}

@test "a win can also be expressed as a loss" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    input="Blithering Badgers;Allegoric Alaskans;loss"

    expected="\
Team                           | MP |  W |  D |  L |  P
Allegoric Alaskans             |  1 |  1 |  0 |  0 |  3
Blithering Badgers             |  1 |  0 |  0 |  1 |  0"

    assert_in_to_out "$input" "$expected"
}

@test "a different team can win" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    input="Blithering Badgers;Allegoric Alaskans;win"

    expected="\
Team                           | MP |  W |  D |  L |  P
Blithering Badgers             |  1 |  1 |  0 |  0 |  3
Allegoric Alaskans             |  1 |  0 |  0 |  1 |  0"

    assert_in_to_out "$input" "$expected"
}

@test "a draw is one point each" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    input="Allegoric Alaskans;Blithering Badgers;draw"

    expected="\
Team                           | MP |  W |  D |  L |  P
Allegoric Alaskans             |  1 |  0 |  1 |  0 |  1
Blithering Badgers             |  1 |  0 |  1 |  0 |  1"

    assert_in_to_out "$input" "$expected"
}

@test "There can be more than one match" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    input="\
Allegoric Alaskans;Blithering Badgers;win
Allegoric Alaskans;Blithering Badgers;win"

    expected="\
Team                           | MP |  W |  D |  L |  P
Allegoric Alaskans             |  2 |  2 |  0 |  0 |  6
Blithering Badgers             |  2 |  0 |  0 |  2 |  0"

    assert_in_to_out "$input" "$expected"
}

@test "There can be more than one winner" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    input="\
Allegoric Alaskans;Blithering Badgers;loss
Allegoric Alaskans;Blithering Badgers;win"

    expected="\
Team                           | MP |  W |  D |  L |  P
Allegoric Alaskans             |  2 |  1 |  0 |  1 |  3
Blithering Badgers             |  2 |  1 |  0 |  1 |  3"

    assert_in_to_out "$input" "$expected"
}

@test "There can be more than two teams" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    input="\
Allegoric Alaskans;Blithering Badgers;win
Blithering Badgers;Courageous Californians;win
Courageous Californians;Allegoric Alaskans;loss"

    expected="\
Team                           | MP |  W |  D |  L |  P
Allegoric Alaskans             |  2 |  2 |  0 |  0 |  6
Blithering Badgers             |  2 |  1 |  0 |  1 |  3
Courageous Californians        |  2 |  0 |  0 |  2 |  0"

    assert_in_to_out "$input" "$expected"
}

@test "typical input" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    input="\
Allegoric Alaskans;Blithering Badgers;win
Devastating Donkeys;Courageous Californians;draw
Devastating Donkeys;Allegoric Alaskans;win
Courageous Californians;Blithering Badgers;loss
Blithering Badgers;Devastating Donkeys;loss
Allegoric Alaskans;Courageous Californians;win"

    expected="\
Team                           | MP |  W |  D |  L |  P
Devastating Donkeys            |  3 |  2 |  1 |  0 |  7
Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6
Blithering Badgers             |  3 |  1 |  0 |  2 |  3
Courageous Californians        |  3 |  0 |  1 |  2 |  1"

    assert_in_to_out "$input" "$expected"
}

@test "incomplete competition (not all pairs have played)" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    input="\
Allegoric Alaskans;Blithering Badgers;loss
Devastating Donkeys;Allegoric Alaskans;loss
Courageous Californians;Blithering Badgers;draw
Allegoric Alaskans;Courageous Californians;win"

    expected="\
Team                           | MP |  W |  D |  L |  P
Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6
Blithering Badgers             |  2 |  1 |  1 |  0 |  4
Courageous Californians        |  2 |  0 |  1 |  1 |  1
Devastating Donkeys            |  1 |  0 |  0 |  1 |  0"

    assert_in_to_out "$input" "$expected"
}

@test "ties broken alphabetically" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    input="\
Courageous Californians;Devastating Donkeys;win
Allegoric Alaskans;Blithering Badgers;win
Devastating Donkeys;Allegoric Alaskans;loss
Courageous Californians;Blithering Badgers;win
Blithering Badgers;Devastating Donkeys;draw
Allegoric Alaskans;Courageous Californians;draw"

    expected="\
Team                           | MP |  W |  D |  L |  P
Allegoric Alaskans             |  3 |  2 |  1 |  0 |  7
Courageous Californians        |  3 |  2 |  1 |  0 |  7
Blithering Badgers             |  3 |  0 |  1 |  2 |  1
Devastating Donkeys            |  3 |  0 |  1 |  2 |  1"

    assert_in_to_out "$input" "$expected"
}

@test "ensure points sorted numerically" {

    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    input="\
Devastating Donkeys;Blithering Badgers;win
Devastating Donkeys;Blithering Badgers;win
Devastating Donkeys;Blithering Badgers;win
Devastating Donkeys;Blithering Badgers;win
Blithering Badgers;Devastating Donkeys;win"

    expected="\
Team                           | MP |  W |  D |  L |  P
Devastating Donkeys            |  5 |  4 |  0 |  1 | 12
Blithering Badgers             |  5 |  1 |  0 |  4 |  3"

    assert_in_to_out "$input" "$expected"
}
