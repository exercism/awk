# Introduction

Recall from the Fundamentals concept, an AWK program is composed of **pattern-action pairs**.

```awk
pattern1 { action1 }
pattern2 { action2 }
...
```

## What do we mean by "pattern"?

The "pattern" is any AWK expression.
The truthiness of the expression's result determines if the action is executed.

## The Empty Pattern

The pattern can be omitted.
In this case, the action is performed for every record.

We can print all the usernames in the passwd file.

```sh
awk -F: '{print $1}' /etc/passwd
```

## Regular Expressions

AWK can compare strings against regular expressions to obtain a boolean result.

Use the `~` regex-matching operator to match a particular field. 
This operator takes a string as the left-hand operand and a regular expression as the right-hand operand.
A regular expression literal is enclosed in `/` slashes.

To find the user in the passed file who log in with bash:

```sh
awk -F: '$7 ~ /bash/ {print $1}' /etc/passwd
```

`!~` is the "regex does **not** match" operator.

If you want to match a regex against the whole current record, there's a shorthand syntax for it:
the `$0 ~ /regex` expression can be simply expressed as:

```sh
awk '/regex/' data.txt
```

~~~~exercism/note
Compare that AWK one-liner with the equivalent grep command

```sh
grep 'regex' data.txt
```

AWK gives you a whole programming language without sacrificing succinctness.
~~~~

We'll get more into GNU AWK's regular expression flavour in a further concept.

## Arithmetic expressions

Arithmetic expressions can be used as patterns.

To extract all users with UID 1000 or above:

```sh
awk -F: '$3 >= 1000' /etc/passwd
```

Recall that zero is a false value and all other numbers are true.

## Functions

Any [builtin][builtins] or [user-defined][] function can be used in an expression, and hence in the pattern.
A couple of examples:

```awk
length($1) {print "first field is not empty"}
```
```awk
toupper(substr($1, 1, 1)) ~ /[AEIOU]/ {print "starts with a vowel"}
```

## Constant Patterns

A common AWK idiom is:

```sh
{
    xyz()   # some code that transforms each record
}
1
```

`1` is a truthy pattern with no associated action.
This means "print the current record."


[builtins]: https://www.gnu.org/software/gawk/manual/html_node/Built_002din.html
[user-defined]: https://www.gnu.org/software/gawk/manual/html_node/User_002ddefined.html
