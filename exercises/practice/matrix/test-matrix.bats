#!/usr/bin/env bats
load bats-extra

teardown() {
    rm input.txt
}

# row tests

@test "extract row from one number matrix" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip

    printf "%s\n" "1" > input.txt

    run gawk '
        @include "matrix"
        BEGIN {
            matrix::read("input.txt", mtx)
            print matrix::row(mtx, 1)
        }
    '

    assert_success
    assert_output "1"
}

@test "can extract row" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    printf "%s\n" "1 2" "3 4" > input.txt

    run gawk '
        @include "matrix"
        BEGIN {
            matrix::read("input.txt", mtx)
            print matrix::row(mtx, 2)
        }
    '

    assert_success
    assert_output "3 4"
}

@test "extract row where numbers have different widths" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    printf "%s\n" "1 2" "10 20" > input.txt

    run gawk '
        @include "matrix"
        BEGIN {
            matrix::read("input.txt", mtx)
            print matrix::row(mtx, 2)
        }
    '

    assert_success
    assert_output "10 20"
}

@test "can extract row from non-square matrix" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    printf "%s\n" "1 2 3" "4 5 6" "7 8 9" "8 7 6" > input.txt

    run gawk '
        @include "matrix"
        BEGIN {
            matrix::read("input.txt", mtx)
            print matrix::row(mtx, 3)
        }
    '

    assert_success
    assert_output "7 8 9"
}

@test "can extract row from non-square matrix with no corresponding column" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    printf "%s\n" "1 2 3" "4 5 6" "7 8 9" "8 7 6" > input.txt

    run gawk '
        @include "matrix"
        BEGIN {
            matrix::read("input.txt", mtx)
            print matrix::row(mtx, 4)
        }
    '

    assert_success
    assert_output "8 7 6"
}

# column tests

@test "extract column from one number matrix" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    printf "%s\n" "1" > input.txt

    run gawk '
        @include "matrix"
        BEGIN {
            matrix::read("input.txt", mtx)
            print matrix::column(mtx, 1)
        }
    '

    assert_success
    assert_output "1"
}

@test "can extract column" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    printf "%s\n" "1 2 3" "4 5 6" "7 8 9" > input.txt

    run gawk '
        @include "matrix"
        BEGIN {
            matrix::read("input.txt", mtx)
            print matrix::column(mtx, 3)
        }
    '

    assert_success
    assert_output "3 6 9"
}

@test "can extract column from non-square matrix" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    printf "%s\n" "1 2 3" "4 5 6" "7 8 9" "8 7 6" > input.txt

    run gawk '
        @include "matrix"
        BEGIN {
            matrix::read("input.txt", mtx)
            print matrix::column(mtx, 3)
        }
    '

    assert_success
    assert_output "3 6 9 6"
}

@test "can extract column from non-square matrix with no corresponding row" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    printf "%s\n" "1 2 3 4" "5 6 7 8" "9 8 7 6" > input.txt

    run gawk '
        @include "matrix"
        BEGIN {
            matrix::read("input.txt", mtx)
            print matrix::column(mtx, 4)
        }
    '

    assert_success
    assert_output "4 8 6"
}

@test "extract column where numbers have different widths" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    printf "%s\n" "89 1903 3" "18 3 1" "9 4 800" > input.txt

    run gawk '
        @include "matrix"
        BEGIN {
            matrix::read("input.txt", mtx)
            print matrix::column(mtx, 2)
        }
    '

    assert_success
    assert_output "1903 3 4"
}
