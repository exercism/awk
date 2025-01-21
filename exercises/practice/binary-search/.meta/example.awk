# These variables are initialized on the command line (using '-v'):
# - target

BEGIN {
    if (target == "") {
        print "Error: 'target' variable not set." > "/dev/stderr"
        exit 1
    }
    FS = ","
}

{
    left = 1
    right = NF
    idx = -1
    while (left <= right) {
        mid = int((left + right) / 2)
        if (target == $mid) {
            idx = mid
            break
        }
        else if (target < $mid) {
            right = mid - 1
        }
        else {
            left = mid + 1
        }
    }
    print idx
}
