# Instructions

As we grow up, we can understand more and more complex texts. 
But how is the level of complexity of a given text assessed, 
and how can we make programs which do that? In this exercise, 
you will write a program which will determine how difficult a 
text is to read and what age it is best suited for.

We will use the [Automated readability index (ARI)][wiki] formula 
for calculating text complexity. The ARI was developed in 1967 
to assess the U.S. grade level required to read a piece of text. 
It does this by measuring the complexity of words and sentences. 
Complexity is measured as characters per word and words per sentence. 
A higher value is more complex.

## Text Preview

Your program should display the first three sentences of the text, but no more than 50 characters for each sentence.
If any sentence exceeds 50 characters, print only the first 50 characters followed by an ellipsis (`...`).
If the text contains more than three sentences, output only an ellipsis as the fourth line.

Suppose there is a file named "ari.txt" with the following contents (this text will be used for all examples below):

> ARI was designed for military use in 1967. It was for real-time 
> monitoring of readability on typewriters. It offered an automated 
> counting method. It has similar results to other frameworks.
> This validates its accuracy.

Then the program should print:

```text
The text is:
ARI was designed for military use in 1967.
It was for real-time monitoring of readability on ...
It offered an automated counting method.
...
```

## Text Statistics

The program should calculate and print the number of characters, words
and sentences in the text. Sentences can end with a full stop, 
an exclamation mark, or a question mark. 
Whitespaces separate words in a sentence. 
When counting the number of characters per word, count all non-blank 
characters, including punctuation marks. Print the statistics after 
the text preview, separated by an empty line.

Here is an example output for just the text statistics part:

```text
Words: 34
Sentences: 5
Characters: 186
```

## Automated readability index

Given these details about the text, we can calculate 
the level of its complexity using the following formula:

score = 4.71 * chars / words + 0.5 * words / sentences - 21.43

The program should calculate and print the score and the approximate age needed to comprehend the text. 

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

The score should be printed with two significant digits after 
the decimal point. When used to find the age or grade level, the score should be rounded
to the nearest whole number and capped at 14. Below is a sample output of 
the program:

```text
The text is:
ARI was designed for military use in 1967.
It was for real-time monitoring of readability on ...
It offered an automated counting method.
...

Words: 34
Sentences: 5
Characters: 186
Score: 7.74
This text should be understood by 12-13 year-olds.
```
[wiki]: https://en.wikipedia.org/wiki/Automated_readability_index
[ARI]: https://readable.com/readability/automated-readability-index/
