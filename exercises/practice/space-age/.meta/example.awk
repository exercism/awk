BEGIN {
    seconds_per_earth_year = 31557600

    earth_ratio["Mercury"] = 0.2408467
    earth_ratio["Venus"] = 0.61519726
    earth_ratio["Earth"] = 1.0
    earth_ratio["Mars"] = 1.8808158
    earth_ratio["Jupiter"] = 11.862615
    earth_ratio["Saturn"] = 29.447498
    earth_ratio["Uranus"] = 84.016846
    earth_ratio["Neptune"] = 164.79132
}

{
    if (earth_ratio[$1]) {
        printf("%.2f\n", ($2 / seconds_per_earth_year) / earth_ratio[$1])
    } else {
        print($1 " is not a planet")
        exit(1)
    }
}
