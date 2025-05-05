# These variables are initialized on the command line (using '-v'):
# - type
# - key
@load "ordchr"

BEGIN {
    OFS = FS = ""
    AlphabetSize = ord("z") - ord("a") + 1
    if (!key) randomKey()
    if (key !~ /^[a-z]+$/) {
        print "error: invalid key" > "/dev/stderr"
        exit 1
    }
}
{
    $0 = tolower($0)
    for (i = 1; i <= NF; i++)
        @type(i)
    print
}

function encode(i) {
    $i = chr((ord($i) - ord("a") + keyShift()) % AlphabetSize + ord("a"))
}
function decode(i) {
    $i = chr((ord($i) - ord("a") - keyShift() + AlphabetSize) % AlphabetSize + ord("a"))
}
function keyShift() {
    KeyIndex %= length(key)
    KeyIndex++
    return ord(substr(key, KeyIndex, 1)) - ord("a")
}
function randomKey(   i) {
    for (i = 1; i <= 100; i++)
        $i = randomLetter()
    print
    exit
}
function randomLetter() {
    return chr(ord("a") + int(rand() * AlphabetSize))
}