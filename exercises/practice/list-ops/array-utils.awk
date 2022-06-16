@namespace "array"

# some functions used in the List Operations test file.

# Initialize a variable as an array type
function init(array,    type) {
    type = awk::typeof(array)
    if (!(type == "array" || type == "untyped"))
        print "Error: parameter of type " type " cannot be converted to an array" > "/dev/stderr"

    delete array
    array[0] = 0
    delete array[0]
}

# print an array's keys and values
function pprint(a,    maxw, i) {
    if (awk::typeof(a) == "array" ) {
        maxw = -1
        for (i in a)
            if (length(i) > maxw)
                maxw = length(i)
        for (i in a)
            printf "%-*s = %s\n", maxw + 2, "[" i "]", a[i]
    }
}
