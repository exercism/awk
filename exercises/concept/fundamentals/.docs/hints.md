# Hints

For all of these tasks, you'll need the `print` command:
```awk
{print "something", "something else"}
```

## 1. List the usernames

* Use the `FS` variable to define the field separator.

## 2. Print the line numbers

* Use the built-in variable `NR` to get the line number.

## 3. Print records with invalid home directories.

* The home directory is the 6th field.
* Use the given `startsWith` function.
* Use the `||` **OR** operator.

## 4. Print the number of valid users who use bash

* The login shell is the last field; you can use the `NF` variable.
