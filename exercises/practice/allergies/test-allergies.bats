#!/usr/bin/env bats
load bats-extra

@test 'eggs: not allergic to anything' {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f allergies.awk <<< '0,allergic_to,eggs'
    assert_success
    assert_output "false"
}
@test 'eggs: allergic only to eggs' {
    run gawk -f allergies.awk <<< '1,allergic_to,eggs'
    assert_success
    assert_output "true"
}
@test 'eggs: allergic to eggs and something else' {
    run gawk -f allergies.awk <<< '3,allergic_to,eggs'
    assert_success
    assert_output "true"
}
@test 'eggs: allergic to something, but not eggs' {
    run gawk -f allergies.awk <<< '2,allergic_to,eggs'
    assert_success
    assert_output "false"
}
@test 'eggs: allergic to everything' {
    run gawk -f allergies.awk <<< '255,allergic_to,eggs'
    assert_success
    assert_output "true"
}

@test 'peanuts: not allergic to anything' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f allergies.awk <<< '0,allergic_to,peanuts'
    assert_success
    assert_output "false"
}
@test 'peanuts: allergic only to peanuts' {
    run gawk -f allergies.awk <<< '2,allergic_to,peanuts'
    assert_success
    assert_output "true"
}
@test 'peanuts: allergic to peanuts and something else' {
    run gawk -f allergies.awk <<< '7,allergic_to,peanuts'
    assert_success
    assert_output "true"
}
@test 'peanuts: allergic to something, but not peanuts' {
    run gawk -f allergies.awk <<< '5,allergic_to,peanuts'
    assert_success
    assert_output "false"
}
@test 'peanuts: allergic to everything' {
    run gawk -f allergies.awk <<< '255,allergic_to,peanuts'
    assert_success
    assert_output "true"
}

@test 'shellfish: not allergic to anything' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f allergies.awk <<< '0,allergic_to,shellfish'
    assert_success
    assert_output "false"
}
@test 'shellfish: allergic only to shellfish' {
    run gawk -f allergies.awk <<< '4,allergic_to,shellfish'
    assert_success
    assert_output "true"
}
@test 'shellfish: allergic to shellfish and something else' {
    run gawk -f allergies.awk <<< '14,allergic_to,shellfish'
    assert_success
    assert_output "true"
}
@test 'shellfish: allergic to something, but not shellfish' {
    run gawk -f allergies.awk <<< '10,allergic_to,shellfish'
    assert_success
    assert_output "false"
}
@test 'shellfish: allergic to everything' {
    run gawk -f allergies.awk <<< '255,allergic_to,shellfish'
    assert_success
    assert_output "true"
}

@test 'strawberries: not allergic to anything' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f allergies.awk <<< '0,allergic_to,strawberries'
    assert_success
    assert_output "false"
}
@test 'strawberries: allergic only to strawberries' {
    run gawk -f allergies.awk <<< '8,allergic_to,strawberries'
    assert_success
    assert_output "true"
}
@test 'strawberries: allergic to strawberries and something else' {
    run gawk -f allergies.awk <<< '28,allergic_to,strawberries'
    assert_success
    assert_output "true"
}
@test 'strawberries: allergic to something, but not strawberries' {
    run gawk -f allergies.awk <<< '20,allergic_to,strawberries'
    assert_success
    assert_output "false"
}
@test 'strawberries: allergic to everything' {
    run gawk -f allergies.awk <<< '255,allergic_to,strawberries'
    assert_success
    assert_output "true"
}

@test 'tomatoes: not allergic to anything' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f allergies.awk <<< '0,allergic_to,tomatoes'
    assert_success
    assert_output "false"
}
@test 'tomatoes: allergic only to tomatoes' {
    run gawk -f allergies.awk <<< '16,allergic_to,tomatoes'
    assert_success
    assert_output "true"
}
@test 'tomatoes: allergic to tomatoes and something else' {
    run gawk -f allergies.awk <<< '56,allergic_to,tomatoes'
    assert_success
    assert_output "true"
}
@test 'tomatoes: allergic to something, but not tomatoes' {
    run gawk -f allergies.awk <<< '40,allergic_to,tomatoes'
    assert_success
    assert_output "false"
}
@test 'tomatoes: allergic to everything' {
    run gawk -f allergies.awk <<< '255,allergic_to,tomatoes'
    assert_success
    assert_output "true"
}

