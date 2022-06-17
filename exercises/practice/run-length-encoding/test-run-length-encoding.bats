#!/usr/bin/env bats
load bats-extra

# run-length encode a string

@test "encode empty string" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    
    run gawk -f run-length-encoding.awk -v type=encode <<< ""
    assert_success
    assert_output ""
}

@test "encode single characters only are encoded without count" {
    ##[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    
    run gawk -f run-length-encoding.awk -v type=encode <<< "XYZ"
    assert_success
    assert_output "XYZ"
}

@test "encode string with no single characters" {
    ##[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    
    run gawk -f run-length-encoding.awk -v type=encode <<< "AABBBCCCC"
    assert_success
    assert_output "2A3B4C"
}

@test "encode single characters mixed with repeated characters" {
    ##[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    
    run gawk -f run-length-encoding.awk -v type=encode <<< "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
    assert_success
    assert_output "12WB12W3B24WB"
}

@test "encode multiple whitespace mixed in string" {
    ##[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    
    run gawk -f run-length-encoding.awk -v type=encode <<< "  hsqq qww  "
    assert_success
    assert_output "2 hs2q q2w2 "
}

@test "encode lowercase characters" {
    ##[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    
    run gawk -f run-length-encoding.awk -v type=encode <<< "aabbbcccc"
    assert_success
    assert_output "2a3b4c"
}

# run-length decode a string

@test "decode empty string" {
    ##[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    
    run gawk -f run-length-encoding.awk -v type=decode <<< ""
    assert_success
    assert_output ""
}

@test "single characters only" {
    ##[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    
    run gawk -f run-length-encoding.awk -v type=decode <<< "XYZ"
    assert_success
    assert_output "XYZ"
}

@test "decode string with no single characters" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    
    run gawk -f run-length-encoding.awk -v type=decode <<< "2A3B4C"
    assert_success
    assert_output "AABBBCCCC"
}

@test "decode single characters with repeated characters" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    
    run gawk -f run-length-encoding.awk -v type=decode <<< "12WB12W3B24WB"
    assert_success
    assert_output "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
}

@test "decode multiple whitespace mixed in string" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    
    run gawk -f run-length-encoding.awk -v type=decode <<< "2 hs2q q2w2 "
    assert_success
    assert_output "  hsqq qww  "
}

@test "decode lower case string" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    
    run gawk -f run-length-encoding.awk -v type=decode <<< "2a3b4c"
    assert_success
    assert_output "aabbbcccc"
}

# encode and then decode

@test "encode followed by decode gives original string" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    plaintext="zzz ZZ  zZ"
    run gawk -f run-length-encoding.awk -v type=encode <<< "$plaintext"
    assert_success
    encoded=$output

    run gawk -f run-length-encoding.awk -v type=decode <<< "$encoded"
    assert_success
    assert_output "$plaintext"
}
