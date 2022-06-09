#!/usr/bin/env bats
load bats-extra

# "ay" is added to words that start with vowels

@test word_beginning_with_a {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "apple"
    assert_success
    assert_output "appleay"
}

@test word_beginning_with_e {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "ear"
    assert_success
    assert_output "earay"
}

@test word_beginning_with_i {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "igloo"
    assert_success
    assert_output "iglooay"
}

@test word_beginning_with_o {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "object"
    assert_success
    assert_output "objectay"
}

@test word_beginning_with_u {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "under"
    assert_success
    assert_output "underay"
}

@test word_beginning_with_equ {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "equal"
    assert_success
    assert_output "equalay"
}

# first letter and ay are moved to the end of words that start with consonants

@test word_beginning_with_p {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "pig"
    assert_success
    assert_output "igpay"
}

@test word_beginning_with_k {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "koala"
    assert_success
    assert_output "oalakay"
}

@test word_beginning_with_x {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "xenon"
    assert_success
    assert_output "enonxay"
}

@test word_beginning_with_q_no_u {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "qat"
    assert_success
    assert_output "atqay"
}

# some letter clusters are treated like a single consonant

@test word_beginning_with_ch {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "chair"
    assert_success
    assert_output "airchay"
}

@test word_beginning_with_squ {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "square"
    assert_success
    assert_output "aresquay"
}

@test word_beginning_with_th {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "therapy"
    assert_success
    assert_output "erapythay"
}

@test word_beginning_with_thr {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "thrush"
    assert_success
    assert_output "ushthray"
}

@test word_beginning_with_sch {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "school"
    assert_success
    assert_output "oolschay"
}

# some letter clusters are treated like a single vowel

@test word_beginning_with_yt {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "yttria"
    assert_success
    assert_output "yttriaay"
}

@test word_beginning_with_xr {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "xray"
    assert_success
    assert_output "xrayay"
}

# position of y in a word determines if it is a consonant or a vowel

@test word_beginning_with_y {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "yellow"
    assert_success
    assert_output "ellowyay"
}

@test word_rhythm {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "rhythm"
    assert_success
    assert_output "ythmrhay"
}

@test word_my {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "my"
    assert_success
    assert_output "ymay"
}

# phrases are translated
@test a_whole_phrase {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f pig-latin.awk <<< "quick fast run"
    assert_success
    assert_output "ickquay astfay unray"
}
