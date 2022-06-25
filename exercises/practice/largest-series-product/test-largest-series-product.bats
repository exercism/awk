#!/usr/bin/env bats
load bats-extra

@test "finds the largest product if span equals length" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f largest-series-product.awk <<< "29,2"
    assert_success
    assert_output "18"
}

@test "can find the largest product of 2 with numbers in order" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f largest-series-product.awk <<< "0123456789,2"
    assert_success
    assert_output "72"
}

@test "can find the largest product of 2" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f largest-series-product.awk <<< "576802143,2"
    assert_success
    assert_output "48"
}

@test "can find the largest product of 3 with numbers in order" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f largest-series-product.awk <<< "0123456789,3"
    assert_success
    assert_output "504"
}

@test "can find the largest product of 3" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f largest-series-product.awk <<< "1027839564,3"
    assert_success
    assert_output "270"
}

@test "can find the largest product of 5 with numbers in order" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f largest-series-product.awk <<< "0123456789,5"
    assert_success
    assert_output "15120"
}

@test "can get the largest product of a big number" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f largest-series-product.awk <<< "73167176531330624919225119674426574742355349194934,6"
    assert_success
    assert_output "23520"
}

@test "reports zero if the only digits are zero" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f largest-series-product.awk <<< "0000,2"
    assert_success
    assert_output "0"
}

@test "reports zero if all spans include zero" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f largest-series-product.awk <<< "99099,3"
    assert_success
    assert_output "0"
}

# There may be some confusion about whether this should be 1 or error.
# The reasoning for it being 1 is this:
# There is one 0-character string contained in the empty string.
# That's the empty string itself.
# The empty product is 1 (the identity for multiplication).
# Therefore LSP('', 0) is 1.
# It's NOT the case that LSP('', 0) takes max of an empty list.
# So there is no error.
# Compare against LSP('123', 4):
# There are zero 4-character strings in '123'.
# So LSP('123', 4) really DOES take the max of an empty list.
# So LSP('123', 4) errors and LSP('', 0) does NOT.

@test "reports 1 for empty string and empty product (0 span)" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f largest-series-product.awk <<< ",0"
    assert_success
    assert_output "1"
}

# As above, there is one 0-character string in '123'.
# So again no error. It's the empty product, 1.

@test "reports 1 for nonempty string and empty product (0 span)" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f largest-series-product.awk <<< "123,0"
    assert_success
    assert_output "1"
}

# error cases

@test "rejects span longer than string length" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f largest-series-product.awk <<< "123,4"
    assert_failure
    assert_output --partial "span must be smaller than string length"
}

@test "rejects empty string and nonzero span" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f largest-series-product.awk <<< ",1"
    assert_failure
    assert_output --partial "span must be smaller than string length"
}

@test "rejects invalid character in digits" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f largest-series-product.awk <<< "1234a5,2"
    assert_failure
    assert_output --partial "input must only contain digits"
}

@test "rejects negative span" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f largest-series-product.awk <<< "12345,-1"
    assert_failure
    assert_output --partial "span must not be negative"
}
