#!/usr/bin/env bats
load bats-extra

## append entries to a list and return the new list

@test "append empty lists" {
    #[[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"   # this file is provided
        @include "list-ops.awk"     # this file you write

        BEGIN {
            array::init(list1)
            array::init(list2)

            listops::append(list1, list2)

            array::pprint(list1)
        }
    '

    assert_success
    assert_output ""
}

@test "append list to empty list" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        BEGIN {
            array::init(list1)
            split("a b c d", list2)

            listops::append(list1, list2)

            array::pprint(list1)
        }
    '

    assert_success
    assert_line --index 0 -- "[1] = a"
    assert_line --index 1 -- "[2] = b"
    assert_line --index 2 -- "[3] = c"
    assert_line --index 3 -- "[4] = d"
    assert_equal "${#lines[@]}" 4
}

@test "append empty list to list" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        BEGIN {
            split("a b c d", list1)
            array::init(list2)

            listops::append(list1, list2)

            array::pprint(list1)
        }
    '

    assert_success
    assert_line --index 0 -- "[1] = a"
    assert_line --index 1 -- "[2] = b"
    assert_line --index 2 -- "[3] = c"
    assert_line --index 3 -- "[4] = d"
    assert_equal "${#lines[@]}" 4
}

@test "append non-empty lists" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        BEGIN {
            split("A B", list1)
            split("b c d e", list2)

            listops::append(list1, list2)

            array::pprint(list1)
        }
    '

    assert_success
    assert_line --index 0 -- "[1] = A"
    assert_line --index 1 -- "[2] = B"
    assert_line --index 2 -- "[3] = b"
    assert_line --index 3 -- "[4] = c"
    assert_line --index 4 -- "[5] = d"
    assert_line --index 5 -- "[6] = e"
    assert_equal "${#lines[@]}" 6
}

@test "append scalar value to empty list" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        BEGIN {
            array::init(list1)

            listops::append(list1, 42)

            array::pprint(list1)
        }
    '

    assert_success
    assert_output "[1] = 42"
}

@test "append scalar value to non-empty list" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        BEGIN {
            split("a b", list1)

            listops::append(list1, 42)

            array::pprint(list1)
        }
    '

    assert_success
    assert_line --index 0 -- "[1] = a"
    assert_line --index 1 -- "[2] = b"
    assert_line --index 2 -- "[3] = 42"
    assert_equal "${#lines[@]}" 3
}

## concatenate a list of lists

@test "concatenate an empty list" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        BEGIN {
            array::init(list)
            array::init(result)

            listops::concat(list, result)

            array::pprint(result)
        }
    '

    assert_success
    assert_output ""
}

@test "concatenate a list of lists" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        BEGIN {
            # [[1,2], [3], [], [4,5,6]]
            list[1][1] = "a"
            list[1][2] = "b"
            list[2][1] = "c"
            list[3][1] = "x"; delete list[3][1]
            list[4][1] = "d"
            list[4][2] = "e"
            list[4][3] = "f"

            array::init(result)

            listops::concat(list, result)

            array::pprint(result)
        }
    '

    assert_success
    assert_line --index 0 -- "[1] = a"
    assert_line --index 1 -- "[2] = b"
    assert_line --index 2 -- "[3] = c"
    assert_line --index 3 -- "[4] = d"
    assert_line --index 4 -- "[5] = e"
    assert_line --index 5 -- "[6] = f"
}

## filter list returning only values that satisfy the filter function

@test "filter empty list" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        function isodd(n) {
            return n % 2 == 1
        }

        BEGIN {
            array::init(list1)

            listops::filter(list1, "isodd", result)

            array::pprint(result)
        }
    '

    assert_success
    assert_output ""
}

@test "filter non-empty list" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        function isodd(n) {
            return n % 2 == 1
        }

        BEGIN {
            split("1 2 3 4 5", list1)
            array::init(result)

            listops::filter(list1, "isodd", result)

            array::pprint(result)
        }
    '

    assert_success
    assert_line --index 0 -- "[1] = 1"
    assert_line --index 1 -- "[2] = 3"
    assert_line --index 2 -- "[3] = 5"
    assert_equal "${#lines[@]}" 3
}

## returns the length of a list
# N/A: length() function is builtin

