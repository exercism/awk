# placeholder

## New AWK concepts

Refer to the [`matrix` exercise instructions][ex-matrix] to refresh on some interesting GNU awk language features.

### Dynamic function invocation

awk functions are not first-class objects: they can't get passed around like some other languages allow.
However, a variable can hold the _name_ of a function (a string), and the function is invoked using a special `@varname(args)` notation.
An example:

```awk
function greet(name) {
    print "Hello, " name
}
BEGIN {
    greet("John")       # => "Hello, John"

    f = "greet"
    f("Bill")           # => error
    @f("Bill")          # => "Hello, Bill"
}
```
This is described in [Indirect Function Calls][indirect].
This is a `gawk` extension.


[ex-matrix]: https://exercism.org/tracks/awk/exercises/matrix
[indirect]: https://www.gnu.org/software/gawk/manual/html_node/Indirect-Calls.html
