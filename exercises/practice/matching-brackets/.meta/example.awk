BEGIN {
    FS = ""
    pair["]"] = "["
    pair[")"] = "("
    pair["}"] = "{"
}

{
    for (i = 1; i <= NF; i++) {
        if ($i ~ /[({[]/) {
            # Add open brackets to the stack.
            stack[size++] = $i
        } else if ($i ~ /[])}]/) {
            if (stack[size - 1] == pair[$i]) {
                # Pop brackets from the stack if possible.
                del stack[--size]
            } else {
                # Otherwise, fail.
                print "false"
                exit
            }

        }
    }
    # Check if the stack is empty.
    print (size == 0) ? "true" : "false"
}