## map: a list of elements whose values equal the list value
## transformed by the mapping function

@test "map empty list" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        function incr(n) {
            return n + 1
        }

        BEGIN {
            array::init(list1)
            array::init(result)

            listops::map(list1, "incr", result)

            array::pprint(result)
        }
    '

    assert_success
    assert_output ""
}

@test "map non-empty list" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        function incr(n) {
            return n + 1
        }

        BEGIN {
            split("1 3 5 7", list1)
            array::init(result)

            listops::map(list1, "incr", result)

            array::pprint(result)
        }
    '

    assert_success
    assert_line --index 0 -- "[1] = 2"
    assert_line --index 1 -- "[2] = 4"
    assert_line --index 2 -- "[3] = 6"
    assert_line --index 3 -- "[4] = 8"
    assert_equal "${#lines[@]}" 4
}

## folds (reduces) the given list from the left with a function

@test "foldl empty list" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        function mult(acc, elem) {
            return elem * acc
        }

        BEGIN {
            array::init(list1)

            result = listops::foldl(list1, "mult", 2)

            print result
        }
    '

    assert_success
    assert_output 2
}

@test "foldl direction independent function applied to non-empty list" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        function add(acc, elem) {
            return elem + acc
        }

        BEGIN {
            split("1 2 3 4", list1)

            result = listops::foldl(list1, "add", 5)

            print result
        }
    '

    assert_success
    assert_output 15
}

@test "foldl direction dependent function applied to non-empty list" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        function div(acc, elem) {
            return elem / acc
        }

        BEGIN {
            split("1 2 3 4", list1)

            result = listops::foldl(list1, "div", 24)

            # this evaluates as: 4 / (3 / (2 / (1 / 24)))
            print result
        }
    '

    assert_success
    assert_output 64
}

# track-specific test
@test "foldl not just numbers" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        function str_concat(acc, elem) {
            return acc elem
        }

        BEGIN {
            split("Hello World!", chars, //)

            result = listops::foldl(chars, "str_concat", "")

            print result
        }
    '

    assert_success
    assert_output "Hello World!"
}

## folds (reduces) the given list from the right with a function
# Note the order of the arguments to the given functions!

@test "foldr empty list" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        function mult(elem, acc) {
            return elem * acc
        }

        BEGIN {
            array::init(list1)

            result = listops::foldr(list1, "mult", 2)

            print result
        }
    '

    assert_success
    assert_output 2
}

@test "foldr direction independent function applied to non-empty list" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        function add(elem, acc) {
            return elem + acc
        }

        BEGIN {
            split("1 2 3 4", list1)

            result = listops::foldr(list1, "add", 5)

            print result
        }
    '

    assert_success
    assert_output 15
}

@test "foldr direction dependent function applied to non-empty list" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        function div(elem, acc) {
            return elem / acc
        }

        BEGIN {
            split("1 2 3 4", list1)

            result = listops::foldr(list1, "div", 24)

            # this evaluates as: 1 / (2 / (3 / (4 / 24)))
            print result
        }
    '

    assert_success
    assert_output 9
}

# track-specific test
@test "foldr not just numbers" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        function str_concat(elem, acc) {
            return acc elem
        }

        BEGIN {
            split("Hello World!", chars, //)

            result = listops::foldr(chars, "str_concat", "")

            print result
        }
    '

    assert_success
    assert_output "!dlroW olleH"
}

## reverse the elements of the list

@test "reverse empty list" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        BEGIN {
            array::init(list)
            array::init(result)

            listops::reverse(list, result)

            array::pprint(result)
        }
    '

    assert_success
    assert_output ""
}

@test "reverse non-empty list" {
    [[ $BATS_RUN_SKIPPED == true ]] || skip
    run gawk '
        @include "array-utils.awk"
        @include "list-ops.awk"

        BEGIN {
            split("1 3 5 7", list)
            array::init(result)

            listops::reverse(list, result)

            array::pprint(result)
        }
    '

    assert_success
    assert_line --index 0 -- "[1] = 7"
    assert_line --index 1 -- "[2] = 5"
    assert_line --index 2 -- "[3] = 3"
    assert_line --index 3 -- "[4] = 1"
    assert_equal "${#lines[@]}" 4
}
