#!/usr/bin/env bats
load bats-extra

#
# Create a new clock with an initial time
#

@test "on the hour" {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "8 0"
  assert_success
  assert_output "08:00"
}

@test "past the hour" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "11 9"
  assert_success
  assert_output "11:09"
}

@test "midnight is zero hours" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "24 0"
  assert_success
  assert_output "00:00"
}

@test "hour rolls over" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "25 0"
  assert_success
  assert_output "01:00"
}

@test "hour rolls over continuously" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "100 0"
  assert_success
  assert_output "04:00"
}

@test "sixty minutes is next hour" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "1 60"
  assert_success
  assert_output "02:00"
}

@test "minutes roll over" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "0 160"
  assert_success
  assert_output "02:40"
}

@test "minutes roll over continuously" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "0 1723"
  assert_success
  assert_output "04:43"
}

@test "hour and minutes roll over" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "25 160"
  assert_success
  assert_output "03:40"
}

@test "hour and minutes roll over continuously" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "201 3001"
  assert_success
  assert_output "11:01"
}

@test "hour and minutes roll over to exactly midnight" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "72 8640"
  assert_success
  assert_output "00:00"
}

@test "negative hour" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "-1 15"
  assert_success
  assert_output "23:15"
}

@test "negative hour rolls over" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "-25 0"
  assert_success
  assert_output "23:00"
}

@test "negative hour rolls over continuously" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "-91 0"
  assert_success
  assert_output "05:00"
}

@test "negative minutes" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "1 -40"
  assert_success
  assert_output "00:20"
}

@test "negative minutes roll over" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "1 -160"
  assert_success
  assert_output "22:20"
}

@test "negative minutes roll over continuously" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "1 -4820"
  assert_success
  assert_output "16:40"
}

@test "negative sixty minutes is previous hour" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "2 -60"
  assert_success
  assert_output "01:00"
}

@test "negative hour and minutes both roll over" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "-25 -160"
  assert_success
  assert_output "20:20"
}

@test "negative hour and minutes both roll over continuously" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "-121 -5810"
  assert_success
  assert_output "22:10"
}

#
# Add minutes
#

@test "add minutes" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "10 0 add 3"
  assert_success
  assert_output "10:03"
}

@test "add no minutes" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "6 41 add 0"
  assert_success
  assert_output "06:41"
}

@test "add to next hour" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "0 45 add 40"
  assert_success
  assert_output "01:25"
}

@test "add more than one hour" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "10 0 add 61"
  assert_success
  assert_output "11:01"
}

@test "add more than two hours with carry" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "0 45 add 160"
  assert_success
  assert_output "03:25"
}

@test "add across midnight" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "23 59 add 2"
  assert_success
  assert_output "00:01"
}

@test "add more than one day (1500 min = 25 hrs)" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "5 32 add 1500"
  assert_success
  assert_output "06:32"
}

@test "add more than two days" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "1 1 add 3500"
  assert_success
  assert_output "11:21"
}

#
# Subtract minutes
#

@test "subtract minutes" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "10 3 subtract 3"
  assert_success
  assert_output "10:00"
}

@test "subtract to previous hour" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "10 3 subtract 30"
  assert_success
  assert_output "09:33"
}

@test "subtract more than an hour" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "10 3 subtract 70"
  assert_success
  assert_output "08:53"
}

@test "subtract across midnight" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "0 3 subtract 4"
  assert_success
  assert_output "23:59"
}

@test "subtract more than two hours" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "0 0 subtract 160"
  assert_success
  assert_output "21:20"
}

@test "subtract more than two hours with borrow" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "6 15 subtract 160"
  assert_success
  assert_output "03:35"
}

@test "subtract more than one day (1500 min = 25 hrs)" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "5 32 subtract 1500"
  assert_success
  assert_output "04:32"
}

@test "subtract more than two days" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "2 20 subtract 3000"
  assert_success
  assert_output "00:20"
}

#
# Compare two clocks for equality
#

@test "clocks with same time" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "15 37 equal 15 37"
  assert_success
  assert_output "true"
}

@test "clocks a minute apart" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "15 36 equal 15 37"
  assert_success
  assert_output "false"
}

@test "clocks an hour apart" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "14 37 equal 15 37"
  assert_success
  assert_output "false"
}

@test "clocks with hour overflow" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "10 37 equal 34 37"
  assert_success
  assert_output "true"
}

@test "clocks with hour overflow by several days" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "3 11 equal 99 11"
  assert_success
  assert_output "true"
}

@test "clocks with negative hour" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "22 40 equal -2 40"
  assert_success
  assert_output "true"
}

@test "clocks with negative hour that wraps" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "17 3 equal -31 3"
  assert_success
  assert_output "true"
}

@test "clocks with negative hour that wraps multiple times" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "13 49 equal -83 49"
  assert_success
  assert_output "true"
}

@test "clocks with minute overflow" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "0 1 equal 0 1441"
  assert_success
  assert_output "true"
}

@test "clocks with minute overflow by several days" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "2 2 equal 2 4322"
  assert_success
  assert_output "true"
}

@test "clocks with negative minute" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "2 40 equal 3 -20"
  assert_success
  assert_output "true"
}

@test "clocks with negative minute that wraps" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "4 10 equal 5 -1490"
  assert_success
  assert_output "true"
}

@test "clocks with negative minute that wraps multiple times" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "6 15 equal 6 -4305"
  assert_success
  assert_output "true"
}

@test "clocks with negative hours and minutes" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "7 32 equal -12 -268"
  assert_success
  assert_output "true"
}

@test "clocks with negative hours and minutes that wrap" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "18 7 equal -54 -11513"
  assert_success
  assert_output "true"
}

@test "full clock and zeroed clock" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f clock.awk <<< "24 0 equal 0 0"
  assert_success
  assert_output "true"
}
