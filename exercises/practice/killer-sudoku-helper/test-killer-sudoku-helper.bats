#!/usr/bin/env bats
load bats-extra

# generated on 2026-06-30T01:58:42+00:00

@test "1" {
  # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  expected=$(cat << END
1
END
)
  run gawk -f killer-sudoku-helper.awk <<< "1 1"
  assert_success
  assert_output "$expected"
}

@test "2" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  expected=$(cat << END
2
END
)
  run gawk -f killer-sudoku-helper.awk <<< "2 1"
  assert_success
  assert_output "$expected"
}

@test "3" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  expected=$(cat << END
3
END
)
  run gawk -f killer-sudoku-helper.awk <<< "3 1"
  assert_success
  assert_output "$expected"
}

@test "4" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  expected=$(cat << END
4
END
)
  run gawk -f killer-sudoku-helper.awk <<< "4 1"
  assert_success
  assert_output "$expected"
}

@test "5" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  expected=$(cat << END
5
END
)
  run gawk -f killer-sudoku-helper.awk <<< "5 1"
  assert_success
  assert_output "$expected"
}

@test "6" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  expected=$(cat << END
6
END
)
  run gawk -f killer-sudoku-helper.awk <<< "6 1"
  assert_success
  assert_output "$expected"
}

@test "7" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  expected=$(cat << END
7
END
)
  run gawk -f killer-sudoku-helper.awk <<< "7 1"
  assert_success
  assert_output "$expected"
}

@test "8" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  expected=$(cat << END
8
END
)
  run gawk -f killer-sudoku-helper.awk <<< "8 1"
  assert_success
  assert_output "$expected"
}

@test "9" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  expected=$(cat << END
9
END
)
  run gawk -f killer-sudoku-helper.awk <<< "9 1"
  assert_success
  assert_output "$expected"
}

@test "Cage with sum 45 contains all digits 1:9" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  expected=$(cat << END
1 2 3 4 5 6 7 8 9
END
)
  run gawk -f killer-sudoku-helper.awk <<< "45 9"
  assert_success
  assert_output "$expected"
}

@test "Cage with only 1 possible combination" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  expected=$(cat << END
1 2 4
END
)
  run gawk -f killer-sudoku-helper.awk <<< "7 3"
  assert_success
  assert_output "$expected"
}

@test "Cage with several combinations" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  expected=$(cat << END
1 9
2 8
3 7
4 6
END
)
  run gawk -f killer-sudoku-helper.awk <<< "10 2"
  assert_success
  assert_output "$expected"
}

@test "Cage with several combinations that is restricted" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  expected=$(cat << END
2 8
3 7
END
)
  run gawk -f killer-sudoku-helper.awk <<< "10 2 1 4"
  assert_success
  assert_output "$expected"
}
