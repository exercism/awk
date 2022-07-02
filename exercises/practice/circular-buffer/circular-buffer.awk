#!gawk

@namespace "circular-buffer"

# new: instantiate a new circular buffer
#
# parameters:
#   buffer      - an array, holds the new circular buffer
#   capacity    - the buffer's capacity
#
function new(buffer, capacity) {
    print "Implement this function" > "/dev/stderr"
    exit 1
}

# read: remove and return the next value from the buffer
#
# parameters:
#   buffer      - the buffer array
#   result      - the return value, an array
#               - if the buffer is empty, result[1] will be "err"
#               - otherwise, result[1] will be "ok" and result[2] is the value
#
function read(buffer, result) {
    print "Implement this function" > "/dev/stderr"
    exit 1
}

# write: add a value to the buffer
#
# parameters:
#   buffer      - the buffer array
#   item        - the value to add
#   result      - the return value, an array
#               - if the buffer is full, result[1] will be "err"
#               - otherwise, result[1] will be "ok"
#
function write(buffer, item, result) {
    print "Implement this function" > "/dev/stderr"
    exit 1
}

# overwrite: forcibly add a value to the buffer
#
# parameters:
#   buffer      - the buffer array
#   item        - the value to add
#   result      - the return value, an array
#               - result[1] will be "ok"
#
function overwrite(buffer, item, result) {
    print "Implement this function" > "/dev/stderr"
    exit 1
}

# clear: delete all values from the array
#
# parameters:
#   buffer      - the buffer array
#
function clear(buffer) {
    print "Implement this function" > "/dev/stderr"
    exit 1
}
