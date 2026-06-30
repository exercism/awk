#!/usr/bin/env bats
load bats-extra

# generated on 2026-06-30T18:14:58+00:00

@test "zero rows" {
    # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$( cat << END
END
)
    run gawk -f pascals-triangle.awk <<< "0"
    assert_success
    assert_output "$expected"
}

@test "single row" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$( cat << END
1
END
)
    run gawk -f pascals-triangle.awk <<< "1"
    assert_success
    assert_output "$expected"
}

@test "two rows" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$( cat << END
1
1 1
END
)
    run gawk -f pascals-triangle.awk <<< "2"
    assert_success
    assert_output "$expected"
}

@test "three rows" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$( cat << END
1
1 1
1 2 1
END
)
    run gawk -f pascals-triangle.awk <<< "3"
    assert_success
    assert_output "$expected"
}

@test "four rows" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$( cat << END
1
1 1
1 2 1
1 3 3 1
END
)
    run gawk -f pascals-triangle.awk <<< "4"
    assert_success
    assert_output "$expected"
}

@test "five rows" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$( cat << END
1
1 1
1 2 1
1 3 3 1
1 4 6 4 1
END
)
    run gawk -f pascals-triangle.awk <<< "5"
    assert_success
    assert_output "$expected"
}

@test "six rows" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$( cat << END
1
1 1
1 2 1
1 3 3 1
1 4 6 4 1
1 5 10 10 5 1
END
)
    run gawk -f pascals-triangle.awk <<< "6"
    assert_success
    assert_output "$expected"
}

@test "ten rows" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$( cat << END
1
1 1
1 2 1
1 3 3 1
1 4 6 4 1
1 5 10 10 5 1
1 6 15 20 15 6 1
1 7 21 35 35 21 7 1
1 8 28 56 70 56 28 8 1
1 9 36 84 126 126 84 36 9 1
END
)
    run gawk -f pascals-triangle.awk <<< "10"
    assert_success
    assert_output "$expected"
}

@test "two triangles" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$( cat << END
1
1 1
1 2 1
1 3 3 1
1
1 1
1 2 1
END
)
    run gawk -f pascals-triangle.awk << END_INPUT
4
3
END_INPUT
    assert_success
    assert_output "$expected"
}
