#!/usr/bin/env bats
load bats-extra

@test 'reading empty buffer should fail' {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk '
        @include "circular-buffer"
        BEGIN {
            capacity = 1
            circular_buffer::new(buff, capacity)
            circular_buffer::read(buff, result)
            print result[1]
        } 
    '
    assert_success
    assert_output "err"
}

@test 'can read an item just written' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk '
        @include "circular-buffer"
        BEGIN {
            capacity = 1
            circular_buffer::new(buff, capacity)

            item = 42
            circular_buffer::write(buff, item, result)
            print result[1]

            circular_buffer::read(buff, result)
            print result[1]
            print result[2]
        } 
    '
    assert_success
    assert_line --index 0 -- "ok"
    assert_line --index 1 -- "ok"
    assert_line --index 2 -- "42"
}

@test 'each item may only be read once' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk '
        @include "circular-buffer"
        BEGIN {
            circular_buffer::new(buff, 1)
            circular_buffer::write(buff, 1, result)
            print result[1]

            circular_buffer::read(buff, result)
            print result[1]
            print result[2]

            circular_buffer::read(buff, result)
            print result[1]
        } 
    '
    assert_success
    assert_line --index 0 -- "ok"
    assert_line --index 1 -- "ok"
    assert_line --index 2 -- "1"
    assert_line --index 3 -- "err"
}

@test 'items are read in the order they are written' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk '
        @include "circular-buffer"
        BEGIN {
            circular_buffer::new(buff, 2)
            circular_buffer::write(buff, 1, result)
            print result[1]
            circular_buffer::write(buff, 2, result)
            print result[1]

            circular_buffer::read(buff, result)
            print result[1]
            print result[2]
            circular_buffer::read(buff, result)
            print result[1]
            print result[2]
        } 
    '
    assert_success
    assert_line --index 0 -- "ok"
    assert_line --index 1 -- "ok"
    assert_line --index 2 -- "ok"
    assert_line --index 3 -- "1"
    assert_line --index 4 -- "ok"
    assert_line --index 5 -- "2"
}

@test 'full buffer cannot be written to' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk '
        @include "circular-buffer"
        BEGIN {
            circular_buffer::new(buff, 1)
            circular_buffer::write(buff, 1, result)
            print result[1]
            circular_buffer::write(buff, 2, result)
            print result[1]
        } 
    '
    assert_success
    assert_line --index 0 -- "ok"
    assert_line --index 1 -- "err"
}

@test 'a read frees up capacity for another write' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk '
        @include "circular-buffer"
        BEGIN {
            circular_buffer::new(buff, 1)

            circular_buffer::write(buff, 1, result)
            print result[1]
            circular_buffer::read(buff, result)
            print result[1]
            print result[2]

            circular_buffer::write(buff, 2, result)
            print result[1]
            circular_buffer::read(buff, result)
            print result[1]
            print result[2]
        } 
    '
    assert_success
    assert_line --index 0 -- "ok"
    assert_line --index 1 -- "ok"
    assert_line --index 2 -- "1"
    assert_line --index 3 -- "ok"
    assert_line --index 4 -- "ok"
    assert_line --index 5 -- "2"
}

@test 'read position is maintained even across multiple writes' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk '
        @include "circular-buffer"
        BEGIN {
            circular_buffer::new(buff, 3)
            circular_buffer::write(buff, 1, result)
            circular_buffer::write(buff, 2, result)
            circular_buffer::read(buff, result)
            print result[2]

            circular_buffer::write(buff, 3, result)
            circular_buffer::read(buff, result)
            print result[2]
            circular_buffer::read(buff, result)
            print result[2]
        } 
    '
    assert_success
    assert_line --index 0 -- "1"
    assert_line --index 1 -- "2"
    assert_line --index 2 -- "3"
}

@test 'items cleared out of buffer cannot be read' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk '
        @include "circular-buffer"
        BEGIN {
            circular_buffer::new(buff, 1)
            circular_buffer::write(buff, 1, result)

            circular_buffer::clear(buff)

            circular_buffer::read(buff, result)
            print result[1]
        } 
    '
    assert_success
    assert_line --index 0 -- "err"
}

