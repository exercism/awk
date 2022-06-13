# placeholder

## Sorting in AWK

This exercise requires the output to be sorted in a particular way.  Like
many programming languages, iterating over an associative array occurs in
some random-looking internal hashing order of the keys. This is typically
not what humans want to see.  GNU awk provides some sorting features.

1. `asort` -- sort a numerically indexed array based on the array _values_.

    ```awk
    #!gawk 
    BEGIN {
        for (i = 1; i <= 5; i++)
            nums[i] = int(100 * rand())

        # returns the array size
        n = asort(nums, sorted)

        for (i = 1; i <= n; i++)
            print i, nums[i], sorted[i]
    }
    ```
    which outputs
    ```none
    1 92 30
    2 59 57
    3 30 59
    4 57 74
    5 74 92
    ```

    The form `n = asort(array)` sorts the named array in-place.

    This is most useful for numerically-indexed arrays. The process that
    populates the `sorted` array discards the originally arrays indices:
    the `sorted` array is indexed from 1 to `n`.

1. `asorti` -- sort any array based on the array _indices_.

    The `asorti` function populates a "destination" array containing the 
    "source" array's indices sorted.

    ```awk
    #!gawk
    BEGIN {
        nums["foo"] = int(100 * rand())
        nums["bar"] = int(100 * rand())
        nums["qux"] = int(100 * rand())

        print "unordered"
        for (i in nums)
            print i, nums[i]

        print "ordered by index"
        n = asorti(nums, sorted)
        for (i = 1; i <= n; i++)
            print sorted[i], nums[sorted[i]]
    }
    ```
    which outputs
    ```none
    unordered
    foo 92
    qux 30
    bar 59
    ordered by index
    bar 59
    foo 92
    qux 30
    ```

1. `PROCINFO["sorted_in"]` -- sort any array using a sorting function.

    The builtin PROCINFO array contains a lot of information about the
    running awk process. One interesting element of this array is
    `sorted_in`. The value of this array key is the name of a function
    which controls the order in which array indices will be processed by `for
    (indx in array)` loops.

    The function can be the name of a user-defined function (_hint: this is
    relevant to this particular exercise_), or there are some handy
    predefined sorting functions, including:

    * `"@ind_str_asc"`, `"@ind_str_desc"` - sort the array by index; use
      alphabetical sorting; sort ascending or descending.
    * `"@ind_num_asc"`, `"@ind_num_desc"` - sort the array by index; use
      numerical sorting; sort ascending or descending.
    * `"@val_str_asc"`, `"@val_str_desc"` - sort the array by value; use
      alphabetical sorting; sort ascending or descending.
    * `"@val_num_asc"`, `"@val_num_desc"` - sort the array by value; use
      numerical sorting; sort ascending or descending.

    The `asort` example above can be implementented like:
    ```awk
    PROCINFO["sorted_in"] = "@val_num_asc"
    for (idx in nums)
        print idx, nums[idx]
    ```
    ```none
    3 30
    4 57
    2 59
    5 74
    1 92
    ```

    The `asorti` example can be written:
    ```awk
    PROCINFO["sorted_in"] = "@ind_str_asc"
    for (idx in nums)
        print idx, nums[idx]
    ```
    ```none
    bar 59
    foo 92
    qux 30
    ```

    This method allows us to avoid the temporary `sorted` array and `n`
    return value. Neat and tidy.



### References

- [Array Sorting Functions](https://www.gnu.org/software/gawk/manual/html_node/Array-Sorting-Functions.html)
- [Controlling Array Traversal](https://www.gnu.org/software/gawk/manual/html_node/Controlling-Array-Traversal.html)
- [Using Predefined Array Scanning Orders with gawk](https://www.gnu.org/software/gawk/manual/html_node/Controlling-Scanning.html)  

