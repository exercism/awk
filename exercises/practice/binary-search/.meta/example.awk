# These variables are initialized on the command line (using '-v'):
# - value

BEGIN {FS = ","}

{
    left = 1
    right = NF
    idx = -1
    while (left <= right) {
        mid = int((left + right) / 2)
        if (value == $mid) {
            idx = mid
            break
        }
        else if (value < $mid) {
            right = mid - 1
        }
        else {
            left = mid + 1
        }
    }
    print idx
}
