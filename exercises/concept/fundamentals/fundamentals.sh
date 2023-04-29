#!/bin/sh

# You will implement this exercise with a shell script that contains some awk commands.
# In subsequent exercises, the solution file will contains only awk code.
#
# You have 4 tasks to solve.
# Replace the `{exit}` action with awk code to solve the task.

## task 1
awk '{exit}' ./passwd

## task 2
awk '{exit}' ./passwd

## task 3
awk '
    # returns true if the text starts with the prefix
    # 
    #   startsWith("Hello, World!", "He")   # => true
    #   startsWith("Goodbye, Mars!", "He")  # => false
    #
    function startsWith(text, prefix) {
        return text ~ "^"prefix
    }

    {exit}
' ./passwd

## task 4
awk '
    function startsWith(text, prefix) {
        return text ~ "^"prefix
    }

    {exit}
' ./passwd
