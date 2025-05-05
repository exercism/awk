#!/usr/bin/env bats
load bats-extra

# local version: 2.0.0.1
# bash-specific test: Input validation, lower-casing

# Random key cipher"

@test  "Can generate a random key" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f simple-cipher.awk
    assert_success
    key=$output
    assert [ "${#key}" -ge 100 ]     # at least 100 chars
    [[ "$key" =~ ^[[:lower:]]+$ ]]   # only lowercase letters
}

@test  "Can encode random" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f simple-cipher.awk
    assert_success
    key=$output

    plaintext="aaaaaaaaaa"
    run gawk -v key="$key" -v type=encode -f simple-cipher.awk <<< "$plaintext"
    assert_success
    assert_equal "${#output}" 10
    assert_output "${key:0:10}"
}

@test  "Can decode random" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f simple-cipher.awk
    assert_success
    key=$output

    plaintext="aaaaaaaaaa"
    run gawk -v key="$key" -v type=decode -f simple-cipher.awk <<< "${key:0:10}"
    assert_success
    assert_equal "${#output}" 10
    assert_output "$plaintext"
}

@test "Is reversible random" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f simple-cipher.awk
    assert_success
    key=$output

    plaintext="abcdefghij"
    run gawk -v key="$key" -v type=encode -f simple-cipher.awk <<< "$plaintext"
    assert_success
    encoded=$output

    run gawk -v key="$key" -v type=decode -f simple-cipher.awk <<< "$encoded"
    assert_success
    assert_output "$plaintext"
}

# Substitution cipher

@test  "Can encode" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    key=abcdefghij
    txt=aaaaaaaaaa
    run gawk -v key="$key" -v type=encode -f simple-cipher.awk <<< "$txt"
    assert_success
    assert_output "$key"
}

@test  "Can decode" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    key=abcdefghij
    txt=abcdefghij
    exp=aaaaaaaaaa
    run gawk -v key="$key" -v type=decode -f simple-cipher.awk <<< "$txt"
    assert_success
    assert_output "$exp"
}

@test  "Is reversible" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    key=abcdefghij
    txt=abcdefghij
    exp=abcdefghij
    run gawk -v key="$key" -v type=encode -f simple-cipher.awk <<< "$txt"
    assert_success
    encoded=$output
    run gawk -v key="$key" -v type=decode -f simple-cipher.awk <<< "$encoded"
    assert_success
    assert_output "$exp"
}

@test  "Can double shift encode" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    key=iamapandabear
    txt=iamapandabear
    exp=qayaeaagaciai
    run gawk -v key="$key" -v type=encode -f simple-cipher.awk <<< "$txt"
    assert_success
    assert_output "$exp"
}

@test  "Can wrap on encode"  {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    key=abcdefghij
    txt=zzzzzzzzzz
    exp=zabcdefghi
    run gawk -v key="$key" -v type=encode -f simple-cipher.awk <<< "$txt"
    assert_success
    assert_output "$exp"
}

@test  "Can wrap on decode" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    key=abcdefghij
    txt=zabcdefghi
    exp=zzzzzzzzzz
    run gawk -v key="$key" -v type=decode -f simple-cipher.awk <<< "$txt"
    assert_success
    assert_output "$exp"
}

@test  "Can encode messages longer than the key" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    key=abc
    txt=iamapandabear
    exp=iboaqcnecbfcr
    run gawk -v key="$key" -v type=encode -f simple-cipher.awk <<< "$txt"
    assert_success
    assert_output "$exp"
}

@test  "Can decode messages longer than the key" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    key=abc
    txt=iboaqcnecbfcr
    exp=iamapandabear
    run gawk -v key="$key" -v type=decode -f simple-cipher.awk <<< "$txt"
    assert_success
    assert_output "$exp"
}

@test "plaintext is lowercased" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -v key=b -v type=encode -f simple-cipher.awk <<< FOOBAR
    assert_success
    assert_output "gppcbs"
}

@test "ciphertext is lowercased" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -v key=b -v type=decode -f simple-cipher.awk <<< GPPCBS
    assert_success
    assert_output "foobar"
}

# errors

@test "key must be lowercase" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -v key=ABC -v type=encode -f simple-cipher.awk <<< foo
    assert_failure
    assert_output --partial "invalid key"
}

@test "key must be letters" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -v key=123 -v type=encode -f simple-cipher.awk <<< foo
    assert_failure
    assert_output --partial "invalid key"
}
