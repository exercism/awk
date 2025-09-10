#!/usr/bin/env bats
load bats-extra

@test requires_a_license_for_a_car {
    ## task 1
    run gawk -f vehicle-purchase.awk <<< 'needs_license,car'
    assert_success
    assert_output "true"
}

@test requires_a_license_for_a_truck {
    ## task 1
    run gawk -f vehicle-purchase.awk <<< 'needs_license,ice cream truck'
    assert_success
    assert_output "true"
}

@test does_not_require_a_license_for_a_bike {
    ## task 1
    run gawk -f vehicle-purchase.awk <<< 'needs_license,bike'
    assert_success
    assert_output ""
}

@test does_not_require_a_license_for_a_stroller {
    ## task 1
    run gawk -f vehicle-purchase.awk <<< 'needs_license,stroller'
    assert_success
    assert_output ""
}

@test requires_a_license_for_a_different_car {
    ## task 1
    run gawk -f vehicle-purchase.awk <<< 'needs_license,streetcar'
    assert_success
    assert_output "true"
}


@test price_is_reduced_to_80%_for_age_below_3 {
    ## task 2
    run gawk -f vehicle-purchase.awk <<< 'resell_price,40000,2'
    assert_success
    assert_output '32000'
}

@test price_is_reduced_to_50%_for_age_above_10 {
    ## task 2
    run gawk -f vehicle-purchase.awk <<< 'resell_price,40000,12'
    assert_success
    assert_output '20000'
}

@test price_is_reduced_to_70%_for_between_3_and_10 {
    ## task 2
    run gawk -f vehicle-purchase.awk <<< 'resell_price,25000,7'
    assert_success
    assert_output '17500'
}

@test works_correctly_for_threshold_age_3 {
    ## task 2
    run gawk -f vehicle-purchase.awk <<< 'resell_price,40000,3'
    assert_success
    assert_output '28000'
}

@test works_correctly_for_threshold_age_10 {
    ## task 2
    run gawk -f vehicle-purchase.awk <<< 'resell_price,25000,10'
    assert_success
    assert_output '17500'
}
