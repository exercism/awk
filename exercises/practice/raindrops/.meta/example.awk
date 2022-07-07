# These variables are initialized on the command line (using '-v'):
# - num

BEGIN {
    result = ""
    if (num % 3 == 0) result = result "Pling"
    if (num % 5 == 0) result = result "Plang"
    if (num % 7 == 0) result = result "Plong"
    print result ? result : num
}
