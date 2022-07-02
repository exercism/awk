#!gawk

@namespace "circular_buffer"

function new(buffer, capacity) {
    buffer["capacity"] = capacity
    clear(buffer)
}

function clear(buffer) {
    # initialize the data array
    delete buffer["data"]
    buffer["data"][1] = 1
    delete buffer["data"][1]

    buffer["write"] = 1
    buffer["read"] = 1
}

function read(buffer, result) {
    if (buffer["read"] in buffer["data"]) {
        result[1] = "ok"
        result[2] = buffer["data"][buffer["read"]]
        delete buffer["data"][buffer["read"]]
        Incr("read", buffer)
    }
    else {
        # buffer is empty
        result[1] = "err"
        delete result[2]
        return
    }
}

function write(buffer, item, result) {
    if (buffer["write"] in buffer["data"]) {
        # buffer is full
        result[1] = "err"
    }
    else {
        buffer["data"][buffer["write"]] = item
        Incr("write", buffer)
        result[1] = "ok"
    }
}

function overwrite(buffer, item, result) {
    if (buffer["write"] in buffer["data"]) {
        read(buffer, result)
    }
    write(buffer, item, result)
}

function Incr(pointer, buffer) {
    buffer[pointer] += 1
    if (buffer[pointer] > buffer["capacity"])
        buffer[pointer] = 1
}
