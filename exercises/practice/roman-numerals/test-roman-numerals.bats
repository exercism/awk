#!/usr/bin/env bats
load bats-extra

@test "1 is a single I" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 1
    assert_success
    assert_output "I"
}

@test "2 is two I's" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 2
    assert_success
    assert_output "II"
}

@test "3 is three I's" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 3
    assert_success
    assert_output "III"
}

@test "4, being 5 - 1, is IV" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 4
    assert_success
    assert_output "IV"
}

@test "5 is a single V" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 5
    assert_success
    assert_output "V"
}

@test "6, being 5 + 1, is VI" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 6
    assert_success
    assert_output "VI"
}

@test "9, being 10 - 1, is IX" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 9
    assert_success
    assert_output "IX"
}

@test "20 is two X's" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 27
    assert_success
    assert_output "XXVII"
}

@test "48 is not 50 - 2 but rather 40 + 8" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 48
    assert_success
    assert_output "XLVIII"
}

@test "49 is not 40 + 5 + 4 but rather 50 - 10 + 10 - 1" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 49
    assert_success
    assert_output "XLIX"
}

@test "50 is a single L" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 59
    assert_success
    assert_output "LIX"
}

@test "90, being 100 - 10, is XC" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 93
    assert_success
    assert_output "XCIII"
}

@test "100 is a single C" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 141
    assert_success
    assert_output "CXLI"
}

@test "60, being 50 + 10, is LX" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 163
    assert_success
    assert_output "CLXIII"
}

@test "400, being 500 - 100, is CD" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 402
    assert_success
    assert_output "CDII"
}

@test "500 is a single D" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 575
    assert_success
    assert_output "DLXXV"
}

@test "900, being 1000 - 100, is CM" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 911
    assert_success
    assert_output "CMXI"
}

@test "1000 is a single M" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 1024
    assert_success
    assert_output "MXXIV"
}

@test "3000 is three M's" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 3000
    assert_success
    assert_output "MMM"
}

@test "3001 is three MMMI" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 3001
    assert_success
    assert_output "MMMI"
}

@test "3999 is three MMMCMXCIX" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 3999
    assert_success
    assert_output "MMMCMXCIX"
}


# testing numbers with all roman numerals below a threshold

@test "16 is XVI" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 16
    assert_success
    assert_output "XVI"
}

@test "66 is LXVI" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 66
    assert_success
    assert_output "LXVI"
}

@test "166 is CLXVI" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 166
    assert_success
    assert_output "CLXVI"
}

@test "666 is DCLXVI" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 666
    assert_success
    assert_output "DCLXVI"
}

@test "1666 is MDCLXVI" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 1666
    assert_success
    assert_output "MDCLXVI"
}

@test "3888 is MMMDCCCLXXXVIII" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f roman-numerals.awk <<< 3888
    assert_success
    assert_output "MMMDCCCLXXXVIII"
}
