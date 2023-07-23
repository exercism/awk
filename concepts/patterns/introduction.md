# Introduction

Recall from the Fundamentals concept, an AWK program is composed of **pattern-action pairs**.

```awk
pattern1 { action1 }
pattern2 { action2 }
...
```

## What do we mean by "pattern"?

The "pattern" is any AWK expression that results in a true or false value.

## The Empty Pattern

The pattern can be omitted.
In this case, the action is performed for every record.

We can print all the usernames in the passwd file.

```sh
awk -F: '{print $1}' /etc/passwd
```

## Regular Expressions

AWK can do what grep can do.

This example compares the whole record (`$0`) to the regex.

```sh
awk '/regex/' data.txt
```

A regular expression literal is enclosed in `/` slashes.

Use the `~` regex-matching operator to match a particular field. 
To find the users who use bash:

```sh
awk -F: '$7 ~ /bash/ {print $1}' /etc/passwd
```

`!~` is the "regex does **not** match" operator.

We'll get more into GNU AWK's regular expression flavour in a further concept.


## Arithmetic expressions

Arithmetic expressions can be used as patterns.

To extract all users with UID 1000 or above:

```sh
awk -F: '$3 >= 1000' /etc/passwd
```

Recall that zero is a false value and all other numbers are true.

## Functions

[Builtin][builtins] and [user-defined][] functions can be used in the pattern.

```awk
length($1) {print "first field is not empty"}
```
```awk
toupper(substr($1, 1, 1)) ~ /[AEIOU]/ {print "starts with a vowel"}
```


[builtins]: https://www.gnu.org/software/gawk/manual/html_node/Built_002din.html
[user-defined]: https://www.gnu.org/software/gawk/manual/html_node/User_002ddefined.html
