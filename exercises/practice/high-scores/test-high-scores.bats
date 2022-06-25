#!/usr/bin/env bats
load bats-extra

@test "List of scores" {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f high-scores.awk << END_INPUT
30
50
20
70
list
END_INPUT

  assert_success
  assert_line --index 0 -- 30
  assert_line --index 1 -- 50
  assert_line --index 2 -- 20
  assert_line --index 3 -- 70
  assert_equal "${#lines[@]}" 4
}

@test "Latest score" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f high-scores.awk << END_INPUT
100
0
90
30
latest
END_INPUT

  assert_success
  assert_output "30"
}

@test "Personal best" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f high-scores.awk << END_INPUT
40
100
70
personalBest
END_INPUT

  assert_success
  assert_output "100"
}

@test "Personal top three from a list of scores" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f high-scores.awk << END_INPUT
10
30
90
30
100
20
10
0
30
40
40
70
70
personalTopThree
END_INPUT

  assert_success
  assert_line --index 0 -- "100"
  assert_line --index 1 -- "90"
  assert_line --index 2 -- "70"
  assert_equal "${#lines[@]}" 3
}

@test "Personal top three from highest to lowest" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f high-scores.awk << END_INPUT
20
10
30
personalTopThree
END_INPUT

  assert_success
  assert_line --index 0 -- "30"
  assert_line --index 1 -- "20"
  assert_line --index 2 -- "10"
  assert_equal "${#lines[@]}" 3
}

@test "Personal top three when there is a tie" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f high-scores.awk << END_INPUT
40
20
40
30
personalTopThree
END_INPUT

  assert_success
  assert_line --index 0 -- "40"
  assert_line --index 1 -- "40"
  assert_line --index 2 -- "30"
  assert_equal "${#lines[@]}" 3
}

@test "Personal top three when there are less then 3" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f high-scores.awk << END_INPUT
30
70
personalTopThree
END_INPUT

  assert_success
  assert_line --index 0 -- "70"
  assert_line --index 1 -- "30"
  assert_equal "${#lines[@]}" 2
}

@test "Personal top three when there is only one" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f high-scores.awk << END_INPUT
40
personalTopThree
END_INPUT

  assert_success
  assert_output "40"
}

@test "Latest score after personal top scores" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f high-scores.awk << END_INPUT
70
50
20
30
personalTopThree
latest
END_INPUT

  assert_success
  assert_line --index 0 -- 70
  assert_line --index 1 -- 50
  assert_line --index 2 -- 30
  assert_line --index 3 -- 30
  assert_equal "${#lines[@]}" 4
}

@test "Scores after personal top scores" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f high-scores.awk << END_INPUT
30
50
20
70
personalTopThree
list
END_INPUT

  assert_success
  assert_line --index 0 -- 70
  assert_line --index 1 -- 50
  assert_line --index 2 -- 30
  assert_line --index 3 -- 30
  assert_line --index 4 -- 50
  assert_line --index 5 -- 20
  assert_line --index 6 -- 70
  assert_equal "${#lines[@]}" 7
}

@test "Latest score after personal best" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f high-scores.awk << END_INPUT
20
70
15
25
30
personalBest
latest
END_INPUT

  assert_success
  assert_line --index 0 -- 70
  assert_line --index 1 -- 30
  assert_equal "${#lines[@]}" 2
}

@test "Scores after personal best" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f high-scores.awk << END_INPUT
20
70
15
25
30
personalBest
list
END_INPUT

  assert_success
  assert_line --index 0 -- 70
  assert_line --index 1 -- 20
  assert_line --index 2 -- 70
  assert_line --index 3 -- 15
  assert_line --index 4 -- 25
  assert_line --index 5 -- 30
  assert_equal "${#lines[@]}" 6
}
