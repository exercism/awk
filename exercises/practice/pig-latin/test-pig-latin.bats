#!/usr/bin/env bats
load bats-extra

input_file() {
    echo "$*" > input.txt
}

teardown() {
    rm -f input.txt
}

# "ay" is added to words that start with vowels

@test word_beginning_with_a {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file apple
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "appleay"
}

@test word_beginning_with_e {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file ear
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "earay"
}

@test word_beginning_with_i {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file igloo
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "iglooay"
}

@test word_beginning_with_o {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file object
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "objectay"
}

@test word_beginning_with_u {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file under
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "underay"
}

@test word_beginning_with_equ {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file equal
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "equalay"
}

# first letter and ay are moved to the end of words that start with consonants

@test word_beginning_with_p {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file pig
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "igpay"
}

@test word_beginning_with_k {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file koala
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "oalakay"
}

@test word_beginning_with_x {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file xenon
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "enonxay"
}

@test word_beginning_with_q_no_u {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file qat
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "atqay"
}

# some letter clusters are treated like a single consonant

@test word_beginning_with_ch {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file chair
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "airchay"
}

@test word_beginning_with_squ {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file square
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "aresquay"
}

@test word_beginning_with_th {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file therapy
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "erapythay"
}

@test word_beginning_with_thr {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file thrush
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "ushthray"
}

@test word_beginning_with_sch {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file school
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "oolschay"
}

# some letter clusters are treated like a single vowel

@test word_beginning_with_yt {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file yttria
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "yttriaay"
}

@test word_beginning_with_xr {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file xray
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "xrayay"
}

# position of y in a word determines if it is a consonant or a vowel

@test word_beginning_with_y {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file yellow
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "ellowyay"
}

@test word_rhythm {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file rhythm
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "ythmrhay"
}

@test word_my {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file my
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "ymay"
}

# phrases are translated
@test a_whole_phrase {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    input_file quick fast run
    run gawk -f pig-latin.awk input.txt
    assert_success
    assert_output "ickquay astfay unray"
}
