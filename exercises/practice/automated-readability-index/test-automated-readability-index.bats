#!/usr/bin/env bats
load bats-extra

setup() {

    cat > exercism.txt <<EOF
Exercism is an online, open-source, free coding platform
that offers code practice and mentorship on 62 different
programming languages.

Software developer Katrina Owen created Exercism while
she was teaching programming at Jumpstart Labs.
The platform was developed as an internal tool to solve
the problem of her own students not receiving feedback
on the coding problems they were practicing. Katrina put
the site publicly online and found that people were sharing
it with their friends, practicing together and giving
each other feedback. Within 12 months, the site had
organically grown to see over 6,000 users had submitted
code or feedback, and hundreds of volunteers contribute
to the languages or tooling on the platform.
EOF

    cat > ari.txt <<EOF
ARI was designed for military use in 1967.
It was for real-time monitoring of readability on typewriters.
It offered an automated counting method.
It has similar results to other frameworks.
This validates its accuracy.
EOF

    cat > billy.txt <<EOF
Billy always listens to his mother. He always does what she says.
If his mother says, "Brush your teeth," Billy brushes his teeth.
If his mother says, "Go to bed," Billy goes to bed. Billy is
a very good boy. A good boy listens to his mother. His mother
doesn't have to ask him again. She asks him to do something one time,
and she doesn't ask again. Billy is a good boy. He does what his
mother asks the first time. She doesn't have to ask again. She
tells Billy, "You are my best child." Of course Billy is her
best child. Billy is her only child.
EOF
}

teardown() {
    rm -f exercism.txt billy.txt ari.txt
}

# Test grepping a single file

@test "Exercism is an online, open-source, free coding platform" {
#    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f automated-readability-index.awk exercism.txt

    assert_success
    assert_line --index 0 "The text is:"
    assert_line --index 1 "Exercism is an online, open-source, free coding pl..."
    assert_line --index 2 "Software developer Katrina Owen created Exercism w..."
    assert_line --index 3 "The platform was developed as an internal tool to ..."
    assert_line --index 4 "..."
    assert_line --index 5 "Words: 113"
    assert_line --index 6 "Sentences: 5"
    assert_line --index 7 "Characters: 618"
    assert_line --index 8 "The score is: 15.63"
    assert_line --index 9 "This text should be understood by 18-22 year-olds."
}

@test "ARI was designed for military use in 1967" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f automated-readability-index.awk ari.txt

    assert_success
    assert_line --index 0 "The text is:"
    assert_line --index 1 "ARI was designed for military use in 1967."
    assert_line --index 2 "It was for real-time monitoring of readability on ..."
    assert_line --index 3 "It offered an automated counting method."
    assert_line --index 4 "..."
    assert_line --index 5 "Words: 34"
    assert_line --index 6 "Sentences: 5"
    assert_line --index 7 "Characters: 186"
    assert_line --index 8 "The score is: 7.74"
    assert_line --index 9 "This text should be understood by 12-13 year-olds."
}

@test "Billy always listens to his mother" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run gawk -f automated-readability-index.awk billy.txt

    assert_success
    assert_line --index 0 "The text is:"
    assert_line --partial --index 1 "Billy always listens to his mother."
    assert_line --partial --index 2 "He always does what she says."
    assert_line --partial --index 3 "If his mother says, \"Brush your teeth,\" Billy brus..."
    assert_line --index 4 "..."
    assert_line --index 5 "Words: 108"
    assert_line --index 6 "Sentences: 13"
    assert_line --index 7 "Characters: 442"
    assert_line --index 8 "The score is: 2.00"
    assert_line --index 9 "This text should be understood by 6-7 year-olds."
}
