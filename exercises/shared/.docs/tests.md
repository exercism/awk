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

## Debugging output

```exercism/caution
This works locally with `bats`, but **not** in the Exercism online editor.
```

When running tests, `bats` captures both stdout and stderr for comparison with the expected output.
If you print debug messages to stdout or stderr, they will be included in the captured output and may cause the test to fail.

To print debug information without affecting the test results, `bats` provides file descriptor **3** for this purpose.
Anything printed to the file `/dev/fd/3` will be shown during the test run but will not be included in the captured output used for assertions.

Example:

```awk
BEGIN {
    # This debug message will not interfere with test output comparison
    print "a debug message" > "/dev/fd/3"

    # Normal program output (this is what your tests will see and compare)
    print "Hello, World!"
}
```

Example run:

```none
$ bats test-hello-world.bats
test-hello-world.bats
 ✓ Say Hi!
a debug message

1 test, 0 failures
```

This allows you to see helpful debug output without affecting the tests.

Hiding the details in a function may improve readability if you use it in several places in your code:

```awk
BEGIN {
    debug("a debug message")
    print "Hello, World!"
}

function debug(msg) {print msg > "/dev/fd/3"}
```

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
