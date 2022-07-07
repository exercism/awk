BEGIN {
    Gigasecond = 1000000000
}
    
/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/ {
    # add the time and carry on
    $1 = $1 "T00:00:00"
}

/^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}$/ {
    # https://www.gnu.org/software/gawk/manual/html_node/Time-Functions.html
    datespec = gensub(/[-T:]/, " ", "g")
    epoch = mktime(datespec, 1)
    if (epoch != -1)
        print strftime("%FT%T", Gigasecond + epoch, 1)
}
