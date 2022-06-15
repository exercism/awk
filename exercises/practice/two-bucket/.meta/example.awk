#!/usr/bin/env gawk -f

BEGIN {
    FS = OFS = ","
}

!validate($1, $2, $3) {
    print "Error: invalid goal" > "/dev/stderr"
    exit 1
}

{
    b1 = Bucket::new("one", $1)
    b2 = Bucket::new("two", $2)
    goal = $3
    if ($4 == "one")
        solve(b1, b2)
    else
        solve(b2, b1)
}

############################################################
function validate(size1, size2, goal,    m, g) {
    m = Math::max(size1, size2)
    if (goal > m) return 0
    g = Math::gcd(size1, size2)
    if (g > 1 && goal % g != 0) return 0
    return 1
}

function solve(start, other,    moves) {
    Bucket::fill(start)
    moves = 1

    if (Bucket::size(other) == goal) {
        Bucket::fill(other)
        moves++
    }

    while (1) {
        if (Bucket::amount(start) == goal) {
            print moves, Bucket::name(start), Bucket::amount(other)
            return
        }
        else if (Bucket::amount(other) == goal) {
            print moves, Bucket::name(other), Bucket::amount(start)
            return
        }

        if (Bucket::is_empty(start)) 
            Bucket::fill(start)
        else if (Bucket::is_full(other))
            Bucket::empty(other)
        else
            Bucket::pour(start, other)

        moves++
    }
}

############################################################
@namespace "Math"

function gcd(a, b) {
    if (b == 0) return a
    return gcd(b, a % b)
}

function min(a, b) {
    return (a < b) ? a : b
}

function max(a, b) {
    return (a > b) ? a : b
}

############################################################
# An "object" system based on perl "inside-out" objects:
# an object's data is stored in hashes keyed by the object id.
@namespace "Bucket"

BEGIN {
    Count = 0
}

function new(name, size) {
    id = ++Count
    Name[id] = name
    Size[id] = size
    Amount[id] = 0
    return id
}

function size(id)   { return Size[id] }
function name(id)   { return Name[id] }
function amount(id) { return Amount[id] }

function is_empty(id) { return Amount[id] == 0 }
function is_full(id)  { return Amount[id] == Size[id] }

function fill(id)  { Amount[id] = Size[id] }
function empty(id) { Amount[id] = 0 }

function pour(from, to,    qty) {
    qty = Math::min(Amount[from], (Size[to] - Amount[to]))
    Amount[from] -= qty
    Amount[to]   += qty
}
