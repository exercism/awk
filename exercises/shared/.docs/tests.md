# Tests

Each exercise contains a test file.
Run the tests using the `bats` program.
```bash
bats test-hello-world.bats
```

`bats` will need to be installed.
See the [Testing on the Bash track][bash] page for instructions to install `bats` for your system.

### bats is implemented in bash

The bats file is a bash script, with some special functions recognized by the `bats` command.
You'll see some tests that look like
```sh
gawk -f some-exercise.awk <<< "some,input,here"
```
That `<<<` syntax is a bash [Here String][here-string].
It sends the string on the right-hand side into the standard input of the program on the left-hand side.
It is ([approximately][so]) the same as
```sh
echo "some,input,here" | gawk -f some-exercise.awk
```

## Help for assert functions

The tests use functions from the [bats-assert][bats-assert] library.
Help for the various `assert*` functions can be found there.

## Skipped tests

Solving an exercise means making all its tests pass.
By default, only one test (the first one) is executed when you run the tests.
This is intentional, as it allows you to focus on just making that one test pass.
Once it passes, you can enable the next test by commenting out or removing the

    [[ $BATS_RUN_SKIPPED == true ]] || skip

annotations prepending other tests.

## Overriding skips

To run all tests, including the ones with `skip` annotations, you can run:
```bash
BATS_RUN_SKIPPED=true bats test-some-exercise.bats
```

It can be convenient to use a wrapper function to save on typing: in `bash` you can do:
```bash
bats() {
    BATS_RUN_SKIPPED=true command bats *.bats
}
```
Then run tests with just:
```bash
bats
```

[bash]: https://exercism.org/docs/tracks/bash/tests
[bats-assert]: https://github.com/bats-core/bats-assert
[here-string]: https://www.gnu.org/software/bash/manual/bash.html#Here-Strings
[so]: https://unix.stackexchange.com/a/80372/4667
