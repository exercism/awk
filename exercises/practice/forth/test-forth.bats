#!/usr/bin/env bats
load bats-extra

# generated on 2026-06-30T17:59:19+00:00

@test "parsing and numbers: numbers just get pushed onto the stack" {
    # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 2 3 4 5
END
    assert_success
    assert_output "1 2 3 4 5"
}

@test "parsing and numbers: pushes negative numbers onto the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
-1 -2 -3 -4 -5
END
    assert_success
    assert_output "-1 -2 -3 -4 -5"
}

@test "addition: can add two numbers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 2 +
END
    assert_success
    assert_output "3"
}

@test "addition: errors if there is nothing on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
+
END
    assert_failure
    assert_output --partial "empty stack"
}

@test "addition: errors if there is only one value on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 +
END
    assert_failure
    assert_output --partial "only one value on the stack"
}

@test "addition: more than two values on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 2 3 +
END
    assert_success
    assert_output "1 5"
}

@test "subtraction: can subtract two numbers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
3 4 -
END
    assert_success
    assert_output "-1"
}

@test "subtraction: errors if there is nothing on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
-
END
    assert_failure
    assert_output --partial "empty stack"
}

@test "subtraction: errors if there is only one value on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 -
END
    assert_failure
    assert_output --partial "only one value on the stack"
}

@test "subtraction: more than two values on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 12 3 -
END
    assert_success
    assert_output "1 9"
}

@test "multiplication: can multiply two numbers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
2 4 *
END
    assert_success
    assert_output "8"
}

@test "multiplication: errors if there is nothing on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
*
END
    assert_failure
    assert_output --partial "empty stack"
}

@test "multiplication: errors if there is only one value on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 *
END
    assert_failure
    assert_output --partial "only one value on the stack"
}

@test "multiplication: more than two values on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 2 3 *
END
    assert_success
    assert_output "1 6"
}

@test "division: can divide two numbers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
12 3 /
END
    assert_success
    assert_output "4"
}

@test "division: performs integer division" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
8 3 /
END
    assert_success
    assert_output "2"
}

@test "division: errors if dividing by zero" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
4 0 /
END
    assert_failure
    assert_output --partial "divide by zero"
}

@test "division: errors if there is nothing on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
/
END
    assert_failure
    assert_output --partial "empty stack"
}

@test "division: errors if there is only one value on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 /
END
    assert_failure
    assert_output --partial "only one value on the stack"
}

@test "division: more than two values on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 12 3 /
END
    assert_success
    assert_output "1 4"
}

@test "combined arithmetic: addition and subtraction" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 2 + 4 -
END
    assert_success
    assert_output "-1"
}

@test "combined arithmetic: multiplication and division" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
2 4 * 3 /
END
    assert_success
    assert_output "2"
}

@test "combined arithmetic: multiplication and addition" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 3 4 * +
END
    assert_success
    assert_output "13"
}

@test "combined arithmetic: addition and multiplication" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 3 4 + *
END
    assert_success
    assert_output "7"
}

@test "dup: copies a value on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 dup
END
    assert_success
    assert_output "1 1"
}

@test "dup: copies the top value on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 2 dup
END
    assert_success
    assert_output "1 2 2"
}

@test "dup: errors if there is nothing on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
dup
END
    assert_failure
    assert_output --partial "empty stack"
}

@test "drop: removes the top value on the stack if it is the only one" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 drop
END
    assert_success
    assert_output ""
}

@test "drop: removes the top value on the stack if it is not the only one" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 2 drop
END
    assert_success
    assert_output "1"
}

@test "drop: errors if there is nothing on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
drop
END
    assert_failure
    assert_output --partial "empty stack"
}

@test "swap: swaps the top two values on the stack if they are the only ones" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 2 swap
END
    assert_success
    assert_output "2 1"
}

@test "swap: swaps the top two values on the stack if they are not the only ones" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 2 3 swap
END
    assert_success
    assert_output "1 3 2"
}

