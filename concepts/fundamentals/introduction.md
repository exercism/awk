# Introduction

We'll refer to the _language_ as **AWK** and to the _executable_ that interprets AWK programs as **`awk`** or **`gawk`**.

## Patterns and Actions

An AWK program is composed of **pattern-action pairs**

```awk
pattern1 { action1 }
pattern2 { action2 }
...
```

A **pattern** can be a regular expression pattern to match against the input.
But it can also be any expression that results in a true/false value.

An **action** is one or more AWK commands.
The enclosing braces are required.

If the result of the pattern is _true_, then the corresponding action is evaluated.

## Records and Fields

AWK parses the input as a series of **records**.
Each record is split into zero or more **fields**.

The default behaviour is to 

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

Here are some other frequently used builtin variables.

### Builtin variables that control input parsing

- `RS` is the input record separator. As mentioned, its default value is a newline.
- `FS` is the input field separator. 

These variable are often set in the `BEGIN` action block.

### Builtin variables that convey information 

These variables are automatically set by AWK during execution of the program.

- `NF` stores the number of fields in the current record.
- `$NF` is the value of the last field.
- `NR` stores the current record number.
  - when multiple input files are being processed, `NR` will hold the total number of records processed so far.
- `FNR` stores the current record number of the current input file
  - a common AWK idiom is
    ```awk
    NR == FNR {action}
    ```
    This means "if the record number equals the record number of the current file", which is only true for records in the _first input file_.

## Truthiness

AWK was developed at Bell Labs, where C was invented. 
AWK uses the same concept of truthiness as C:

- the number `0` is false
- any other number is true

Since AWK is a text-processing language, truth values are extended to strings.

- an empty string `""` is false
- any non-empty string is true

## Comments

Comments start with the `#` character and extend to the end of the line.

## Some examples

On Unix-like systems `/etc/passwd` contains information about users. 
Each user is described on a separate line, with fields separated by colons.

To list the usernames

```sh
awk '
    BEGIN { FS = ":" }
    { print $1 }
' /etc/passwd
```

Notice that the `{print $1}` action has no pattern, so it is executed for every record.

If we want to limit the output to only users who use bash as their login shell, we can do

```sh
awk '
    BEGIN { FS = ":" }
    $7 == "/bin/bash" { print $1 }
' /etc/passwd
```
