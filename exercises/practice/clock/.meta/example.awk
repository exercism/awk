BEGIN {
    MinutesInHour = 60
    MinutesInDay = MinutesInHour * 24
}
$1 == "create" {
    printClock(clock($2, $3))
}
$1 == "add" {
    printClock(clock($2, $3 + $4))
}
$1 == "subtract" {
    printClock(clock($2, $3 - $4))
}
$1 == "equal" {
    print clock($2, $3) == clock($4, $5) ? "true" : "false"
}
function clock(hours, minutes) {
    return ((hours * MinutesInHour + minutes) % MinutesInDay + MinutesInDay) % MinutesInDay
}
function printClock(minutes) {
    printf "%02d:%02d\n", int(minutes / MinutesInHour), minutes % MinutesInHour
}
