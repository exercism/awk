#!/usr/bin/env bats
load bats-extra

# generated on 2026-06-30T04:46:00+00:00

@test "empty spiral" {
    # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<EOF
EOF
)
    run gawk -f spiral-matrix.awk -v size=0 < /dev/null
    assert_success
    assert_output "$expected"
}

@test "trivial spiral" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<EOF
1
EOF
)
    run gawk -f spiral-matrix.awk -v size=1 < /dev/null
    assert_success
    assert_output "$expected"
}

@test "spiral of size 2" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<EOF
1 2
4 3
EOF
)
    run gawk -f spiral-matrix.awk -v size=2 < /dev/null
    assert_success
    assert_output "$expected"
}

@test "spiral of size 3" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<EOF
1 2 3
8 9 4
7 6 5
EOF
)
    run gawk -f spiral-matrix.awk -v size=3 < /dev/null
    assert_success
    assert_output "$expected"
}

@test "spiral of size 4" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<EOF
1 2 3 4
12 13 14 5
11 16 15 6
10 9 8 7
EOF
)
    run gawk -f spiral-matrix.awk -v size=4 < /dev/null
    assert_success
    assert_output "$expected"
}

@test "spiral of size 5" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<EOF
1 2 3 4 5
16 17 18 19 6
15 24 25 20 7
14 23 22 21 8
13 12 11 10 9
EOF
)
    run gawk -f spiral-matrix.awk -v size=5 < /dev/null
    assert_success
    assert_output "$expected"
}
