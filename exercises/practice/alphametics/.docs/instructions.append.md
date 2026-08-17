# ignore me

## Input

Your script will receive the alphametic puzzle as a single string via
standard input (stdin). The puzzle string follows the format
`WORD1 + WORD2 + ... == RESULT`.

For example:

```text
SEND + MORE == MONEY
```

## Output

If the puzzle has a solution, print a single line consisting of
space-separated `LETTER=DIGIT` pairs, sorted alphabetically by letter.

For the example above, the output should be:

```text
D=7 E=5 M=1 N=6 O=0 R=8 S=9 Y=2
```

If the puzzle has multiple valid solutions, printing any one of them is
acceptable.

If the puzzle has no solution, print nothing (an empty line).
