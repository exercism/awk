# HOWTO: Port a practice exercises from another track

The AWK track is a close sibling to the bash track. 
It's sensible to use bash as a template for creating new AWK practice
exercises.

I'm going to assume you know how to do the git stuff.  If you need help with
it, post in the Slack [#maintaining-awk][slack] channel.  You'll need to
fork the `exercism/awk` and `exercism/bash` repos.

Here's a step-by-step procedure to port the **_foo-bar_** exercise:

1. create an issue in [exercism/awk][github] claiming this exercise for
   yourself.
    - add the labels: `x:action/create`, `x:module/practice-exercise`,
      `x:status/claimed`, `x:type/content`
    - assign it to yourself.
1. follow along with these steps to create the exercise:
    ```sh
    # set the exercise you are working on:
    exercise=foo-bar
    # set the awk repo root:
    repo=~/awk/repo
    # enter the awk repo
    cd "$repo"
    # copy the exercise directory from the bash repo:
    cp -r ../bash/exercises/practice/$exercise exercises/practice
    # enter the exercise directory
    cd "exercises/practice/$exercises"
    # delete the bash solution and metadata:
    rm ${exercise/-/_}.sh .meta/{test.toml,version,example.sh}
    # rename the test file. Note the underscore changed: the AWK track uses kebab case.
    mv ${exercise/-/_}.bats test-$exercise.bats
    # edit `.meta/config.json`
    # - fix the filenames from .sh to .awk, and the test file
    # - set yourself as the author, and empty the contributors list.
    $EDITOR .meta/config.json
    # edit `test-$exercise.bats` so the tests are AWK specific.
    # - see other exercises for the track style.
    # - remember that the tests are the requirements that students use to
    #   create their solutions: the tests should strive to be straightforward
    #   and self-explantory.
    $EDITOR test-$exercise.bats
    # create `$exercise.awk` so all the tests pass.
    $EDITOR $exercise.awk
    bats test-$exercise.bats
    # move the solution to `.meta/example.awk`
    mv $exercise.awk .meta/example.awk
    # borrow a stub file from hamming -- this is what students first see.
    cp ../hamming/hamming.awk $exercise.awk
    # cd to the track root
    cd "$repo"
    # Fetch the configlet
    ./bin/fetch-configlet
    # grab the exercise slug from bash, inserting a new UUID and dropping topics.
    filter='.exercises.practice[] | select(.slug == $ex) | .uuid = $uuid | del(.topics)'
    jq --arg ex "$exercise" --arg uuid "$(./bin/configlet uuid)" "$filter" ../bash/config.json
    # update the AWK config.json with that entry:
    $EDITOR config.json
    # run the configlet and make sure everything passes
    bin/configlet fmt -u -e $exercise
    bin/configlet sync -u -e $exercise
    bin/configlet lint
    # commit your code:
    git commit -am "Add new exercise: $exercise"
    # validate the exercise, making sure it passes:
    bin/validate_one_exercise exercises/practice/$exercise
    ```
1. push your branch and create a pull request in [exercism/awk][github]
    - add "Closes #1234" to the PR description (where 1234 is the issue
      number from the first step: this links the PR and the issue)
    - request a review from `exercism/awk` team
    - ensure the Github Action checks succeed!

Thanks for your interest!

[slack]: https://exercism-team.slack.com/archives/C03HT01H7N3 
[github]: https://github.com/exercism/awk 
