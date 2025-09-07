# Hints

## General

- You can accomplish all of these tasks without using an `if` statement.

## 1. Determine if you will need a drivers license

- Use the [equality operator][cmp] to check whether the first field equals a certain string.
- Use a a regular expression or the `index` function to check if the second field contains the required substrings.
- Use one of the two [boolean operators] to combine the two requirements.

## 2.Calculate an estimation for the price of a used vehicle

- Use the [comparison operators][cmp] to determine which discount to use.
- To calculate the result, apply the percentage to the original price.
  For example, `30% of x` can be calculated by multiplying `x` by `30` and dividing by `100`.

[cmp]: https://www.gnu.org/software/gawk/manual/html_node/Comparison-Operators.html
[boolean operators]: https://www.gnu.org/software/gawk/manual/html_node/Boolean-Ops.html
