BEGIN {
    MaxDigit = 9
}
{
    cageSum = $1
    cageSize = $2
    for (i = 3; i <= NF; ++i) {
        ExcludedDigits[$i] = 1
    }
    NF = 0
    generate_recursive(1, cageSum, cageSize)
}

function generate_recursive(currentStartDigit, remainingSum, remainingSize,   maxPossibleFirstDigit, digit) {
    NF++
    if (remainingSize == 1) {
        if (currentStartDigit <= remainingSum && remainingSum <= MaxDigit && !(remainingSum in ExcludedDigits)) {
            $NF = remainingSum
            print
        }
    } else {
        maxPossibleFirstDigit = MaxDigit - remainingSize + 1
        for (digit = currentStartDigit; digit <= maxPossibleFirstDigit; ++digit) {
            if (digit in ExcludedDigits)
                continue
            $NF = digit
            generate_recursive(digit + 1, remainingSum - digit, remainingSize - 1)
        }
    }
    NF--
}