@test 'clear frees up capacity for another write' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk '
        @include "circular-buffer"
        BEGIN {
            circular_buffer::new(buff, 1)
            circular_buffer::write(buff, 1, result)
            circular_buffer::clear(buff)
            circular_buffer::write(buff, 2, result)
            circular_buffer::read(buff, result)
            print result[2]
        } 
    '
    assert_success
    assert_line --index 0 -- "2"
}

@test 'clear does nothing on empty buffer' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk '
        @include "circular-buffer"
        BEGIN {
            circular_buffer::new(buff, 1)
            circular_buffer::clear(buff)
            circular_buffer::write(buff, 1, result)
            circular_buffer::read(buff, result)
            print result[2]
        } 
    '
    assert_success
    assert_line --index 0 -- "1"
}

@test 'overwrite acts like write on non-full buffer' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk '
        @include "circular-buffer"
        BEGIN {
            circular_buffer::new(buff, 2)
            circular_buffer::write(buff, 1, result)
            circular_buffer::overwrite(buff, 2, result)
            print result[1]
            circular_buffer::read(buff, result)
            print result[2]
            circular_buffer::read(buff, result)
            print result[2]
        } 
    '
    assert_success
    assert_line --index 0 -- "ok"
    assert_line --index 1 -- "1"
    assert_line --index 2 -- "2"
}

@test 'overwrite replaces the oldest item on full buffer' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk '
        @include "circular-buffer"
        BEGIN {
            circular_buffer::new(buff, 2)
            circular_buffer::write(buff, 1, result)
            circular_buffer::write(buff, 2, result)
            circular_buffer::overwrite(buff, 3, result)
            circular_buffer::read(buff, result)
            print result[2]
            circular_buffer::read(buff, result)
            print result[2]
        } 
    '
    assert_success
    assert_line --index 0 -- "2"
    assert_line --index 1 -- "3"
}

@test 'overwrite replaces the oldest item remaining in buffer following a read' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk '
        @include "circular-buffer"
        BEGIN {
            circular_buffer::new(buff, 3)
            circular_buffer::write(buff, 1, result)
            circular_buffer::write(buff, 2, result)
            circular_buffer::write(buff, 3, result)
            circular_buffer::read(buff, result)
            print result[2]
            circular_buffer::write(buff, 4, result)
            circular_buffer::overwrite(buff, 5, result)
            circular_buffer::read(buff, result)
            print result[2]
            circular_buffer::read(buff, result)
            print result[2]
            circular_buffer::read(buff, result)
            print result[2]
        } 
    '
    assert_success
    assert_line --index 0 -- "1"
    assert_line --index 1 -- "3"
    assert_line --index 2 -- "4"
    assert_line --index 3 -- "5"
}

@test 'initial clear does not affect wrapping around' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk '
        @include "circular-buffer"
        BEGIN {
            circular_buffer::new(buff, 2)
            circular_buffer::clear(buff)
            circular_buffer::write(buff, 1, result)
            print result[1]
            circular_buffer::write(buff, 2, result)
            print result[1]
            circular_buffer::overwrite(buff, 3, result)
            print result[1]
            circular_buffer::overwrite(buff, 4, result)
            print result[1]
            circular_buffer::read(buff, result)
            print result[1]
            print result[2]
            circular_buffer::read(buff, result)
            print result[1]
            print result[2]
            circular_buffer::read(buff, result)
            print result[1]
        } 
    '
    assert_success
    assert_line --index 0 -- "ok"
    assert_line --index 1 -- "ok"
    assert_line --index 2 -- "ok"
    assert_line --index 3 -- "ok"
    assert_line --index 4 -- "ok"
    assert_line --index 5 -- "3"
    assert_line --index 6 -- "ok"
    assert_line --index 7 -- "4"
    assert_line --index 8 -- "err"
}

# awk-specific test

@test 'the buffer can hold false values' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk '
        @include "circular-buffer"
        BEGIN {
            circular_buffer::new(buff, 1)
            circular_buffer::write(buff, 0, result)
            print result[1]
            circular_buffer::read(buff, result)
            print result[1]
            print result[2]

            circular_buffer::write(buff, "", result)
            print result[1]
            circular_buffer::read(buff, result)
            print result[1]
            print result[2]
        } 
    '
    assert_success
    assert_line --index 0 -- "ok"
    assert_line --index 1 -- "ok"
    assert_line --index 2 -- "0"
    assert_line --index 3 -- "ok"
    assert_line --index 4 -- "ok"
    assert_line --index 5 -- ""
}
