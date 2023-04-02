# Introduction

We'll refer to the _language_ as **AWK** and to the _executable_ that interprets AWK programs as **`awk`** or **`gawk`**.

## Patterns and Actions

An AWK program is structured in **pattern-action pairs**

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

### Omit the pattern

The pattern can be omitted, in which case the action is evaluated _for every input record_.
In other words, an "empty" pattern is implicitly _true_.

### Omit the action

The action can be omitted, in which case the default action is to **print** the current record.

### Special patterns

Two special pattern that are often used are

- `BEGIN` will evaluate the associated action before any input is consumed.
- `END` will evaluate the associated action after all input is consumed.

## Records and Fields

AWK splits the input into **records** and **fields**.
The default behaviour is to 

- split the input into records using **newline** as the "record separator", so each _line_ is a record.
- split the record into fields using **whitespace** as the "field separator", so each _word_ is a field.

You can supply your own input record separator with the `RS` variable.
You can supply your own input field separator with the `FS` variable.
Set these variables in the `BEGIN` block.

### Field variables

You refer to fields as `$1`, `$2`, `$3`, etc.

The current record is `$0`.

### Other common variables

- **`NF`** stores the _number of fields_ in the current record.
- **`$NF`** is the _value of the last field_.
- **`NR`** stores the _current record number_.
  - when multiple input files are being processed, `NR` will hold the total number of records processed so far.
- **`FNR`** stores the _record number_ of the _current input file_
  - a common AWK idiom is
    ```awk
    NR == FNR {action}
    ```
    This means "if the record number equals the record number of the current file", which is only true for records in the _first input file_.

## Truthiness

AWK was developed at Bell Labs, where C was invented. 
AWK uses the same concept of truthiness as C, where

- the number `0` is **false**
- _any other number_ is **true**

Since AWK is a text-processing language, truth values are extended to _strings_

- an empty string `""` is **false**
- _any non-empty string_ is **true**

~~~~exercism/caution
The number `0` is **false**.<br>
The non-empty string `"0"` is **true**!

We'll get more into AWK data types in subsequent concepts.
~~~~

## Comments

The `#` character starts a comment.

## Some examples

Here are some awk programs that produce the same results as other common Unix commands.

1. Display a file

    ```sh
    cat file.txt

    awk '1' file.txt
    ```

2. Search for patterns in a file

    ```sh
    grep 'foo.*bar' file.txt

    awk '/foo.*bar/' file.txt
    ```

3. Display only a few lines at the start of a file

    ```sh
    head -n 20 file.txt

    awk '
        1
        NR == 20 {exit}
    ' file.txt
    ```

4. Replace text in a file

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
