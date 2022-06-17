#!/usr/bin/env bats
load bats-extra

# partial garden

@test "garden with single student" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f kindergarten-garden.awk -v name="Alice" << END_GARDEN
RC
GG
END_GARDEN
    assert_success
    assert_output "radishes clover grass grass"
}

@test "different garden with single student" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f kindergarten-garden.awk -v name="Alice" << END_GARDEN
VC
RC
END_GARDEN
    assert_success
    assert_output "violets clover radishes clover"
}

@test "garden with two students" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f kindergarten-garden.awk -v name="Bob" << END_GARDEN
VVCG
VVRC
END_GARDEN
    assert_success
    assert_output "clover grass radishes clover"
}

@test "three students, second student's garden" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f kindergarten-garden.awk -v name="Bob" << END_GARDEN
VVCCGG
VVCCGG
END_GARDEN
    assert_success
    assert_output "clover clover clover clover"
}
            
@test "three students, third student's garden" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f kindergarten-garden.awk -v name="Charlie" << END_GARDEN
VVCCGG
VVCCGG
END_GARDEN
    assert_success
    assert_output "grass grass grass grass"
}

# full garden

@test "for Alice, first student's garden" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f kindergarten-garden.awk -v name="Alice" << END_GARDEN
VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV
END_GARDEN
    assert_success
    assert_output "violets radishes violets radishes"
}

@test "for Bob, second student's garden" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f kindergarten-garden.awk -v name="Bob" << END_GARDEN
VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV
END_GARDEN
    assert_success
    assert_output "clover grass clover clover"
}

@test "for Charlie" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f kindergarten-garden.awk -v name="Charlie" << END_GARDEN
VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV
END_GARDEN
    assert_success
    assert_output "violets violets clover grass"
}

@test "for David" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f kindergarten-garden.awk -v name="David" << END_GARDEN
VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV
END_GARDEN
    assert_success
    assert_output "radishes violets clover radishes"
}

@test "for Eve" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f kindergarten-garden.awk -v name="Eve" << END_GARDEN
VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV
END_GARDEN
    assert_success
    assert_output "clover grass radishes grass"
}

@test "for Fred" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f kindergarten-garden.awk -v name="Fred" << END_GARDEN
VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV
END_GARDEN
    assert_success
    assert_output "grass clover violets clover"
}

@test "for Ginny" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f kindergarten-garden.awk -v name="Ginny" << END_GARDEN
VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV
END_GARDEN
    assert_success
    assert_output "clover grass grass clover"
}

@test "for Harriet" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f kindergarten-garden.awk -v name="Harriet" << END_GARDEN
VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV
END_GARDEN
    assert_success
    assert_output "violets radishes radishes violets"
}

@test "for Ileana" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f kindergarten-garden.awk -v name="Ileana" << END_GARDEN
VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV
END_GARDEN
    assert_success
    assert_output "grass clover violets clover"
}

@test "for Joseph" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f kindergarten-garden.awk -v name="Joseph" << END_GARDEN
VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV
END_GARDEN
    assert_success
    assert_output "violets clover violets grass"
}

@test "for Kincaid, second to last student's garden" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f kindergarten-garden.awk -v name="Kincaid" << END_GARDEN
VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV
END_GARDEN
    assert_success
    assert_output "grass clover clover grass"
}

@test "for Larry, last student's garden" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f kindergarten-garden.awk -v name="Larry" << END_GARDEN
VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV
END_GARDEN
    assert_success
    assert_output "grass violets clover violets"
}
