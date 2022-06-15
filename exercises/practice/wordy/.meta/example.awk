#!/usr/bin/env gawk -f

!/^What is/ {
    unknown_operation()
}
{
    sub(/^What is /, "")
    sub(/\?$/, "")
}
NF == 0 {
    syntax_error()
}
{
    state = "NUM"
    result = 0
    op = "plus"

    for (i = 1; i <= NF; i++) {
        switch (state) {
            case "NUM": 
                if (!looks_like_a_number($i))
                    syntax_error()
                switch (op) {
                    case "plus":
                        result += $i
                        break
                    case "minus":
                        result -= $i
                        break
                    case "multiplied":
                        result *= $i
                        break
                    case "divided":
                        result /= $i
                        break
                    default:
                        unknown_operation()
                }
                state = "OP"
                break
            case "OP":
                if (looks_like_a_number($i))
                    syntax_error()
                op = $i
                switch ($i) {
                    case "plus":
                    case "minus":
                        break
                    case "divided":
                    case "multiplied":
                        if ($(i+1) != "by") 
                            unknown_operation()
                        i++
                        break
                    default:
                        unknown_operation()
                }
                state = "NUM"
                break
        }
    }
    if (state == "NUM")
        syntax_error()
    else
        print result
}

function looks_like_a_number(num) {
    return num ~ /^[+-]?[[:digit:]]+$/
}

function syntax_error() { die("syntax error") }
function unknown_operation() { die("unknown operation") }

function die(msg) {
    print msg > "/dev/stderr"
    exit 1
}
