# Instructions

Calculate the number of sentences of words and characters in the text to estimate the [Automated readability index (ARI)](https://en.wikipedia.org/wiki/Automated_readability_index). 


> The ARI assesses the U.S. grade level required to read a piece of text.

> In some ways, it is similar to other formulas. Its difference is rather than counting syllables, it counts characters. The more characters, the harder the word. It also counts sentences. This sets it apart from some other formulas. ARI was designed for military use in 1967. It was for real-time monitoring of readability on typewriters. It offered an automated counting method. It has similar results to other frameworks. This validates its accuracy.

The ARI formula is as follows:

$$ARI = 4.71 { characters \over words }$$

Your task is to calculate the exact number of sentences, words and symbols in the text. 
The program should print the first three sentences of text. 
Print `...` on the forth line if the text has more than four sentences. 
After that, the program should print text statistics: number of words, 
sentences and characters. The program should calculate and print score 
as well as approximate age needed to comprehend the text. 



As an example, suppose there is a file named "ari.txt" with the following contents:

```text
ARI was designed for military use in 1967.
It was for real-time monitoring of readability on typewriters.
It offered an automated counting method.
It has similar results to other frameworks.
This validates its accuracy.
```

If we were to call `gawk -f ari.awk ari.txt`, the result should be:

```text
The text is:
ARI was designed for military use in 196...
It was for real-time monitoring of reada...
It offered an automated counting method
...

Words: 34
Sentences: 5
Characters: 186
The score is: 7.74
This text should be understood by 12-13 year-olds.
```

If given just one file, this prefix is not present.

## Flags

As said earlier, the `grep` command should also support the following flags:

- `-n` Prefix each matching line with its line number within its file.
  When multiple files are present, this prefix goes *after* the filename prefix.
- `-l` Print only the names of files that contain at least one matching line.
- `-i` Match line using a case-insensitive comparison.
- `-v` Invert the program -- collect all lines that fail to match the pattern.
- `-x` Only match entire lines, instead of lines that contain a match.

If we run `grep -n "hello" input.txt`, the `-n` flag will require the matching
lines to be prefixed with its line number:

```text
1:hello
3:hello again
```

And if we run `grep -i "HELLO" input.txt`, we'll do a case-insensitive match,
and the output will be:

```text
hello
hello again
```

The `grep` command should support multiple flags at once.

For example, running `grep -l -v "hello" file1.txt file2.txt` should
print the names of files that do not contain the string "hello".

[grep]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html
