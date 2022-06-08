#!/usr/bin/env gawk -f

BEGINFILE {
    delete stack
    s = 0
    delete macros
}

ENDFILE {
    print join(stack, 1, s)
}

############################################################
# process the file

{
    $0 = toupper($0)
    $1 = $1
}

$1 == ":" {
    record_macro()
    next
}

{
    for (i = 1; i <= NF; i++) {
        if ($i in macros) {
            $i = macros[$i]
            rewrite_0()
        }

        if      (is_integer($i))  push($i)
        else if ($i ~ /^[-+*/]$/) arithmetic($i)
        else if ($i == "DROP")    drop()
        else if ($i == "SWAP")    swap()
        else if ($i == "DUP")     dup()
        else if ($i == "OVER")    over()
        else die("undefined operation")
    }
}

############################################################
# stack functions

function push(value) {
    stack[++s] = value
}

function pop(    value) {
    value = stack[s]
    delete stack[s--]
    return value
}

function peek() {
    return stack[s]
}

function check_stack_size(n) {
    if (n == 2 && s == 1) die("only one value on the stack")
    if (s == 0)           die("empty stack")
}

############################################################
# forth builtin operations

function arithmetic(operation,    v1, v2) {
    check_stack_size(2)
    v2 = pop()
    v1 = pop()

    if      (operation == "+") push(v1 + v2)
    else if (operation == "-") push(v1 - v2)
    else if (operation == "*") push(v1 * v2)
    else if (operation == "/") {
        if (v2 == 0) die("divide by zero")
        push(int(v1 / v2))
    }
}

function dup() {
    check_stack_size(1)
    push(peek())
}

function drop() {
    check_stack_size(1)
    pop()
}

function swap(    v1, v2) {
    check_stack_size(2)
    v2 = pop()
    v1 = pop()
    push(v2)
    push(v1)
}

function over(    v1, v2) {
    check_stack_size(2)
    v2 = pop()
    v1 = peek()
    push(v2)
    push(v1)
}

############################################################
# forth user-defined operations

function record_macro(    i) {
    if (is_integer($2)) die("illegal operation")
    if ($NF != ";")     die("macro not terminated with semicolon")
    if (NF < 4)         die("empty macro definition")

    for (i = 3; i < NF; i++) 
        if ($i in macros)
            $i = macros[$i]

    macros[$2] = join_fields(3, NF-1)
}

############################################################
# some utility functions

function die(msg) {
    print msg > "/dev/stderr"
    exit 1
}

function is_integer(str) {
    return (str ~ /^[+-]?[[:digit:]]+$/)
}

# based on
# https://www.gnu.org/software/gawk/manual/html_node/Join-Function.html 
function join(array, start, end, sep,    result, i) {
    sep = separator(sep)
    result = array[start]
    for (i = start + 1; i <= end; i++)
        result = result sep array[i]
    return result
}

# too bad awk doesn't provide an array holding the fields
function join_fields(start, end, sep,    result, i) {
    sep = separator(sep)
    result = $start
    for (i = start + 1; i <= end; i++)
        result = result sep $i
    return result
}

function separator(sep) {
    if (sep == "")
        sep = " "
    else if (sep == SUBSEP) # magic value
        sep = ""
    return sep
}

# re-split the current record into fields.
# useful if you set a field to a value with spaces, and you
# want to "spread" that into separate fields.
#
# if
#    $1 = "foo", $2 = "bar baz", $3 = "qux"
# and
#    rewrite_0()
# then
#    $1 = "foo", $2 = "bar", $3 = "baz", $4 = "qux"
function rewrite_0(sep) {
    $0 = join_fields(1, NF, sep)
    $1 = $1
}