@test "swap: errors if there is nothing on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
swap
END
    assert_failure
    assert_output --partial "empty stack"
}

@test "swap: errors if there is only one value on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 swap
END
    assert_failure
    assert_output --partial "only one value on the stack"
}

@test "over: copies the second element if there are only two" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 2 over
END
    assert_success
    assert_output "1 2 1"
}

@test "over: copies the second element if there are more than two" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 2 3 over
END
    assert_success
    assert_output "1 2 3 2"
}

@test "over: errors if there is nothing on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
over
END
    assert_failure
    assert_output --partial "empty stack"
}

@test "over: errors if there is only one value on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 over
END
    assert_failure
    assert_output --partial "only one value on the stack"
}

@test "user-defined words: can consist of built-in words" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
: dup-twice dup dup ;
1 dup-twice
END
    assert_success
    assert_output "1 1 1"
}

@test "user-defined words: execute in the right order" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
: countup 1 2 3 ;
countup
END
    assert_success
    assert_output "1 2 3"
}

@test "user-defined words: can override other user-defined words" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
: foo dup ;
: foo dup dup ;
1 foo
END
    assert_success
    assert_output "1 1 1"
}

@test "user-defined words: can override built-in words" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
: swap dup ;
1 swap
END
    assert_success
    assert_output "1 1"
}

@test "user-defined words: can override built-in operators" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
: + * ;
3 4 +
END
    assert_success
    assert_output "12"
}

@test "user-defined words: can use different words with the same name" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
: foo 5 ;
: bar foo ;
: foo 6 ;
bar foo
END
    assert_success
    assert_output "5 6"
}

@test "user-defined words: can define word that uses word with the same name" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
: foo 10 ;
: foo foo 1 + ;
foo
END
    assert_success
    assert_output "11"
}

@test "user-defined words: cannot redefine non-negative numbers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
: 1 2 ;
END
    assert_failure
    assert_output --partial "illegal operation"
}

@test "user-defined words: cannot redefine negative numbers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
: -1 2 ;
END
    assert_failure
    assert_output --partial "illegal operation"
}

@test "user-defined words: errors if executing a non-existent word" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
foo
END
    assert_failure
    assert_output --partial "undefined operation"
}

@test "case-insensitivity: DUP is case-insensitive" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 DUP Dup dup
END
    assert_success
    assert_output "1 1 1 1"
}

@test "case-insensitivity: DROP is case-insensitive" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 2 3 4 DROP Drop drop
END
    assert_success
    assert_output "1"
}

@test "case-insensitivity: SWAP is case-insensitive" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 2 SWAP 3 Swap 4 swap
END
    assert_success
    assert_output "2 3 4 1"
}

@test "case-insensitivity: OVER is case-insensitive" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 2 OVER Over over
END
    assert_success
    assert_output "1 2 1 2 1"
}

@test "case-insensitivity: user-defined words are case-insensitive" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
: foo dup ;
1 FOO Foo foo
END
    assert_success
    assert_output "1 1 1 1"
}

@test "case-insensitivity: definitions are case-insensitive" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
: SWAP DUP Dup dup ;
1 swap
END
    assert_success
    assert_output "1 1 1 1"
}


@test macro_empty_definition {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
: foo ;
END
    assert_failure
    assert_output --partial "empty macro definition"
}

@test macro_missing_semicolon {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
: foo 1
foo
END
    assert_failure
    assert_output --partial "macro not terminated with semicolon"
}

# each file gets it's own forth evaluator:
# a stack and macros, and prints the stack at the end of the file
@test each_file_gets_its_own_forth {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    echo ': + - ;' >  first.txt
    echo '1 1 +'   >> first.txt
    echo '1 1 +'   >  second.txt
    run gawk -f forth.awk first.txt second.txt
    assert_success
    assert_line --index 0 "0"
    assert_line --index 1 "2"
    rm -f first.txt second.txt
}

