# placeholder

## Time functions

This exercise requires using GNU awk's [Time Functions][time-func].

For the datetime parsing and formatting functions, be sure to **set the UTC flag**.
To demonstrate:

```sh
export TZ=Asia/Kolkata
gawk 'BEGIN {
    time = 1234567890
    print strftime("%Y-%m-%d %T", time)     # format for local timezone
    print strftime("%Y-%m-%d %T", time, 1)  # format for UTC
}'
```

outputs:

```none
2009-02-14 05:01:30
2009-02-13 23:31:30
```

[time-func]: https://www.gnu.org/software/gawk/manual/html_node/Time-Functions.html
