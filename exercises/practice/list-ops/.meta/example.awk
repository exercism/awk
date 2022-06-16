@namespace "listops"

# Append to a list all the elements of another list.
# Or append to a list a single new element
function append(list, list_or_elem,    i) {
    if (awk::isarray(list_or_elem)) {
        for (i = 1; i <= length(list_or_elem); i++) {
            Push(list, list_or_elem[i])
        }
    } else {
        Push(list, list_or_elem)
    }
}

function Push(list, element) {
    list[length(list)+1] = element
}

# Concatenate is flattening an array of arrays one level
function concat(list, result) {
    for (i = 1; i <= length(list); i++) {
        for (j = 1; j <= length(list[i]); j++) {
            Push(result, list[i][j])
        }
    }
}

# Only the list elements that pass the given function.
function filter(list, fun, result,    i) {
    for (i = 1; i <= length(list); i++) {
        if (@fun(list[i])) {
            Push(result, list[i])
        }
    }
}

# Transform the list elements, using the given function, into a new list.
function map(list, fun, result,    i) {
    for (i = 1; i <= length(list); i++) {
        Push(result, @fun(list[i]))
    }
}

# Left-fold the list using the function and the initial value.
function foldl(list, fun, acc,    i) {
    for (i = 1; i <= length(list); i++) {
        acc = @fun(acc, list[i])
    }
    return acc
}

# Right-fold the list using the function and the initial value.
function foldr(list, fun, acc,    i) {
    for (i = length(list); i >= 1; i--) {
        acc = @fun(list[i], acc)
    }
    return acc
}

# Reverse the list
function reverse(list, result,    i) {
    for (i = length(list); i >= 1; i--) {
        Push(result, list[i])
    }
}
