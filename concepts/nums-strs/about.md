# Introduction

AWK is a very small language and only has a few basic data types.
In this lession we'll go over numbers and strings.

## Numbers

Numbers in AWK are implemented as double-precision floating point numbers.
There is no distinction between integers, floats and doubles.

AWK understands octal number constants (starting with `0`) and hexadecimal number constants (starting with `0x` or `0X`).

### Numeric operations

You can use the [standard arithmetic operators][ops-arith] `+`, `-`, `*`, `/`, `%`.
The exponentiation operator is `^` (it is specified by POSIX) although `**` can also be used.
There are some [builtin numeric functions][funcs-numeric], including trigonometric functions, random number generation, and `int(x)` to truncate a number to the nearest integer between _x_ and zero.

There are no bitwise _operators_. 
gawk implements them as functions.
The arguments must be non-negative numbers.

| function            | operation                                      |
| ------------------- | ---------------------------------------------- |
| `and(a, b [, ...])` | bitwise AND of the arguments                   |
| `or(a, b [, ...])`  | bitwise OR of the arguments                    |
| `xor(a, b [, ...])` | bitwise XOR of the arguments                   |
| `lshift(v, count)`  | the value of _v_ left shifted by _count_ bits  |
| `rshift(v, count)`  | the value of _v_ right shifted by _count_ bits |
| `compl(v, count)`   | bitwise complement of _v_                      |

## Strings

AWK strings are sequences of characters.
Specify a string constant using double quotes.

~~~~exercism/caution
GNU awk allows Unicode characters in strings: other awk implementations may not.
Comparing `gawk` versus `mawk`, another popular AWK:

```sh
$ echo "Hi friend 😀!" | gawk '{print length($3)}'
2
$ echo "Hi friend 😀!" | mawk '{print length($3)}'
5
```
~~~~

### String operations

There is only one string operations: concatenation.
Concatenation does not have a special operator;
simply placing two strings next to each other concatenates them:

```awk
BEGIN {
    hw = "Hello" "World"
    print hw
}
# => HelloWorld
```

~~~~exercism/note
`print` is a **statement** not a function.
`print` does not require parentheses.
~~~~

AWK has a wealth of [string manipulation functions][funcs-string].
We will be introduced to them in depth as we proceed through the track.

## Converting between numbers and strings

There are no explicit operators to convert between numbers and strings.
AWK will do this implicitly based on the context of the program.
This makes working with input field values very simple: AWK generally just does what you want it to do.

* `print x + y` will convert the values of the `x` and `y` variables to numbers thanks to the `+` numeric operation.
* `print x y` will convert the values of the `x` and `y` variables to strings thanks to the concatenation operation.

If you want to be explicit about it, `0 + x` gives the number representation of _x_ and `"" x` gives the string representation of _x_.

### From strings to numbers

The manner that AWK converts a string to a number can be confusing.
A simple way to think of it is that AWK reads "number characters" from the start of a string until it finds a "non-number" character.
Some examples are:

* `"2.5"` converts to the number `2.5`;
* `"1e3"` converts to the number `1000` (scientific notation);
* `456abc` converts to the number `456` (because `a` is not a "numeral").

Full details are [in the manual][str-to-num].

## Determining the type of a variable

The [`typeof(var)` function][func-typeof] returns the type as a string.

```awk
BEGIN {
    x = "42"
    print x, typeof(x)
    x = x + 1           # type conversion
    print x, typeof(x)
}
```
outputs
```none
42 string
43 number
```


[ops-arith]: https://www.gnu.org/software/gawk/manual/html_node/Arithmetic-Ops.html
[funcs-numeric]: https://www.gnu.org/software/gawk/manual/html_node/Numeric-Functions.html
[funcs-string]: https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html
[str-to-num]: https://www.gnu.org/software/gawk/manual/html_node/Strings-And-Numbers.html
[func-typeof]: https://www.gnu.org/software/gawk/manual/html_node/Type-Functions.html
