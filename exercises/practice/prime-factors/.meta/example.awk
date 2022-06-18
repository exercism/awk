{
    remaining = $1
    candidate = 2
    while (remaining > 1) {
        if (remaining % candidate == 0) {
            if (out) {
                out = out " "
            }
            out = out candidate
            remaining /= candidate
        } else {
            candidate++
        }
    }
    print(out)
}
