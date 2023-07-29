# About

We'll refer to the _language_ as **AWK** and to the _executable_ that interprets AWK programs as **`awk`** or **`gawk`**.

## Patterns and Actions

An AWK program is composed of **pattern-action pairs**

```awk
pattern1 { action1 }
pattern2 { action2 }
...
```

A **pattern** can be a regular expression pattern to match against the input.
It can also be any expression that results in a true/false value.

An **action** is one or more AWK commands.
The enclosing braces are required.

If the result of the pattern is _true_, then the corresponding action is evaluated.

## Records and Fields

AWK parses the input as a series of **records**.
Each record is split into zero or more **fields**.

The default behaviour is to:

- split the input into records using newline as the "record separator", so each _line_ is a record.
- split the record into fields using whitespace as the "field separator", so each _word_ is a field.

## Patterns and Actions, continued

The pattern can be omitted, in which case the action is evaluated _for every input record_.

The action can be omitted, in which case the default action is to print the current record.

### Special patterns

There are two special patterns that are often used.

- `BEGIN` will evaluate the associated action before any input is consumed.
- `END` will evaluate the associated action after all input is consumed.

## Field variables

You refer to fields as `$1`, `$2`, `$3`, etc.

The current record is `$0`.

~~~~exercism/caution
To be explicit, these are not strictly "variables".
The `$` can be considered as an _operator_ that gets the value of the given field number.
We will dig deeper into this in later concepts.
~~~~

Here are some other frequently used builtin variables.

### Builtin variables that control input parsing

- `RS` is the input record separator.
  As mentioned, its default value is a newline.
- `FS` is the input field separator.

These variable are often set in the `BEGIN` action block.

### Builtin variables that convey information

These variables are automatically set by AWK during execution of the program.

- `NF` stores the number of fields in the current record.
  - To get the value of the last field, use `$NF`.
- `NR` stores the current record number.
  - When multiple input files are being processed, `NR` will hold the total number of records processed so far.
- `FNR` stores the current record number of the current input file.
  - To illustrate the difference between NR and FNR, here is a common AWK idiom.
    ```awk
    NR == FNR {action}
    ```
    This means "if the accumulated record number equals the record number of the current file."
    This can only be true for records in the _first input file_.

## Truthiness

AWK uses the same concept of truthiness as C:

- The number `0` is false.
- Any other number is true.

Since AWK is a text-processing language, truth values are extended to strings.

- An empty string `""` is false.
- Any non-empty string is true.

~~~~exercism/note
> AWK uses the same concept of truthiness as C

AWK originated at Bell Labs in the 1970s, in the same environment where C was invented.
C had a large influence on AWK's syntax.
~~~~

~~~~exercism/caution
One oddity to watch out for

- The number `0` is false.
- The non-empty string `"0"` is true!

We'll get more into AWK data types in subsequent concepts.
~~~~

## Comments

Comments start with the `#` character and extend to the end of the line.

## How to give input to `awk`

`awk` can read input from files or from standard input.
Any of these techniques will work.

```sh
awk '/regex/ {print $1}' file1 file2 ...

awk '/regex/ {print $1}' < file

some_command_here | awk '/regex/ {print $1}'
```

## Examples

On Unix-like systems `/etc/passwd` contains information about users.
Each user is described on a separate line, with fields separated by colons.

To list the usernames:

```sh
awk '
    BEGIN { FS = ":" }
    { print $1 }
' /etc/passwd
```

Notice that the `{print $1}` action has no pattern, so it is executed for every record.

If we want to limit the output to only users who use bash as their login shell, we can do:

```sh
awk '
    BEGIN { FS = ":" }
    $7 == "/bin/bash" { print $1 }
' /etc/passwd
```

### Some more examples

Here are some awk programs that produce the same results as other common Unix commands.

- Display a file

    ```sh
    cat file.txt

    awk '1' file.txt
    ```

- Search for patterns in a file

    ```sh
    grep 'foo.*bar' file.txt

    awk '/foo.*bar/' file.txt
    ```

- Display only a few lines at the start of a file

    ```sh
    head -n 20 file.txt

    awk '
        1
        NR == 20 {exit}
    ' file.txt
    ```

- Replace text in a file

    ```sh
    sed 's/foo/bar/' file.txt

    awk '{sub(/foo/, "bar")};1' file.txt
    # or more readably
    awk '
        {
            sub(/foo/, "bar")
            print
        }
    ' file.txt
    ```
