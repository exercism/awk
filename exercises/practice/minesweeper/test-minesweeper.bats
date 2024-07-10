#!/usr/bin/env bats
load bats-extra

# Check if the given string is an isogram

@test "no rows" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f minesweeper.awk < /dev/null
    assert_success
    assert_output ""
}

@test "no columns" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f minesweeper.awk <<< ""
    assert_success
    assert_output ""
}

@test "no mines" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f minesweeper.awk << END_INPUT
...
...
...
END_INPUT
    assert_success
    assert_line --index 0 "..."
    assert_line --index 1 "..."
    assert_line --index 2 "..."
}

@test "minefield with only mines" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f minesweeper.awk << END_INPUT
***
***
***
END_INPUT
    assert_success
    assert_line --index 0 "***"
    assert_line --index 1 "***"
    assert_line --index 2 "***"
}

@test "mine surrounded by spaces" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f minesweeper.awk << END_INPUT
...
.*.
...
END_INPUT
    assert_success
    assert_line --index 0 "111"
    assert_line --index 1 "1*1"
    assert_line --index 2 "111"
}

@test "space surrounded by mines" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f minesweeper.awk << END_INPUT
***
*.*
***
END_INPUT
    assert_success
    assert_line --index 0 "***"
    assert_line --index 1 "*8*"
    assert_line --index 2 "***"
}

@test "horizontal line" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f minesweeper.awk << END_INPUT
.*.*.
END_INPUT
    assert_success
    assert_output "1*2*1"
}

@test "horizontal line, mines at edges" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f minesweeper.awk << END_INPUT
*...*
END_INPUT
    assert_success
    assert_output "*1.1*"
}

@test "vertical line" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f minesweeper.awk << END_INPUT
.
*
.
*
.
END_INPUT
    assert_success
    assert_line --index 0 "1"
    assert_line --index 1 "*"
    assert_line --index 2 "2"
    assert_line --index 3 "*"
    assert_line --index 4 "1"
}

@test "vertical line, mines at edges" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f minesweeper.awk << END_INPUT
*
.
.
.
*
END_INPUT
    assert_success
    assert_line --index 0 "*"
    assert_line --index 1 "1"
    assert_line --index 2 "."
    assert_line --index 3 "1"
    assert_line --index 4 "*"
}

@test "cross" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f minesweeper.awk << END_INPUT
..*..
..*..
*****
..*..
..*..
END_INPUT
    assert_success
    assert_line --index 0 ".2*2."
    assert_line --index 1 "25*52"
    assert_line --index 2 "*****"
    assert_line --index 3 "25*52"
    assert_line --index 4 ".2*2."
}

@test "large minefield" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f minesweeper.awk << END_INPUT
.*..*.
..*...
....*.
...*.*
.*..*.
......
END_INPUT
    assert_success
    assert_line --index 0 "1*22*1"
    assert_line --index 1 "12*322"
    assert_line --index 2 ".123*2"
    assert_line --index 3 "112*4*"
    assert_line --index 4 "1*22*2"
    assert_line --index 5 "111111"
}
