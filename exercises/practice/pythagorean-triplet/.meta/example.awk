# These variables are initialized on the command line (using '-v'):
# - sum

BEGIN {  
    OFS=","  

    limit = int(sum / 3)
    for (a = 3; a <= limit; ++a) {
        numerator = sum * sum - 2 * sum * a  
        denominator = 2 * (sum - a)
        if (numerator % denominator != 0) continue
        b = numerator / denominator
        if (a >= b) break
        c = sum - a - b  
        print a, b, c  
    }  
}
