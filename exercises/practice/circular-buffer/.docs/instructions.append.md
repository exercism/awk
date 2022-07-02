# placeholder

## This a tricky AWK exercise

In this exercise, the `read` function needs to return a value _and_ a success status.
This is straightforward in other languages: for example

* bash functions can print data to stdout and also return an exit status
* languages like elixir can return a _tuple_ where the first element
  represents the status and the following elements hold the data

AWK cannot do what bash does: it can only return a single value.

AWK cannot quite do what elixir does: it can only return a _scalar_ value.

We are forced to use pass an array as a function parameter.
This pass-by-reference parameter can then be populated with return values as desired.
