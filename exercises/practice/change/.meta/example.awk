#!/usr/bin/env gawk -f

@include "join"

BEGIN {
    # initialize `coins` as an array
    coins[0]
    delete coins[0]

    Sentinel = SUBSEP
}

NR == 1 { split($0, denominations) }
NR == 2 { amount = $1 }
END {
    if (amount < 0) {
        die("target can't be negative")
    }

    if (amount > 0) {
        # arrays C and S are populated in `change`
        change(denominations, amount, C, S)
    
        if (S[amount] == Sentinel)
            die("can't make target with given coins")

        make_change(S, denominations, amount, coins)
        print join(coins, 1, length(coins))
    }
}


############################################################
# Change making algorithm from
# http://www.ccs.neu.edu/home/jaa/CSG713.04F/Information/Handouts/dyn_prog.pdf

#   This function generates two arrays:
#
#   C = maps the minimum number of coins required to make change
#       for each n from 1 to amount.  It is returned but only
#       used internally in this application.
#
#   S = the _first_ coin used to make change for amount n
#       (actually stores the coin _index_ into the coins array)
function change(d, n, C, S,    p,min,coin,i) {
    C[0] = 0
    for (p = 1; p <= amount; p++) {
        min = PROCINFO["prec_max"]      # a "maxint" value
        coin = Sentinel
        for (i = 1; i <= length(d); i++) {
            if (d[i] <= p) {
                if (1 + C[p - d[i]] < min) {
                    min = 1 + C[p - d[i]]
                    coin = i
                }
            }
        }
        C[p] = min
        S[p] = coin
    }
}

function make_change(S, d, n, coins) {
    while (n > 0) {
        coins[length(coins) + 1] = d[S[n]]
        n -= d[S[n]]
    }
}
############################################################

function die(msg) {
    print msg > "/dev/stderr"
    exit 1
}
