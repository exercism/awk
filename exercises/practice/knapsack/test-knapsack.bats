#!/usr/bin/env bats
load bats-extra

# Usage: knapsack.awk << END_INPUT
# limit:max_wt
# weight:wt value:val
# ...
# END_INPUT

@test "no items" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f knapsack.awk << END_INPUT
limit:100
END_INPUT
    assert_success
    assert_output "0"
}

@test "one item: too heavy" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f knapsack.awk << END_INPUT
limit:10
weight:100,value:1
END_INPUT
    assert_success
    assert_output "0"
}

@test "five items (cannot be greedy by weight)" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f knapsack.awk << END_INPUT
limit:10
weight:2,value:5
weight:2,value:5
weight:2,value:5
weight:2,value:5
weight:10,value:21
END_INPUT
    assert_success
    assert_output "21"
}

@test "five items (cannot be greedy by value)" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f knapsack.awk << END_INPUT
limit:10
weight:2,value:20
weight:2,value:20
weight:2,value:20
weight:2,value:20
weight:10,value:50
END_INPUT
    assert_success
    assert_output "80"
}

@test "example knapsack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f knapsack.awk << END_INPUT
limit:10
weight:5,value:10
weight:4,value:40
weight:6,value:30
weight:4,value:50
END_INPUT
    assert_success
    assert_output "90"
}

@test "8 items" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f knapsack.awk << END_INPUT
limit:104
weight:25,value:350
weight:35,value:400
weight:45,value:450
weight:5,value:20
weight:25,value:70
weight:3,value:8
weight:2,value:5
weight:2,value:5
END_INPUT
    assert_success
    assert_output "900"
}

@test "15 items" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f knapsack.awk << END_INPUT
limit:750
weight:70,value:135
weight:73,value:139
weight:77,value:149
weight:80,value:150
weight:82,value:156
weight:87,value:163
weight:90,value:173
weight:94,value:184
weight:98,value:192
weight:106,value:201
weight:110,value:210
weight:113,value:214
weight:115,value:221
weight:118,value:229
weight:120,value:240
END_INPUT
    assert_success
    assert_output "1458"
}
