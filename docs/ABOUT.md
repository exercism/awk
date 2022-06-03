# About

`awk` is an interpreted programming language designed for text processing and typically used as a data extraction and reporting tool.
It is a standard feature of most Unix-like operating systems.

An `awk` programming paradigm can be said to be "data driven":
an `awk` program reads lines (or other units of text), and looks for matches of _patterns_.
When a match occurs, the specified _action_ is performed.

An `awk` program looks something like
```awk
pattern1 {action1}
pattern2 {action2}
...
```

The _pattern_ can be a regular expression or some other expression that evaluates to a true/false value.
The _pattern_ can be omitted, in which case the _action_ is performed for each record of text.
The _action_ can be omitted, in which case the default action is to print the current record.

`awk` is an excellent addition to the user's toolbox.
It is very good at short "one-liner" programs entered at the command line.
A single `awk` program can replace most pipelines of `grep`, `sed`, `tr`, `cut`

## Implementations

`awk` was invented in 1977 by authors Alfred Aho, Peter Weinberger, and Brian Kernighan (whose surnames give us the language's name).
This implementation has come to be known as "old awk".
In 1985, an improved version was released, and is known as "BWK awk" or "new awk" or "the one-true-awk".
This is the version shipped with macOS and some of the \*BSD distributions

Another common implementation is `mawk`, which is based on a bytecode interpreter.
`mawk` is very fast.
`mawk` is the default `/usr/bin/awk` shipped on many Linux distros.

This track will use `gawk`, GNU's awk implementation.
`gawk` may not have the raw speed of `mawk`, but it is very feature-packed, well documented, and has some handy command-line options.

## Further reading

* [AWK on Wikipedia][wiki]
* [Stack Overflow awk info page][so]



[wiki]: https://en.wikipedia.org/wiki/AWK
[so]: https://stackoverflow.com/tags/awk/info
