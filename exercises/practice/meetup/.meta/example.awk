
BEGIN {
    FS = ","
    # initialize arrays
    dates["Sunday"][0]    = 0; count["Sunday"]    = 0
    dates["Monday"][0]    = 0; count["Monday"]    = 0
    dates["Tuesday"][0]   = 0; count["Tuesday"]   = 0
    dates["Wednesday"][0] = 0; count["Wednesday"] = 0
    dates["Thursday"][0]  = 0; count["Thursday"]  = 0
    dates["Friday"][0]    = 0; count["Friday"]    = 0
    dates["Saturday"][0]  = 0; count["Saturday"]  = 0
}

{
    timespec = $1 " " $2 " %d 12 0 0"
    for (date = 1; date <= 31; date++) {
        time = mktime(sprintf(timespec, date))
        if ($2 != strftime("%-m", time)) break     # for months with < 31 days
        day = strftime("%A", time)
        dates[day][++count[day]] = date
    }

    if      ($3 == "first")  date = dates[$4][1]
    else if ($3 == "second") date = dates[$4][2]
    else if ($3 == "third")  date = dates[$4][3]
    else if ($3 == "fourth") date = dates[$4][4]
    else if ($3 == "last")   date = dates[$4][count[$4]]
    else if ($3 == "teenth") 
        date = (dates[$4][2] >= 13) ? dates[$4][2] : dates[$4][3]

    print strftime("%F", mktime(sprintf(timespec, date)))
}
