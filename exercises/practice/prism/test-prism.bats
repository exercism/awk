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
1 10 0 0
EOF
    assert_success
    assert_output "1"
}

@test "one prism zero hits" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 0
1 -10 0 0
EOF
    assert_success
    assert_output ""
}

@test "going up zero hits" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 90
1 -10 0 0
2 10 0 0
3 0 -10 0
EOF
    assert_success
    assert_output ""
}

@test "going down zero hits" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 -90
1 10 0 0
2 0 10 0
3 -10 0 0
EOF
    assert_success
    assert_output ""
}

@test "going left zero hits" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 180
1 0 -10 0
2 0 10 0
3 10 0 0
EOF
    assert_success
    assert_output ""
}

@test "negative angle" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 -180
1 0 -10 0
2 0 10 0
3 10 0 0
EOF
    assert_success
    assert_output ""
}

@test "large angle" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 2340
1 10 0 0
EOF
    assert_success
    assert_output ""
}

@test "upward refraction two hits" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 0
1 10 10 0
2 10 0 90
EOF
    assert_success
    assert_output "2 1"
}

@test "downward refraction two hits" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 0
1 10 0 -90
2 10 -10 0
EOF
    assert_success
    assert_output "1 2"
}

@test "same prism twice" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 0
1 20 0 -180
2 10 0 0
EOF
    assert_success
    assert_output "2 1 2"
}

@test "simple path" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 0
1 10 10 -90
2 10 0 90
3 30 10 45
4 20 0 0
EOF
    assert_success
    assert_output "2 1 3"
}

@test "multiple prisms floating point precision" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 -6.429
1 13.2 77.0 17.937
2 0.0 42.4 -21.817
3 -6.6 3.2 46.72
4 29.0 75.4 17.016
5 23.2 80.2 31.866
6 1.0 80.6 51.295
7 14.2 -1.6 19.081
8 -10.0 15.8 -9.24
9 30.8 41.8 -165.413
10 37.8 55.2 11.978
11 15.4 82.6 66.262
12 -1.0 0.2 0.0
13 48.6 51.8 45.812
14 -2.0 34.4 -52.001
15 -3.0 79.2 53.782
16 30.8 6.6 35.852
17 -4.4 74.6 24.709
18 -26.0 42.6 22.661
19 -13.8 24.2 -9.205
20 20.4 82.8 45.17
21 24.4 75.8 20.783
22 47.0 57.8 54.745
23 41.6 59.8 70.763
24 36.2 65.2 -0.304
25 38.8 76.2 51.958
26 5.8 73.4 6.555
27 -5.6 32.8 -75.303
28 36.4 31.4 -18.157
29 31.4 79.4 61.327
30 24.0 0.6 28.771
31 -20.2 48.8 30.615
32 4.2 78.6 40.892
33 11.2 44.4 -165.941
34 -8.8 36.8 -4.199
35 21.4 44.8 -171.579
36 -27.0 47.8 92.52
37 -15.8 47.0 33.29
38 36.4 79.2 49.05
EOF
    assert_success
    assert_output "7 30 16 28 13 22 23 10 9 24 25 38 29 4 35 21 5 20 11 1 33 26 32 6 15 17 2 14 27 34 37 31 36 18 19 8 3 12"
}

@test "complex path with multiple prisms floating point precision" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f prism.awk <<EOF
0 0 0.0
1 83.0 0.2 89.105
2 89.8 27.8 91.176
3 22.4 7.0 -91.685
4 82.6 27.6 71.127
5 -65.2 21.6 93.128
6 90.0 0.2 90.415
7 -72.6 6.4 -89.148
8 -31.6 30.8 0.535
9 -51.4 31.6 67.249
10 74.4 0.4 90.939
11 64.4 -0.2 92.353
12 59.0 5.0 -91.164
13 34.4 7.0 90.0
14 -79.6 32.4 92.342
15 67.6 0.4 84.958
16 -47.4 11.4 -136.02
17 -52.2 17.8 -52.938
18 -46.2 19.2 -128.362
19 53.2 20.6 -87.181
20 45.8 -0.2 1.469
21 -41.8 0.0 68.352
22 75.2 28.0 63.515
23 9.8 30.8 30.829
24 63.8 14.4 86.586
25 78.6 7.8 98.562
26 -39.8 30.8 61.113
27 -4.6 0.2 87.397
28 38.0 0.0 86.863
29 47.2 28.2 92.954
30 -34.2 0.6 111.33
31 -58.0 6.6 -61.837
32 -9.0 0.0 91.615
33 -16.4 18.4 90.734
34 -9.4 23.2 -88.238
35 14.8 -0.4 89.176
36 -24.2 8.2 -90.0
37 -16.6 13.2 84.785
38 53.0 14.6 -90.848
39 -12.0 8.2 90.0
40 -65.0 14.0 87.109
41 -12.0 0.0 91.219
42 65.8 20.8 -85.867
43 7.0 0.0 116.565
44 -0.8 15.6 -116.565
45 10.6 18.8 23.697
46 37.4 20.6 -88.332
47 45.4 5.8 -82.992
48 -4.6 10.0 -161.222
49 34.4 -0.2 89.415
50 -24.2 12.8 -86.987
51 -72.6 21.0 -100.976
52 14.2 24.0 -143.896
53 -1.2 0.0 0.0
54 44.0 27.8 85.969
55 -61.4 26.4 94.086
56 -51.0 0.2 70.445
57 -61.8 32.0 84.627
58 -79.0 -0.2 89.481
59 82.8 13.0 -140.177
60 -58.8 31.6 115.56
61 -72.0 26.4 -83.66
62 -32.0 24.8 -140.8
63 74.2 12.6 -138.429
64 59.2 10.2 -92.203
65 48.0 10.2 87.455
66 5.4 15.6 31.608
67 79.8 18.6 -136.643
68 14.6 28.0 -29.867
69 22.8 20.6 -88.315
70 -72.8 13.4 -87.238
71 -24.2 18.6 -88.531
72 -24.2 23.4 -90.774
73 -40.4 13.4 -62.229
74 -30.8 0.4 85.966
75 -10.2 30.6 -1.108
76 -57.6 0.0 1.2
EOF
    assert_success
    assert_output "43 44 66 45 52 35 49 13 3 69 46 28 20 11 24 38 19 42 15 10 63 25 59 1 6 2 4 67 22 29 65 64 12 47 54 68 23 75 8 26 18 9 60 17 31 7 70 40 5 51 61 55 57 14 58 76 56 16 21 30 73 62 74 41 39 36 50 37 33 71 72 34 32 27 48 53"
}
