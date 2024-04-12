BEGIN {
    RS = " "
}
isGameOver() {
    die("Cannot roll after game is over")
}
{
    ++Throw
    Roll = $1
}
!Round || Throw - Frame[Round] == 2 || KnockedDownPins[Frame[Round]] == 10 {
    Frame[++Round] = Throw
    Pins = 10
}
Roll < 0 {
    die("Negative roll is invalid")
}
Roll > Pins {
    die("Pin count exceeds pins on the lane")
}
{
    KnockedDownPins[Throw] = Roll
    Pins -= Roll
}

ENDFILE {
    if (!isGameOver()) {
        die("Score cannot be taken until the end of the game")
    }
    for (i = 1; i <= 10; ++i) {
        Throw = Frame[i]
        score = KnockedDownPins[Throw] + KnockedDownPins[++Throw]
        score += score < 10 ? 0 : KnockedDownPins[++Throw]
        total += score
    }
    print total
}

function isGameOver() {
    return Round == 10 && Throw - Frame[Round] == 1 && KnockedDownPins[Throw - 1] + KnockedDownPins[Throw] < 10 ||
        Round == 11 && KnockedDownPins[Throw - 1] < 10 || Round == 12
}
function die(message) {print message > "/dev/stderr"; exit 1}
