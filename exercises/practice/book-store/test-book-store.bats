#!/usr/bin/env bats
load bats-extra

@test "Only a single book" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f book-store.awk <<END_INPUT
1
END_INPUT
    assert_success
    assert_output "800"
}

@test "Two of the same book" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f book-store.awk <<END_INPUT
2
2
END_INPUT
    assert_success
    assert_output "1600"
}

@test "Empty basket" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f book-store.awk <<END_INPUT
END_INPUT
    assert_success
    assert_output "0"
}

@test "Two different books" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f book-store.awk <<END_INPUT
1
2
END_INPUT
    assert_success
    assert_output "1520"
}

@test "Three different books" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f book-store.awk <<END_INPUT
1
2
3
END_INPUT
    assert_success
    assert_output "2160"
}

@test "Four different books" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f book-store.awk <<END_INPUT
1
2
3
4
END_INPUT
    assert_success
    assert_output "2560"
}

@test "Five different books" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f book-store.awk <<END_INPUT
1
2
3
4
5
END_INPUT
    assert_success
    assert_output "3000"
}

@test "Two groups of four is cheaper than group of five plus group of three" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f book-store.awk <<END_INPUT
1
1
2
2
3
3
4
5
END_INPUT
    assert_success
    assert_output "5120"
}

@test "Two groups of four is cheaper than groups of five and three" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f book-store.awk <<END_INPUT
1
1
2
3
4
4
5
5
END_INPUT
    assert_success
    assert_output "5120"
}

@test "Group of four plus group of two is cheaper than two groups of three" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f book-store.awk <<END_INPUT
1
1
2
2
3
4
END_INPUT
    assert_success
    assert_output "4080"
}

@test "Two each of first four books and one copy each of rest" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f book-store.awk <<END_INPUT
1
1
2
2
3
3
4
4
5
END_INPUT
    assert_success
    assert_output "5560"
}

@test "Two copies of each book" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f book-store.awk <<END_INPUT
1
1
2
2
3
3
4
4
5
5
END_INPUT
    assert_success
    assert_output "6000"
}

@test "Three copies of first book and two each of remaining" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f book-store.awk <<END_INPUT
1
1
2
2
3
3
4
4
5
5
1
END_INPUT
    assert_success
    assert_output "6800"
}

@test "Three each of first two books and two each of remaining books" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f book-store.awk <<END_INPUT
1
1
2
2
3
3
4
4
5
5
1
2
END_INPUT
    assert_success
    assert_output "7520"
}

@test "Four groups of four are cheaper than two groups each of five and three" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f book-store.awk <<END_INPUT
1
1
2
2
3
3
4
5
1
1
2
2
3
3
4
5
END_INPUT
    assert_success
    assert_output "10240"
}

@test "Check that groups of four are created properly even when there are more groups of three than groups of five" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f book-store.awk <<END_INPUT
1
1
1
1
1
1
2
2
2
2
2
2
3
3
3
3
3
3
4
4
5
5
END_INPUT
    assert_success
    assert_output "14560"
}

@test "One group of one and four is cheaper than one group of two and three" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f book-store.awk <<END_INPUT
1
1
2
3
4
END_INPUT
    assert_success
    assert_output "3360"
}

@test "One group of one and two plus three groups of four is cheaper than one group of each size" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f book-store.awk <<END_INPUT
1
2
2
3
3
3
4
4
4
4
5
5
5
5
5
END_INPUT
    assert_success
    assert_output "10000"
}
