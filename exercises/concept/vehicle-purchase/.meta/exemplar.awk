$1 == "needs_license" && $2 ~ /car|truck/ {print "true"}

$1 == "resell_price" && $3 < 3              {print $2 * 0.8}
$1 == "resell_price" && 3 <= $3 && $3 <= 10 {print $2 * 0.7}
$1 == "resell_price" && $3 > 10             {print $2 * 0.5}