@test 'chocolate: not allergic to anything' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f allergies.awk <<< '0,allergic_to,chocolate'
    assert_success
    assert_output "false"
}
@test 'chocolate: allergic only to chocolate' {
    run gawk -f allergies.awk <<< '32,allergic_to,chocolate'
    assert_success
    assert_output "true"
}
@test 'chocolate: allergic to chocolate and something else' {
    run gawk -f allergies.awk <<< '112,allergic_to,chocolate'
    assert_success
    assert_output "true"
}
@test 'chocolate: allergic to something, but not chocolate' {
    run gawk -f allergies.awk <<< '80,allergic_to,chocolate'
    assert_success
    assert_output "false"
}
@test 'chocolate: allergic to everything' {
    run gawk -f allergies.awk <<< '255,allergic_to,chocolate'
    assert_success
    assert_output "true"
}

@test 'pollen: not allergic to anything' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f allergies.awk <<< '0,allergic_to,pollen'
    assert_success
    assert_output "false"
}
@test 'pollen: allergic only to pollen' {
    run gawk -f allergies.awk <<< '64,allergic_to,pollen'
    assert_success
    assert_output "true"
}
@test 'pollen: allergic to pollen and something else' {
    run gawk -f allergies.awk <<< '224,allergic_to,pollen'
    assert_success
    assert_output "true"
}
@test 'pollen: allergic to something, but not pollen' {
    run gawk -f allergies.awk <<< '160,allergic_to,pollen'
    assert_success
    assert_output "false"
}
@test 'pollen: allergic to everything' {
    run gawk -f allergies.awk <<< '255,allergic_to,pollen'
    assert_success
    assert_output "true"
}

@test 'cats: not allergic to anything' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f allergies.awk <<< '0,allergic_to,cats'
    assert_success
    assert_output "false"
}
@test 'cats: allergic only to cats' {
    run gawk -f allergies.awk <<< '128,allergic_to,cats'
    assert_success
    assert_output "true"
}
@test 'cats: allergic to cats and something else' {
    run gawk -f allergies.awk <<< '192,allergic_to,cats'
    assert_success
    assert_output "true"
}
@test 'cats: allergic to something, but not cats' {
    run gawk -f allergies.awk <<< '64,allergic_to,cats'
    assert_success
    assert_output "false"
}
@test 'cats: allergic to everything' {
    run gawk -f allergies.awk <<< '255,allergic_to,cats'
    assert_success
    assert_output "true"
}

@test 'no_allergies_at_all' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f allergies.awk <<< '0,list'
    assert_success
    refute_output   # no output
}

@test 'allergic_to_just_eggs' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f allergies.awk <<< '1,list'
    assert_success
    assert_output "eggs"
}

@test 'allergic_to_just_peanuts' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f allergies.awk <<< '2,list'
    assert_success
    assert_output "peanuts"
}

@test 'allergic_to_just_strawberries' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f allergies.awk <<< '8,list'
    assert_success
    assert_output "strawberries"
}

@test 'allergic_to_eggs_and_peanuts' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f allergies.awk <<< '3,list'
    assert_success
    assert_output "eggs,peanuts"
}

@test 'allergic_to_more_than_eggs_but_not_peanuts' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f allergies.awk <<< '5,list'
    assert_success
    assert_output "eggs,shellfish"
}

@test 'allergic_to_lots_of_stuff' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f allergies.awk <<< '248,list'
    assert_success
    assert_output "strawberries,tomatoes,chocolate,pollen,cats"
}

@test 'allergic_to_everything' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f allergies.awk <<< '255,list'
    assert_success
    assert_output "eggs,peanuts,shellfish,strawberries,tomatoes,chocolate,pollen,cats"
}

@test 'ignore_non_allergen_score_parts' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f allergies.awk <<< '509,list'
    assert_success
    assert_output "eggs,shellfish,strawberries,tomatoes,chocolate,pollen,cats"
}

@test 'no allergen score parts without highest valid score' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f allergies.awk <<< '257,list'
    assert_success
    assert_output "eggs"
}
