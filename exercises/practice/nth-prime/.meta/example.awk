BEGIN {
    if (n < 1) {
        print("invalid input")
        exit(1)
    }
    if (n == 1) {
        print(2)
        exit(0)
    }
    count = 1
    candidate = 1
    while (count < n) {
        candidate += 2
        is_prime = 1
        for (i in primes) {
            if (candidate % i == 0) {
                is_prime = 0
                break
            }
        }
        if (is_prime) {
            primes[candidate] = 1
            count++
        }
    }
    print candidate
}

