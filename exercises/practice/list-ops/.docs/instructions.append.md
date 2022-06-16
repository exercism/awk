# placeholder

## New AWK concepts

There are several interesting new concepts we're seeing in this exercise.

The following sections that tagged with "(gawk)" are specifically GNU awk extensions.

### Include files <sup>(gawk)</sup>

This is the first exercise we've seen where the solution we're writing is
not a "main" script. We're writing a library to be included into other awk
programs.  You'll see the [`@include`][d-include] directive in the test
file.  This is analagous to the shell's `source` (aka `.`) command.

### Namespaces <sup>(gawk)</sup>

We're introducing [namespaces][namespaces]. All awk variables are global
(except for function parameters which are local to the function):
there is a high potential for name collisions, particularly if you're
including third-party libraries. Namespaces are a way to partition where
variables are stored. You'll see the [`@namespace`][d-namespace] directive
in the exercise's files.

### Dynamic function invocation <sup>(gawk)</sup>

awk functions are not first-class objects: they can't get passed around like
other languages allow. However, you can pass the _name_ of a function as a
string and use that to invoke the function:

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

### How function parameters are passed

Array parameters are passed **by reference**. Changes to the array made in
the function are visible in the caller.

Non-array parameters a passed **by value**.

For _untyped_ parameters, it depends on what the function does with them:
- if the function initializes it as an array, then it becomes a parameter
  passed by reference,
- if the function initializes it as a scalar, then that parameter is handled
  as "passed by reference", and it does not materialize in the caller.

Full details are in the manual in [Passing Function Arguments by Value Or by
Reference][pass-by].

#### Local variables

"Pass by value" parameters is how we can achieve "local variables" in a
function. It is not an error to pass fewer values to a function than the
number of listed parameters; the excess parameters are "untyped" until they
get used. They are available to be assigned scalar values in the function
that are not stored in the global namespace.

If you assign to a parameter, that is local to the function.  
If you assign to any other variable, that variable is global.

By convention, local parameters are separated from the expected parameters
by whitespace.

```awk
function add(a, b,    total) {
    # here, `typeof(total)` is "untyped"
    total = a + b
    # now, `typeof(total)` is "number"
    return total
}

BEGIN {
    sum = add(5, 10)
    print sum             # 15
    print typeof(total)   # untyped, meaning "total" is unused in this scope
}
```


[d-include]: https://www.gnu.org/software/gawk/manual/html_node/Include-Files.html
[namespaces]: https://www.gnu.org/software/gawk/manual/html_node/Namespaces.html 
[d-namespace]: https://www.gnu.org/software/gawk/manual/html_node/Changing-The-Namespace.html 
[indirect]: https://www.gnu.org/software/gawk/manual/html_node/Indirect-Calls.html 
[pass-by]: https://www.gnu.org/software/gawk/manual/html_node/Pass-By-Value_002fReference.html 
