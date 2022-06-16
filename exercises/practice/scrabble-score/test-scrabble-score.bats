#!/usr/bin/env bats
load bats-extra

@test 'lowercase letter' {
    #[[ $BATS_RUN_SKIPPED == 'true' ]] || skip
    run gawk -f scrabble-score.awk <<< 'a'

    assert_success
    assert_output 'A,1'
}

@test 'uppercase letter' {
    [[ $BATS_RUN_SKIPPED == 'true' ]] || skip
    run gawk -f scrabble-score.awk <<< 'A'

    assert_success
    assert_output 'A,1'
}

@test 'valuable letter' {
    [[ $BATS_RUN_SKIPPED == 'true' ]] || skip
    run gawk -f scrabble-score.awk <<< 'f'

    assert_success
    assert_output 'F,4'
}

@test 'short word' {
    [[ $BATS_RUN_SKIPPED == 'true' ]] || skip
    run gawk -f scrabble-score.awk <<< 'at'

    assert_success
    assert_output 'AT,2'
}

@test 'short, valuable word' {
    [[ $BATS_RUN_SKIPPED == 'true' ]] || skip
    run gawk -f scrabble-score.awk <<< 'zoo'

    assert_success
    assert_output 'ZOO,12'
}

@test 'medium word' {
    [[ $BATS_RUN_SKIPPED == 'true' ]] || skip
    run gawk -f scrabble-score.awk <<< 'street'

    assert_success
    assert_output 'STREET,6'
}

@test 'medium, valuable word' {
    [[ $BATS_RUN_SKIPPED == 'true' ]] || skip
    run gawk -f scrabble-score.awk <<< 'quirky'

    assert_success
    assert_output 'QUIRKY,22'
}

@test 'long, mixed-case word' {
    [[ $BATS_RUN_SKIPPED == 'true' ]] || skip
    run gawk -f scrabble-score.awk <<< 'OxyphenButazone'

    assert_success
    assert_output 'OXYPHENBUTAZONE,41'
}

@test 'english-like word' {
    [[ $BATS_RUN_SKIPPED == 'true' ]] || skip
    run gawk -f scrabble-score.awk <<< 'pinata'

    assert_success
    assert_output 'PINATA,8'
}

@test 'empty input' {
    [[ $BATS_RUN_SKIPPED == 'true' ]] || skip
    run gawk -f scrabble-score.awk <<< ''

    assert_success
    assert_output ',0'
}

@test 'entire alphabet available' {
    [[ $BATS_RUN_SKIPPED == 'true' ]] || skip
    run gawk -f scrabble-score.awk <<< 'abcdefghijklmnopqrstuvwxyz'

    assert_success
    assert_output 'ABCDEFGHIJKLMNOPQRSTUVWXYZ,87'
}

@test 'bonus: blank tile counts as zero' {
    [[ $BATS_RUN_SKIPPED == 'true' ]] || skip
    run gawk -f scrabble-score.awk <<< 'abcdefghijklmnop rstuvwxyz'

    assert_success
    assert_output 'ABCDEFGHIJKLMNOP RSTUVWXYZ,77'
}
