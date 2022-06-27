#!/usr/bin/env bats
load bats-extra

@test "Degenerate case with a single 'A' row" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f diamond.awk <<< A
    assert_success
    assert_output "A"
}

@test "Degenerate case with no row containing 3 distinct groups of spaces" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f diamond.awk <<< B
    assert_success
    assert_line --index 0 -- " A "
    assert_line --index 1 -- "B B"
    assert_line --index 2 -- " A "
    assert_equal "${#lines[@]}" 3
}

@test "Smallest non-degenerate case with odd diamond side length" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f diamond.awk <<< C
    assert_success
    assert_line --index 0 -- "  A  "
    assert_line --index 1 -- " B B "
    assert_line --index 2 -- "C   C"
    assert_line --index 3 -- " B B "
    assert_line --index 4 -- "  A  "
    assert_equal "${#lines[@]}" 5
}

@test "Smallest non-degenerate case with even diamond side length" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f diamond.awk <<< D
    assert_success
    assert_line --index 0 -- "   A   "
    assert_line --index 1 -- "  B B  "
    assert_line --index 2 -- " C   C "
    assert_line --index 3 -- "D     D"
    assert_line --index 4 -- " C   C "
    assert_line --index 5 -- "  B B  "
    assert_line --index 6 -- "   A   "
    assert_equal "${#lines[@]}" 7
}

@test "Largest possible diamond" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f diamond.awk <<< Z
    assert_success
    assert_line --index  0 -- "                         A                         "
    assert_line --index  1 -- "                        B B                        "
    assert_line --index  2 -- "                       C   C                       "
    assert_line --index  3 -- "                      D     D                      "
    assert_line --index  4 -- "                     E       E                     "
    assert_line --index  5 -- "                    F         F                    "
    assert_line --index  6 -- "                   G           G                   "
    assert_line --index  7 -- "                  H             H                  "
    assert_line --index  8 -- "                 I               I                 "
    assert_line --index  9 -- "                J                 J                "
    assert_line --index 10 -- "               K                   K               "
    assert_line --index 11 -- "              L                     L              "
    assert_line --index 12 -- "             M                       M             "
    assert_line --index 13 -- "            N                         N            "
    assert_line --index 14 -- "           O                           O           "
    assert_line --index 15 -- "          P                             P          "
    assert_line --index 16 -- "         Q                               Q         "
    assert_line --index 17 -- "        R                                 R        "
    assert_line --index 18 -- "       S                                   S       "
    assert_line --index 19 -- "      T                                     T      "
    assert_line --index 20 -- "     U                                       U     "
    assert_line --index 21 -- "    V                                         V    "
    assert_line --index 22 -- "   W                                           W   "
    assert_line --index 23 -- "  X                                             X  "
    assert_line --index 24 -- " Y                                               Y "
    assert_line --index 25 -- "Z                                                 Z"
    assert_line --index 26 -- " Y                                               Y "
    assert_line --index 27 -- "  X                                             X  "
    assert_line --index 28 -- "   W                                           W   "
    assert_line --index 29 -- "    V                                         V    "
    assert_line --index 30 -- "     U                                       U     "
    assert_line --index 31 -- "      T                                     T      "
    assert_line --index 32 -- "       S                                   S       "
    assert_line --index 33 -- "        R                                 R        "
    assert_line --index 34 -- "         Q                               Q         "
    assert_line --index 35 -- "          P                             P          "
    assert_line --index 36 -- "           O                           O           "
    assert_line --index 37 -- "            N                         N            "
    assert_line --index 38 -- "             M                       M             "
    assert_line --index 39 -- "              L                     L              "
    assert_line --index 40 -- "               K                   K               "
    assert_line --index 41 -- "                J                 J                "
    assert_line --index 42 -- "                 I               I                 "
    assert_line --index 43 -- "                  H             H                  "
    assert_line --index 44 -- "                   G           G                   "
    assert_line --index 45 -- "                    F         F                    "
    assert_line --index 46 -- "                     E       E                     "
    assert_line --index 47 -- "                      D     D                      "
    assert_line --index 48 -- "                       C   C                       "
    assert_line --index 49 -- "                        B B                        "
    assert_line --index 50 -- "                         A                         "
    assert_equal "${#lines[@]}" 51
}

