# placeholder

## ASCII values

This exercise requires converting ASCII characters to and from their numeric value.
GNU awk's [ordchr extension][ordchr] provides this functionality. To add the
`ord()` and `chr()` functions, load the `ordchr` extension by adding a `@load`
directive to the top of your file:

```
@load "ordchr"
```

[ordchr]: https://www.gnu.org/software/gawk/manual/gawk.html#Extension-Sample-Ord
