# Instructions

As we grow up, we can understand more and more complex texts. But how to assess 
the level of complexity of a given text, and how to teach the computer to do so? 
In this exercise, you will write a program determining how difficult a text is 
and for what age it is best suited.

For a formula for calculating the complexity, we will use 
[Automated readability index (ARI)][wiki] 
developed in 1967 year. The ARI assesses the U.S. grade level required to read 
a piece of text. In some ways, it is similar to other formulas. Its difference 
is rather than counting syllables, it counts characters. The more characters, 
the harder the word. It also counts sentences. This sets it apart from some 
other formulas.

## Text Preview

Your program should display the first three sentences of the text. If the sentence 
is longer than 50 characters, truncate the sentence and add an ellipsis at the end. 
Put an ellipsis on the fourth line if the text is more than three sentences.

Suppose the text starts with the following lines:

> Billy always listens to his mother. He always does what
> she says. If his mother says, "Brush your teeth," Billy
> brushes his teeth. If his mother says, "Go to bed," Billy
> goes to bed...

Then the program should print:

```text
The text is:
Billy always listens to his mother.
He always does what she says.
If his mother says, "Brush your teeth," Billy brus...
...
```

## Text Statistics

The program should calculate and print the exact number of sentences, words 
and characters in the text. The sentences can end with a full stop, 
an exclamation mark, and a question mark. The last sentence can be with or 
without a punctuation mark at the end. Spaces separate words in a sentence; 
we count all non-blank characters, including punctuation marks. Print 
the statistics after the text preview, separating them with an empty line, 
as in the example:

```text
The text is:
ARI was designed for military use in 1967.
It was for real-time monitoring of readability on ...
It offered an automated counting method.
...

Words: 34
Sentences: 5
Characters: 186
```

## Automated readability index

Knowing the main characteristics of the text, we can calculate 
the level of its complexity using the following formula:

```math
Score = 4.71 ( { characters \over words }) + 0.5 ({words \over sentences}) - 21.43
```

The program should calculate and print score as well as approximate age needed to comprehend the text.

| Score | Age	  | Grade Level     |
|-------|-------|-----------------|
| 1     | 5-6   | Kindergarten    |
| 2     | 6-7   | First Grade     |
| 3     | 7-8   | Second Grade    |
| 4     | 8-9   | Third Grade     |
| 5     | 9-10  | Fourth Grade    |
| 6     | 10-11 | Fifth Grade     |
| 7     | 11-12 | Sixth Grade     |
| 8     | 12-13 | Seventh Grade   |
| 9     | 13-14 | Eighth Grade    |
| 10    | 14-15 | Ninth Grade     |
| 11    | 15-16 | Tenth Grade     |
| 12    | 16-17 | Eleventh Grade  |
| 13    | 17-18 | Twelfth Grade   |
| 14    | 18-22 | College student |

As an example, suppose there is a file named "ari.txt" with the following contents:

```text
ARI was designed for military use in 1967.
It was for real-time monitoring of readability on typewriters.
It offered an automated counting method.
It has similar results to other frameworks.
This validates its accuracy.
```

if we run our program by specifying this file, the result will be as follows:

```text
The text is:
ARI was designed for military use in 1967.
It was for real-time monitoring of readability on ...
It offered an automated counting method.
...

Words: 34
Sentences: 5
Characters: 186
The score is: 7.74
This text should be understood by 12-13 year-olds.
```
[wiki]: https://en.wikipedia.org/wiki/Automated_readability_index
[ARI]: https://readable.com/readability/automated-readability-index/
