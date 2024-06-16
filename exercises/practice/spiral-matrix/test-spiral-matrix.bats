#!/usr/bin/env bats
load bats-extra

@test "empty spiral" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -v size=0 -f spiral-matrix.awk < /dev/null
    assert_success
    assert_output ""
}

@test "trivial spiral" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -v size=1 -f spiral-matrix.awk < /dev/null
    assert_success
    assert_output "1"
}

@test "spiral of size 2" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -v size=2 -f spiral-matrix.awk < /dev/null
    assert_success
    assert_line -n 0  "1 2"
    assert_line -n 1  "4 3"
}

@test "spiral of size 3" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -v size=3 -f spiral-matrix.awk < /dev/null
    assert_success
    assert_line -n 0  "1 2 3"
    assert_line -n 1  "8 9 4"
    assert_line -n 2  "7 6 5"
}

@test "spiral of size 4" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -v size=4 -f spiral-matrix.awk < /dev/null
    assert_success
    assert_line -n 0  "1 2 3 4"
    assert_line -n 1  "12 13 14 5"
    assert_line -n 2  "11 16 15 6"
    assert_line -n 3  "10 9 8 7"
}

@test "spiral of size 5" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -v size=5 -f spiral-matrix.awk < /dev/null
    assert_success
    assert_line -n 0  "1 2 3 4 5"
    assert_line -n 1  "16 17 18 19 6"
    assert_line -n 2  "15 24 25 20 7"
    assert_line -n 3  "14 23 22 21 8"
    assert_line -n 4  "13 12 11 10 9"
}
