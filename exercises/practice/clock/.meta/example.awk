BEGIN {
    MinutesInHour = 60
    MinutesInDay = MinutesInHour * 24
}
NF == 2 {
    printClock(clock($1, $2))
}
$3 == "add" {
    printClock(clock($1, $2 + $4))
}
$3 == "subtract" {
    printClock(clock($1, $2 - $4))
}
$3 == "equal" {
    print clock($1, $2) == clock($4, $5) ? "true" : "false"
}
function clock(hours, minutes) {
    return ((hours * MinutesInHour + minutes) % MinutesInDay + MinutesInDay) % MinutesInDay
}
function printClock(minutes) {
    printf "%02d:%02d\n", int(minutes / MinutesInHour), minutes % MinutesInHour
}