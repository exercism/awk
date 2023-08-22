# placeholder

## General

- The `rand` [numeric function][rand-func] can generate random numbers.
- The `srand` [numeric function][srand-func] will be helpful to set the seed for `rand`.

## Maze generation

You can use any algorithm to generate a perfect maze. The [recursive backtracker][recursive-backtracker] is a good choice.

## Box drawing characters

| Character | Name                                  | Unicode |
|:---------:|:--------------------------------------|:--------|
|     ┌     | box drawings light down and right     |  U+250C |
|     ─     | box drawings light horizontal         |  U+2500 |
|     ┬     | box drawings light down and horizontal|  U+252C |
|     ┐     | box drawings light down and left      |  U+2510 |
|     │     | box drawings light vertical           |  U+2502 |
|     └     | box drawings light up and right       |  U+2514 |
|     ┴     | box drawings light up and horizontal  |  U+2534 |
|     ┘     | box drawings light up and left        |  U+2518 |
|     ├     | box drawings light vertical and right |  U+2520 |
|     ⇨     | rightwards white arrow                |  U+21E8 |


[rand-func]: https://www.gnu.org/software/gawk/manual/html_node/Numeric-Functions.html#index-rand_0028_0029-function
[srand-func]: https://www.gnu.org/software/gawk/manual/html_node/Numeric-Functions.html#index-srand_0028_0029-function
[recursive-backtracker]: https://en.wikipedia.org/wiki/Maze_generation_algorithm
