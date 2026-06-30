#!/usr/bin/env bats
load bats-extra

# generated on 2026-06-30T15:57:51+00:00

@test "word beginning with a" {
    # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "apple"
    assert_success
    assert_output "appleay"
}

@test "word beginning with e" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "ear"
    assert_success
    assert_output "earay"
}

@test "word beginning with i" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "igloo"
    assert_success
    assert_output "iglooay"
}

@test "word beginning with o" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "object"
    assert_success
    assert_output "objectay"
}

@test "word beginning with u" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "under"
    assert_success
    assert_output "underay"
}

@test "word beginning with a vowel and followed by a qu" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "equal"
    assert_success
    assert_output "equalay"
}

@test "word beginning with p" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "pig"
    assert_success
    assert_output "igpay"
}

@test "word beginning with k" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "koala"
    assert_success
    assert_output "oalakay"
}

@test "word beginning with x" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "xenon"
    assert_success
    assert_output "enonxay"
}

@test "word beginning with q without a following u" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "qat"
    assert_success
    assert_output "atqay"
}

@test "word beginning with consonant and vowel containing qu" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "liquid"
    assert_success
    assert_output "iquidlay"
}

@test "word beginning with ch" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "chair"
    assert_success
    assert_output "airchay"
}

@test "word beginning with qu" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "queen"
    assert_success
    assert_output "eenquay"
}

@test "word beginning with qu and a preceding consonant" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "square"
    assert_success
    assert_output "aresquay"
}

@test "word beginning with th" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "therapy"
    assert_success
    assert_output "erapythay"
}

@test "word beginning with thr" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "thrush"
    assert_success
    assert_output "ushthray"
}

@test "word beginning with sch" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "school"
    assert_success
    assert_output "oolschay"
}

@test "word beginning with yt" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "yttria"
    assert_success
    assert_output "yttriaay"
}

@test "word beginning with xr" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "xray"
    assert_success
    assert_output "xrayay"
}

@test "y is treated like a consonant at the beginning of a word" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "yellow"
    assert_success
    assert_output "ellowyay"
}

@test "y is treated like a vowel at the end of a consonant cluster" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "rhythm"
    assert_success
    assert_output "ythmrhay"
}

@test "y as second letter in two letter word" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "my"
    assert_success
    assert_output "ymay"
}

@test "a whole phrase" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "quick fast run"
    assert_success
    assert_output "ickquay astfay unray"
}
