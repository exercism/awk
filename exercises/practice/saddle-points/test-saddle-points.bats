#!/usr/bin/env bats
load bats-extra

# The AWK script is called saddle-points.awk
#
# Input to the script is a matrix of space-separated numbers.
#
# 9 8 7
# 5 3 2
# 6 6 7
#
# Output of the script is the coordinates of the saddle points.
#
# 2 1

@test "Can identify single saddle point" {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f saddle-points.awk <<END_INPUT
9 8 7
5 3 2
6 6 7
END_INPUT
  assert_success
  assert_output "2 1"
}

@test "Can identify that empty matrix has no saddle points" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f saddle-points.awk <<END_INPUT

END_INPUT
  assert_success
  assert_output ""
}

@test "Can identify lack of saddle points when there are none" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f saddle-points.awk <<END_INPUT
1 2 3
3 1 2
2 3 1
END_INPUT
  assert_success
  assert_output ""
}

@test "Can identify multiple saddle points in a column" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f saddle-points.awk <<END_INPUT
4 5 4
3 5 5
1 5 4
END_INPUT
  assert_success
  assert_output "1 2
2 2
3 2"
}

@test "Can identify multiple saddle points in a row" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f saddle-points.awk <<END_INPUT
6 7 8
5 5 5
7 5 6
END_INPUT
  assert_success
  assert_output "2 1
2 2
2 3"
}

@test "Can identify saddle point in bottom right corner" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f saddle-points.awk <<END_INPUT
8 7 9
6 7 6
3 2 5
END_INPUT
  assert_success
  assert_output "3 3"
}

@test "Can identify saddle points in a non square matrix" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f saddle-points.awk <<END_INPUT
3 1 3
3 2 4
END_INPUT
  assert_success
  assert_output "1 1
1 3"
}

@test "Can identify that saddle points in a single column matrix are those with the minimum value" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f saddle-points.awk <<END_INPUT
2
1
4
1
END_INPUT
  assert_success
  assert_output "2 1
4 1"
}

@test "Can identify that saddle points in a single row matrix are those with the maximum value" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f saddle-points.awk <<END_INPUT
2 5 3 5
END_INPUT
  assert_success
  assert_output "1 2
1 4"
}
