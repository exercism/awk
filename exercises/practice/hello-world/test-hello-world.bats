#!/usr/bin/env bats
load bats-extra

# generated on 2026-08-14T19:13:01+00:00

@test "Say Hi!" {
    run gawk -f hello-world.awk

    # the program's exit status should be success (0)
    assert_success

    # program's output should be the expected text
    assert_output "Hello, World!"
}

