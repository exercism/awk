#!/usr/bin/env bats

function validate_maze {
  result="$(\
    gawk --file mazy-mice.awk --assign Rows=$1 --assign Cols=$2 --assign Seed=$3 \
    | gawk --file test-maze.awk --assign Rows=$1 --assign Cols=$2 --assign Seed=$3 )"
  [ "$result" = "The maze is perfect." ]
}

@test "the smallest square maze is perfect" {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
  validate_maze 5 5
}

@test "the small rectangular maze is perfect" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  validate_maze 5 10
}

@test "the square maze is perfect" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  validate_maze 10 10
}

@test "the large rectangular maze is perfect" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  validate_maze 10 20
}

@test "the rectangular maze with aspect 2:1 is perfect" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  validate_maze 20 10
}

@test "the huge rectangular maze is perfect" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  validate_maze 20 100
}

@test "the huge square maze is perfect" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  validate_maze 100 100
}

@test "if the seed parameter is specified, the perfect maze generated" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  validate_maze 50 50 2342342
}

@test "if the seed parameter is omitted, random mazes should be generated" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  maze_one=$(gawk --file mazy-mice.awk --assign Rows=8 --assign Cols=16)
  # If the argument x is omitted, as in ‘srand()’, then the current date and time of day are used for a seed.
  # https://www.gnu.org/software/gawk/manual/html_node/Numeric-Functions.html#index-srand_0028_0029-function
  # So, we must wait a second to ensure the seed is different.
  sleep 1
  maze_two=$(gawk --file mazy-mice.awk --assign Rows=8 --assign Cols=16)
  [[ $maze_one != "$maze_two" ]]
}

@test "if the seed parameter is specified, the same maze should be generated" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  maze_one=$(gawk --file mazy-mice.awk --assign Rows=8 --assign Cols=16 --assign Seed=123)
  # We must wait a second to ensure the system's default seed differs.
  sleep 1
  maze_two=$(gawk --file mazy-mice.awk --assign Rows=8 --assign Cols=16 --assign Seed=123)
  [[ $maze_one == "$maze_two" ]]
}
