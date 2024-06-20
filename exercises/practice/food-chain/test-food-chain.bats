#!/usr/bin/env bats
load bats-extra

@test 'fly' {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat << END_EXPECTED
I know an old lady who swallowed a fly.
I don't know why she swallowed the fly. Perhaps she'll die.
END_EXPECTED
)
    run gawk -f food-chain.awk -v start=1 -v end=1
    assert_success
    assert_output "$expected"
}

@test 'spider' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat << END_EXPECTED
I know an old lady who swallowed a spider.
It wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.
END_EXPECTED
)
    run gawk -f food-chain.awk -v start=2 -v end=2
    assert_success
    assert_output "$expected"
}

@test 'bird' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat << END_EXPECTED
I know an old lady who swallowed a bird.
How absurd to swallow a bird!
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.
END_EXPECTED
)
    run gawk -f food-chain.awk -v start=3 -v end=3
    assert_success
    assert_output "$expected"
}

@test 'cat' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat << END_EXPECTED
I know an old lady who swallowed a cat.
Imagine that, to swallow a cat!
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.
END_EXPECTED
)
    run gawk -f food-chain.awk -v start=4 -v end=4
    assert_success
    assert_output "$expected"
}

@test 'dog' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat << END_EXPECTED
I know an old lady who swallowed a dog.
What a hog, to swallow a dog!
She swallowed the dog to catch the cat.
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.
END_EXPECTED
)
    run gawk -f food-chain.awk -v start=5 -v end=5
    assert_success
    assert_output "$expected"
}

@test 'goat' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat << END_EXPECTED
I know an old lady who swallowed a goat.
Just opened her throat and swallowed a goat!
She swallowed the goat to catch the dog.
She swallowed the dog to catch the cat.
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.
END_EXPECTED
)
    run gawk -f food-chain.awk -v start=6 -v end=6
    assert_success
    assert_output "$expected"
}

@test 'cow' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat << END_EXPECTED
I know an old lady who swallowed a cow.
I don't know how she swallowed a cow!
She swallowed the cow to catch the goat.
She swallowed the goat to catch the dog.
She swallowed the dog to catch the cat.
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.
END_EXPECTED
)
    run gawk -f food-chain.awk -v start=7 -v end=7
    assert_success
    assert_output "$expected"
}

@test 'horse' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat << END_EXPECTED
I know an old lady who swallowed a horse.
She's dead, of course!
END_EXPECTED
)
    run gawk -f food-chain.awk -v start=8 -v end=8
    assert_success
    assert_output "$expected"
}

@test 'multiple verses' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat << END_EXPECTED
I know an old lady who swallowed a fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a spider.
It wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a bird.
How absurd to swallow a bird!
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.
END_EXPECTED
)
    run gawk -f food-chain.awk -v start=1 -v end=3
    assert_success
    assert_output "$expected"
}

@test 'full song' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    expected=$(cat << END_EXPECTED
I know an old lady who swallowed a fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a spider.
It wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a bird.
How absurd to swallow a bird!
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a cat.
Imagine that, to swallow a cat!
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a dog.
What a hog, to swallow a dog!
She swallowed the dog to catch the cat.
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a goat.
Just opened her throat and swallowed a goat!
She swallowed the goat to catch the dog.
She swallowed the dog to catch the cat.
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a cow.
I don't know how she swallowed a cow!
She swallowed the cow to catch the goat.
She swallowed the goat to catch the dog.
She swallowed the dog to catch the cat.
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a horse.
She's dead, of course!
END_EXPECTED
)
    run gawk -f food-chain.awk -v start=1 -v end=8
    assert_success
    assert_output "$expected"
}
