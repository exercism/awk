#!/usr/bin/env bats
load bats-extra

@test "zero prisms" {
    # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 0
EOF
    assert_success
    assert_output ""
}

@test "one prism one hit" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 0
10 0 0 1
EOF
    assert_success
    assert_output "1"
}

@test "one prism zero hits" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 0
-10 0 0 1
EOF
    assert_success
    assert_output ""
}

@test "going up zero hits" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 90
0 -10 0 3
-10 0 0 1
10 0 0 2
EOF
    assert_success
    assert_output ""
}

@test "going down zero hits" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 -90
10 0 0 1
0 10 0 2
-10 0 0 3
EOF
    assert_success
    assert_output ""
}

@test "going left zero hits" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 180
0 10 0 2
10 0 0 3
0 -10 0 1
EOF
    assert_success
    assert_output ""
}

@test "negative angle" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 -180
0 -10 0 1
0 10 0 2
10 0 0 3
EOF
    assert_success
    assert_output ""
}

@test "large angle" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 2340
10 0 0 1
EOF
    assert_success
    assert_output ""
}

@test "upward refraction two hits" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 0
10 10 0 1
10 0 90 2
EOF
    assert_success
    assert_output "2 1"
}

@test "downward refraction two hits" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 0
10 0 -90 1
10 -10 0 2
EOF
    assert_success
    assert_output "1 2"
}

@test "same prism twice" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 0
10 0 0 2
20 0 -180 1
EOF
    assert_success
    assert_output "2 1 2"
}

@test "simple path" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 0
30 10 45 3
10 10 -90 1
10 0 90 2
20 0 0 4
EOF
    assert_success
    assert_output "2 1 3"
}

@test "multiple prisms floating point precision" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 -6.429
5.8 73.4 6.555 26
36.2 65.2 -0.304 24
20.4 82.8 45.17 20
-20.2 48.8 30.615 31
24.0 0.6 28.771 30
31.4 79.4 61.327 29
36.4 31.4 -18.157 28
47.0 57.8 54.745 22
36.4 79.2 49.05 38
37.8 55.2 11.978 10
-26.0 42.6 22.661 18
38.8 76.2 51.958 25
0.0 42.4 -21.817 2
21.4 44.8 -171.579 35
14.2 -1.6 19.081 7
11.2 44.4 -165.941 33
15.4 82.6 66.262 11
30.8 6.6 35.852 16
-3.0 79.2 53.782 15
29.0 75.4 17.016 4
41.6 59.8 70.763 23
-10.0 15.8 -9.24 8
48.6 51.8 45.812 13
13.2 77.0 17.937 1
-8.8 36.8 -4.199 34
24.4 75.8 20.783 21
-4.4 74.6 24.709 17
30.8 41.8 -165.413 9
4.2 78.6 40.892 32
-15.8 47.0 33.29 37
1.0 80.6 51.295 6
-27.0 47.8 92.52 36
-2.0 34.4 -52.001 14
23.2 80.2 31.866 5
-5.6 32.8 -75.303 27
-1.0 0.2 0.0 12
-6.6 3.2 46.72 3
-13.8 24.2 -9.205 19
EOF
    assert_success
    assert_output "7 30 16 28 13 22 23 10 9 24 25 38 29 4 35 21 5 20 11 1 33 26 32 6 15 17 2 14 27 34 37 31 36 18 19 8 3 12"
}

@test "complex path with multiple prisms floating point precision" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 0.0
37.4 20.6 -88.332 46
-24.2 23.4 -90.774 72
78.6 7.8 98.562 25
-58.8 31.6 115.56 60
75.2 28.0 63.515 22
89.8 27.8 91.176 2
9.8 30.8 30.829 23
22.8 20.6 -88.315 69
-0.8 15.6 -116.565 44
-24.2 8.2 -90.0 36
-1.2 0.0 0.0 53
14.2 24.0 -143.896 52
-65.2 21.6 93.128 5
5.4 15.6 31.608 66
-72.6 21.0 -100.976 51
48.0 10.2 87.455 65
-41.8 0.0 68.352 21
-46.2 19.2 -128.362 18
74.4 0.4 90.939 10
67.6 0.4 84.958 15
14.8 -0.4 89.176 35
83.0 0.2 89.105 1
14.6 28.0 -29.867 68
79.8 18.6 -136.643 67
53.0 14.6 -90.848 38
-58.0 6.6 -61.837 31
-30.8 0.4 85.966 74
-4.6 10.0 -161.222 48
59.0 5.0 -91.164 12
-16.4 18.4 90.734 33
82.6 27.6 71.127 4
-10.2 30.6 -1.108 75
38.0 0.0 86.863 28
64.4 -0.2 92.353 11
-51.4 31.6 67.249 9
-39.8 30.8 61.113 26
-34.2 0.6 111.33 30
-51.0 0.2 70.445 56
-12.0 0.0 91.219 41
63.8 14.4 86.586 24
-72.8 13.4 -87.238 70
22.4 7.0 -91.685 3
34.4 7.0 90.0 13
-47.4 11.4 -136.02 16
90.0 0.2 90.415 6
44.0 27.8 85.969 54
-9.0 0.0 91.615 32
-31.6 30.8 0.535 8
-12.0 8.2 90.0 39
-79.6 32.4 92.342 14
65.8 20.8 -85.867 42
-65.0 14.0 87.109 40
10.6 18.8 23.697 45
-24.2 18.6 -88.531 71
-72.6 6.4 -89.148 7
-32.0 24.8 -140.8 62
34.4 -0.2 89.415 49
74.2 12.6 -138.429 63
82.8 13.0 -140.177 59
-9.4 23.2 -88.238 34
-57.6 0.0 1.2 76
7.0 0.0 116.565 43
45.8 -0.2 1.469 20
-16.6 13.2 84.785 37
-79.0 -0.2 89.481 58
-24.2 12.8 -86.987 50
59.2 10.2 -92.203 64
-72.0 26.4 -83.66 61
45.4 5.8 -82.992 47
-52.2 17.8 -52.938 17
-61.8 32.0 84.627 57
47.2 28.2 92.954 29
-4.6 0.2 87.397 27
-61.4 26.4 94.086 55
-40.4 13.4 -62.229 73
53.2 20.6 -87.181 19
EOF
    assert_success
    assert_output "43 44 66 45 52 35 49 13 3 69 46 28 20 11 24 38 19 42 15 10 63 25 59 1 6 2 4 67 22 29 65 64 12 47 54 68 23 75 8 26 18 9 60 17 31 7 70 40 5 51 61 55 57 14 58 76 56 16 21 30 73 62 74 41 39 36 50 37 33 71 72 34 32 27 48 53"
}
