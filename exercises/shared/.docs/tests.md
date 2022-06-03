# Tests

Each exercise contains a test file.
Run the tests using the `bats` program.
```bash
bats test-hello-world.bats
```

`bats` will need to be installed.
See the [Testing on the Bash track][bash] page for instructions to install `bats` for your system.

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
