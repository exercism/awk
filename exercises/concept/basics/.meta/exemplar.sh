#!/bin/sh

## task 1
awk '
    BEGIN {FS = ":"}
    {print $1}
' ./passwd

## task 2
awk '{print NR}' ./passwd

## task 3
awk '
    function startsWith(text, prefix) {
        return text ~ "^"prefix
    }
    !(startsWith($6, "/home") || startsWith($6, "/root"))' FS=':' ./passwd

## task 4
awk -F ':' '
    function startsWith(text, prefix) {
        return text ~ "^"prefix
    }
    (startsWith($6, "/home") || startsWith($6, "/root")) && $NF ~ /bash/
' ./passwd
