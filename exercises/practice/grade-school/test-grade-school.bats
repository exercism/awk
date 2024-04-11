#!/usr/bin/env bats
load bats-extra

@test "Roster is empty when no student is added" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grade-school.awk -v action=roster < /dev/null

    assert_success
    assert_output ""
}

@test "Student is added to the roster" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grade-school.awk -v action=roster << END_INPUT
Aimee,2
END_INPUT

    assert_success
    assert_output "Aimee"
}

@test "Multiple students in the same grade are added to the roster" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grade-school.awk -v action=roster << END_INPUT
Blair,2
James,2
Paul,2
END_INPUT

    assert_success
    assert_output "Blair,James,Paul"
}


@test "Student not added to same grade in the roster more than once" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grade-school.awk -v action=roster << END_INPUT
Blair,2
James,2
James,2
Paul,2
END_INPUT

    assert_success
    assert_output "Blair,James,Paul"
}

@test "Students in multiple grades are added to the roster" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grade-school.awk -v action=roster << END_INPUT
Chelsea,3
Logan,7
END_INPUT

    assert_success
    assert_output "Chelsea,Logan"
}

@test "Student not added to multiple grades in the roster" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grade-school.awk -v action=roster << END_INPUT
Blair,2
James,2
James,3
Paul,2
END_INPUT

    assert_success
    assert_output "Blair,James,Paul"
}

@test "Students are sorted by grades in the roster" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grade-school.awk -v action=roster << END_INPUT
Jim,3
Peter,2
Anna,1
END_INPUT

    assert_success
    assert_output "Anna,Peter,Jim"
}

@test "Students are sorted by name in the roster" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grade-school.awk -v action=roster << END_INPUT
Peter,2
Zoe,2
Alex,2
END_INPUT

    assert_success
    assert_output "Alex,Peter,Zoe"
}

@test "Students are sorted by grades and then by name in the roster" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grade-school.awk -v action=roster << END_INPUT
Peter,2
Anna,1
Barb,1
Zoe,2
Alex,2
Jim,10
Charlie,1
END_INPUT

    assert_success
    assert_output "Anna,Barb,Charlie,Alex,Peter,Zoe,Jim"
}

@test "Grade is empty if no students in the roster" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grade-school.awk -v action=grade -v grade=1 < /dev/null

    assert_success
    assert_output ""
}

@test "Grade is empty if no students in that grade" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grade-school.awk -v action=grade -v grade=1 << END_INPUT
Peter,2
Zoe,2
Alex,2
Jim,3
END_INPUT

    assert_success
    assert_output ""
}

@test "Student not added to same grade more than once" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grade-school.awk -v action=grade -v grade=2 << END_INPUT
Blair,2
James,2
James,2
Paul,2
END_INPUT

    assert_success
    assert_output "Blair,James,Paul"
}

@test "Student not added to multiple grades" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grade-school.awk -v action=grade -v grade=2 << END_INPUT
Blair,2
James,2
James,3
Paul,3
END_INPUT

    assert_success
    assert_output "Blair,James"
}

@test "Student not added to other grade for multiple grades" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grade-school.awk -v action=grade -v grade=3 << END_INPUT
Blair,2
James,2
James,3
Paul,3
END_INPUT

    assert_success
    assert_output "Paul"
}

@test "Students are sorted by name in a grade" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f grade-school.awk -v action=grade -v grade=5 << END_INPUT
Franklin,5
Bradley,5
Jeff,1
END_INPUT

    assert_success
    assert_output "Bradley,Franklin"
}
