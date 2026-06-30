#!/usr/bin/env bats
load bats-extra

# generated on 2026-06-30T15:57:06+00:00

@test "verse two - the malt that lay" {
    # [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END
This is the malt that lay in the house that Jack built.
END
)
    run gawk -f house.awk -v start=2 -v end=2
    assert_success
    assert_output "$expected"
}

@test "verse three - the rat that ate" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END
This is the rat that ate the malt that lay in the house that Jack built.
END
)
    run gawk -f house.awk -v start=3 -v end=3
    assert_success
    assert_output "$expected"
}

@test "verse six - the cow with the crumpled horn" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END
This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
END
)
    run gawk -f house.awk -v start=6 -v end=6
    assert_success
    assert_output "$expected"
}

@test "verse seven - the maiden all forlorn" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END
This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
END
)
    run gawk -f house.awk -v start=7 -v end=7
    assert_success
    assert_output "$expected"
}

@test "verse eight - the man all tattered and torn" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END
This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
END
)
    run gawk -f house.awk -v start=8 -v end=8
    assert_success
    assert_output "$expected"
}

@test "verse nine - the priest all shaven and shorn" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END
This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
END
)
    run gawk -f house.awk -v start=9 -v end=9
    assert_success
    assert_output "$expected"
}

@test "verse 10 - the rooster that crowed in the morn" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END
This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
END
)
    run gawk -f house.awk -v start=10 -v end=10
    assert_success
    assert_output "$expected"
}

@test "verse 11 - the farmer sowing his corn" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END
This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
END
)
    run gawk -f house.awk -v start=11 -v end=11
    assert_success
    assert_output "$expected"
}

@test "verse 12 - the horse and the hound and the horn" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END
This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
END
)
    run gawk -f house.awk -v start=12 -v end=12
    assert_success
    assert_output "$expected"
}

@test "multiple verses" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END
This is the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
END
)
    run gawk -f house.awk -v start=4 -v end=8
    assert_success
    assert_output "$expected"
}

@test "full rhyme" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat <<END
This is the house that Jack built.
This is the malt that lay in the house that Jack built.
This is the rat that ate the malt that lay in the house that Jack built.
This is the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
END
)
    run gawk -f house.awk -v start=1 -v end=12
    assert_success
    assert_output "$expected"
}


@test "invalid verse 1" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f house.awk -v start=0 -v end=12
    assert_failure
    assert_output --partial "invalid"
}

@test "invalid verse 2" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f house.awk -v start=1 -v end=-1
    assert_failure
    assert_output --partial "invalid"
}

@test "invalid verse 3" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f house.awk -v start=14 -v end=12
    assert_failure
    assert_output --partial "invalid"
}

@test "invalid verse 4" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f house.awk -v start=1 -v end=13
    assert_failure
    assert_output --partial "invalid"
}
