{
    print $1 ", you are the " $2 suffix($2) " customer we serve today. Thank you!"
}

function suffix(number) {
    if (number ~ /(1[123]|[^123])$/) return "th"
    else if (number ~ /1$/) return "st"
    else if (number ~ /2$/) return "nd"
    else return "rd"
}
