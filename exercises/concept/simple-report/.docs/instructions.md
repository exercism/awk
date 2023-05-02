# Instructions

You are helping a friend generate a report from readings he has taken in different corners of his garden.
Unfortunately, your friend has stored the data in a strange format.
Each reading is a set of comma separated fields.
However, he has stored two-digit numbers across two columns.

| field number | meaning |
| --- | --- |
| 1 | ID number |
| 2 | location |
| 3 | first reading, tens value |
| 4 | first reading, ones value |
| 5 | second reading, tens value |
| 6 | second reading, ones value |

For an input row like `101,house,4,2,5,4`
- the first reading is `42`,
- the second reading is `54`.

## Task 1: Generate the report

Your task is find the average of the two readings and output the results of each row in the following format

```none
#<id>, <label> = <average>
```

Since the average of 42 and 54 is 48, the output for the sample row should be:

```none
#101, house = 48
```
