function die(msg) {
    print msg
    exit 1
}

# remove valid non-digits
{ gsub(/[[:blank:]()+.-]/, "", $0) }

length < 10 { die("must not be fewer than 10 digits") }
length > 11 { die("must not be greater than 11 digits") }
length > 10 { if (!sub(/^1/, "")) die("11 digits must start with 1") }

/[[:alpha:]]/  { die("letters not permitted") }
/[^[:digit:]]/ { die("punctuations not permitted") }
/^0/           { die("area code cannot start with zero") }
/^1/           { die("area code cannot start with one") }
/^...0/        { die("exchange code cannot start with zero") }
/^...1/        { die("exchange code cannot start with one") }

{ print }
