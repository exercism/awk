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
1. set `exercise=foo-bar`
1. copy the exercises/practice/$exercise directory from the bash repo.
1. in the exercises/practice/$exercise directory, **delete** `${exercise/-/_}.sh`, and
   `.meta/{test.toml,version,example.sh}`
1. rename `${exercise/-/_}.bats` to `test-$exercise.bats`
    - note the underscore changed: the AWK track uses kebab case
1. edit `.meta/config.json`
    - fix the filenames from .sh to .awk, and the test file
    - set yourself as the author, and empty the contributors list.
1. edit `test-$exercise.awk` so the tests are AWK specific. 
    - see other exercises for the track style.
    - remember that the tests are the requirements that students use to
      create their solutions: the tests should strive to be straightforward
      and self-explantory.
1. create `$exercise.awk` so all the tests pass.
1. move the solution to `.meta/example.awk`
1. copy `../hamming/hamming.awk` to `$exercise.awk` -- this is the stub file
   that students first see.
1. copy the exercise JSON slug entry in the repo root's `config.json` from bash
    - drop any `topics` entry
    - use `./bin/configlet uuid` to generate a new UUID
1. cd to the track root and:
    ```sh
    bin/fetch-configlet
    bin/configlet fmt -u -e $exercise
    bin/configlet sync -u -e $exercise
    bin/configlet lint
    ```
    And make sure those all pass.
1. commit your code and run
    ```sh
    bin/validate_one_exercise exercises/practice/$exercise
    ```
    And make sure it passes
1. push your branch and create a pull request in [exercism/awk][github]
    - add "Closes #1234" to the PR description (where 1234 is the issue
      number from the first step: this links the PR and the issue)
    - request a review from `exercism/awk` team
    - ensure the Github Action checks succeed!

Thanks for your interest!

[slack]: https://exercism-team.slack.com/archives/C03HT01H7N3 
[github]: https://github.com/exercism/awk 
