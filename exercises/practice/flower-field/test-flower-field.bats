#!/usr/bin/env bats
load bats-extra

# Check if the given string is an isogram

@test "no rows" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f flower-field.awk < /dev/null
    assert_success
    assert_output ""
}

@test "no columns" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f flower-field.awk <<< ""
    assert_success
    assert_output ""
}

@test "no flowers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f flower-field.awk << 'END_INPUT'
...
...
...
END_INPUT
    expected=$(cat << 'END_EXPECTED'
...
...
...
END_EXPECTED
)
    assert_success
    assert_output "$expected"
}

@test "garden full of flowers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f flower-field.awk << 'END_INPUT'
***
***
***
END_INPUT
    expected=$(cat << 'END_EXPECTED'
***
***
***
END_EXPECTED
)
    assert_success
    assert_output "$expected"
}

@test "flower surrounded by spaces" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f flower-field.awk << 'END_INPUT'
...
.*.
...
END_INPUT
    expected=$(cat << 'END_EXPECTED'
111
1*1
111
END_EXPECTED
)
    assert_success
    assert_output "$expected"
}

@test "space surrounded by flowers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f flower-field.awk << 'END_INPUT'
***
*.*
***
END_INPUT
    expected=$(cat << 'END_EXPECTED'
***
*8*
***
END_EXPECTED
)
    assert_success
    assert_output "$expected"
}

@test "horizontal line" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f flower-field.awk << 'END_INPUT'
.*.*.
END_INPUT
    assert_success
    assert_output "1*2*1"
}

@test "horizontal line, flowers at edges" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f flower-field.awk << 'END_INPUT'
*...*
END_INPUT
    assert_success
    assert_output "*1.1*"
}

@test "vertical line" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f flower-field.awk << 'END_INPUT'
.
*
.
*
.
END_INPUT
    expected=$(cat << 'END_EXPECTED'
1
*
2
*
1
END_EXPECTED
)
    assert_success
    assert_output "$expected"
}

@test "vertical line, flowers at edges" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f flower-field.awk << 'END_INPUT'
*
.
.
.
*
END_INPUT
    expected=$(cat << 'END_EXPECTED'
*
1
.
1
*
END_EXPECTED
)
    assert_success
    assert_output "$expected"
}

@test "cross" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f flower-field.awk << 'END_INPUT'
..*..
..*..
*****
..*..
..*..
END_INPUT
    expected=$(cat << 'END_EXPECTED'
.2*2.
25*52
*****
25*52
.2*2.
END_EXPECTED
)
    assert_success
    assert_output "$expected"
}

@test "large garden" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f flower-field.awk << 'END_INPUT'
.*..*.
..*...
....*.
...*.*
.*..*.
......
END_INPUT
    expected=$(cat << 'END_EXPECTED'
1*22*1
12*322
.123*2
112*4*
1*22*2
111111
END_EXPECTED
)
    assert_success
    assert_output "$expected"
}

@test "multiple adjacent flowers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f flower-field.awk <<< " ** "
    assert_success
    assert_output "1**1"
}
