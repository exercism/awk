#!/usr/bin/env bats
load bats-extra

# generated on 2026-06-30T04:50:23+00:00

@test "all sides are equal, equilateral" {
  # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=equilateral <<< "2 2 2"
  assert_success
  assert_output "true"
}

@test "any side is unequal, equilateral" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=equilateral <<< "2 3 2"
  assert_success
  assert_output "false"
}

@test "no sides are equal, equilateral" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=equilateral <<< "5 4 6"
  assert_success
  assert_output "false"
}

@test "all zero sides is not a triangle, equilateral" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=equilateral <<< "0 0 0"
  assert_success
  assert_output "false"
}

@test "sides may be floats, equilateral" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=equilateral <<< "0.5 0.5 0.5"
  assert_success
  assert_output "true"
}

@test "last two sides are equal, isosceles" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=isosceles <<< "3 4 4"
  assert_success
  assert_output "true"
}

@test "first two sides are equal, isosceles" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=isosceles <<< "4 4 3"
  assert_success
  assert_output "true"
}

@test "first and last sides are equal, isosceles" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=isosceles <<< "4 3 4"
  assert_success
  assert_output "true"
}

@test "equilateral triangles are also isosceles, isosceles" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=isosceles <<< "4 4 4"
  assert_success
  assert_output "true"
}

@test "no sides are equal, isosceles" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=isosceles <<< "2 3 4"
  assert_success
  assert_output "false"
}

@test "first triangle inequality violation, isosceles" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=isosceles <<< "1 1 3"
  assert_success
  assert_output "false"
}

@test "second triangle inequality violation, isosceles" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=isosceles <<< "1 3 1"
  assert_success
  assert_output "false"
}

@test "third triangle inequality violation, isosceles" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=isosceles <<< "3 1 1"
  assert_success
  assert_output "false"
}

@test "sides may be floats, isosceles" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=isosceles <<< "0.5 0.4 0.5"
  assert_success
  assert_output "true"
}

@test "no sides are equal, scalene" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=scalene <<< "5 4 6"
  assert_success
  assert_output "true"
}

@test "all sides are equal, scalene" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=scalene <<< "4 4 4"
  assert_success
  assert_output "false"
}

@test "first and second sides are equal, scalene" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=scalene <<< "4 4 3"
  assert_success
  assert_output "false"
}

@test "first and third sides are equal, scalene" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=scalene <<< "3 4 3"
  assert_success
  assert_output "false"
}

@test "second and third sides are equal, scalene" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=scalene <<< "4 3 3"
  assert_success
  assert_output "false"
}

@test "may not violate triangle inequality, scalene" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=scalene <<< "7 3 2"
  assert_success
  assert_output "false"
}

@test "sides may be floats, scalene" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f triangle.awk -v type=scalene <<< "0.5 0.4 0.6"
  assert_success
  assert_output "true"
}
