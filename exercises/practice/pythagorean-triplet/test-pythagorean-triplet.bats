#!/usr/bin/env bats
load bats-extra

# generated on 2026-06-30T15:58:07+00:00

@test "triplets whose sum is 12" {
    # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<EOF
3,4,5
EOF
)
    run gawk -f pythagorean-triplet.awk -v sum=12
    assert_success
    assert_output "$expected"
}

@test "triplets whose sum is 108" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<EOF
27,36,45
EOF
)
    run gawk -f pythagorean-triplet.awk -v sum=108
    assert_success
    assert_output "$expected"
}

@test "triplets whose sum is 1000" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<EOF
200,375,425
EOF
)
    run gawk -f pythagorean-triplet.awk -v sum=1000
    assert_success
    assert_output "$expected"
}

@test "no matching triplets for 1001" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<EOF

EOF
)
    run gawk -f pythagorean-triplet.awk -v sum=1001
    assert_success
    assert_output "$expected"
}

@test "returns all matching triplets" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<EOF
9,40,41
15,36,39
EOF
)
    run gawk -f pythagorean-triplet.awk -v sum=90
    assert_success
    assert_output "$expected"
}

@test "several matching triplets" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<EOF
40,399,401
56,390,394
105,360,375
120,350,370
140,336,364
168,315,357
210,280,350
240,252,348
EOF
)
    run gawk -f pythagorean-triplet.awk -v sum=840
    assert_success
    assert_output "$expected"
}

@test "triplets for large number" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<EOF
1200,14375,14425
1875,14000,14125
5000,12000,13000
6000,11250,12750
7500,10000,12500
EOF
)
    run gawk -f pythagorean-triplet.awk -v sum=30000
    assert_success
    assert_output "$expected"
}
