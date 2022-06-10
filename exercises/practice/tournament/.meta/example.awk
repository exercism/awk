#!/usr/bin/env gawk -f

function add_team(team) {
    if (! (team in teams) )
        teams[team] = 0
    has_teams = 1
}

function win(team) {
    add_team(team)
    wins[team]++
}

function loss(team) {
    add_team(team)
    losses[team]++
}

function draw(team) {
    add_team(team)
    draws[team]++
}

function played(team) {
    return wins[team] + losses[team] + draws[team]
}

function points(team) {
    return 3 * wins[team] + draws[team]
}

function sort_order(i1, v1, i2, v2) {
    if (points(i1) != points(i2))
        return points(i2) - points(i1)
    return i2 < i1
}


BEGIN {
    FS = ";"
    has_teams = 0
}

length {
    switch($3) {
    case "win":
        win($1)
        loss($2)
        break
    case "loss":
        loss($1)
        win($2)
        break
    case "draw":
        draw($1)
        draw($2)
        break
    default:
        exit(1)
    }
}

END {
    print "Team                           | MP |  W |  D |  L |  P"
    PROCINFO["sorted_in"] = "sort_order"
    if (has_teams)
        for (team in teams)
            printf "%-30s | %2s | %2s | %2s | %2s | %2s\n", team, played(team), wins[team] + 0, draws[team] + 0, losses[team] + 0, points(team)

}
