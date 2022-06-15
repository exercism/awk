# To `grep` or not to `grep`, that is the question

## AWK-track adjustments to the requirements

You are not forced to implement proper command line parsing: the flags are
provided in a space-separated string that is straightforward to split apart.
```sh
gawk -f grep.awk -v flags="l v" -v pattern="hello" file1.txt file2.txt
```

Like real grep, your program will return a **non-zero exit status** when _no matches are found_.
