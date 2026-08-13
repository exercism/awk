#!/usr/bin/awk -f
#
# Alphametics solver.
#
# Reads a puzzle from stdin in the form:
#   WORD1 + WORD2 + ... == RESULT
# (a single "=" is also accepted)
#
# Prints one line of space-separated LETTER=DIGIT pairs, sorted
# alphabetically by letter, for a valid solution. Prints nothing
# if no solution exists.
#
# Approach: process the puzzle column by column, from the rightmost
# (units) digit to the leftmost, tracking the carry. Within each
# column, only the letters that appear for the first time are
# assigned digits (via backtracking), then the column's arithmetic
# is checked immediately. This prunes the search far more
# aggressively than trying full permutations of every letter.
function colchar(word, col,    L) {
    L = length(word)
    if (col < L) return substr(word, L - col, 1)
    return ""
}
# Try every valid digit for newl[idx..m], then verify/recurse.
function assign(idx, m, colletters, ncol, hasres, rch, newl, col, carr,
                 d, letter, i, colsum, total, digit_needed, newcarry, required) {
    if (idx > m) {
        colsum = 0
        for (i = 1; i <= ncol; i++) colsum += assigned[colletters[i]]
        total = colsum + carr
        digit_needed = total % 10
        newcarry = int(total / 10)
        required = hasres ? assigned[rch] : 0
        if (digit_needed != required) return 0
        return solve(col + 1, newcarry)
    }
    letter = newl[idx]
    for (d = 0; d <= 9; d++) {
        if (used[d]) continue
        if (leading[letter] && d == 0) continue
        assigned[letter] = d
        used[d] = 1
        if (assign(idx + 1, m, colletters, ncol, hasres, rch, newl, col, carr)) return 1
        delete assigned[letter]
        used[d] = 0
    }
    return 0
}
function solve(col, carry,
                colletters, ncol, i, ch, hasres, rch, newl, m, j, exists) {
    if (col == maxlen) return (carry == 0)
    ncol = 0
    for (i = 1; i <= nwords; i++) {
        ch = colchar(addends[i], col)
        if (ch != "") colletters[++ncol] = ch
    }
    hasres = (col < length(result))
    rch = hasres ? colchar(result, col) : ""
    m = 0
    for (i = 1; i <= ncol; i++) {
        ch = colletters[i]
        if (!(ch in assigned)) {
            exists = 0
            for (j = 1; j <= m; j++) if (newl[j] == ch) { exists = 1; break }
            if (!exists) newl[++m] = ch
        }
    }
    if (hasres && !(rch in assigned)) {
        exists = 0
        for (j = 1; j <= m; j++) if (newl[j] == rch) { exists = 1; break }
        if (!exists) newl[++m] = rch
    }
    return assign(1, m, colletters, ncol, hasres, rch, newl, col, carry)
}
{
    line = $0
    split(line, parts, /\s*==\s*/)
    lhs = parts[1]
    result = parts[2]
    nwords = split(lhs, addends, /\s*\+\s*/)
    maxlen = length(result)
    if (length(result) > 1) leading[substr(result, 1, 1)] = 1
    for (i = 1; i <= nwords; i++) {
        L = length(addends[i])
        if (L > maxlen) maxlen = L
        if (L > 1) leading[substr(addends[i], 1, 1)] = 1
    }
    if (solve(0, 0)) {
        n = 0
        for (l in assigned) letters[++n] = l
        for (i = 1; i <= n; i++)
            for (j = i + 1; j <= n; j++)
                if (letters[j] < letters[i]) {
                    t = letters[i]; letters[i] = letters[j]; letters[j] = t
                }
        out = ""
        for (i = 1; i <= n; i++) {
            if (i > 1) out = out " "
            out = out letters[i] "=" assigned[letters[i]]
        }
        print out
    }
}
