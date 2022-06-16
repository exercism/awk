# placeholder

## New AWK concepts

This is the first exercise where the solution is not a "main" script.
The goal is to write a library of functions to be included into other awk programs.
There are several interesting new concepts to see in this exercise.

The following sections that are tagged with "(gawk)" are specifically GNU awk extensions.

### Include files <sup>(gawk)</sup>

Notice the [`@include`][d-include] directive in the test file.  
This instructs gawk to read and evaluate the named file.

### Namespaces <sup>(gawk)</sup>

All awk variables are global (except for function parameters which are local to the function).
There is a high potential for name collisions, particularly when third-party libraries get included. 
[Namespaces][namespaces] are a way to partition where variables are stored.
Notice the [`@namespace`][d-namespace] directive in the exercise's files.

The default namespace is named "awk". 
Having a default namespace allows the programmer to call a builtin awk function from inside a function in a different namespace.

### Dynamic function invocation <sup>(gawk)</sup>

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

### How function parameters are passed

Array parameters are passed **by reference**.
Changes to the array made in the function are visible in the caller.

Non-array parameters are passed **by value**.

For _untyped_ parameters, it depends on what the function does with them:
- if the function initializes it as an array, then it becomes a parameter passed by reference,
- if the function initializes it as a scalar value (a number or a string), then it is not a reference.

Full details are in the manual in [Passing Function Arguments by Value Or by Reference][pass-by].

#### Local variables

Function scoped (local) variables can be created by using "pass by value" parameters.
It is not an error to pass fewer values to a function than the number of listed parameters;
the excess parameters are "untyped" until they get used.
They are available to be assigned scalar values in the function that are not stored in the global namespace.

- If you assign a scalar value to a parameter, that is local to the function.
- If you assign a scalar to a variable **not** named in the parameter list, that variable is global.

By convention, in the function signature the expected parameters appear first followed by some whitespace and then the local parameters.
An example:

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
