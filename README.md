# Exercism AWK track

AWK is a fun little language, widely used for text manipulation.
One can express a lot of functionality in very few lines of code.

[![awk intro comic][b0rk-image]][b0rk-tweet]

## Spelling

The language is AWK.  
The interpreter is `awk` or `gawk`.

## Language variant

We'll use [GNU awk][gawk] in this track.
It may not be the default awk in any platform, but it's in widespread use and has lots of builtin goodies.

## Testing framework

Since I (@glennj) have spent a lot of time building up the bash track, I'll steal some of the learnings from it.

* Testing will be done with [`bats-core`][bats]
* [awk-test-runner][test-runner] was taken from the bash-test-runner.

## Support

Get help on the [Exercism forum][forum].

[forum]: https://forum.exercism.org/
[b0rk-tweet]: https://twitter.com/b0rk/status/1000604334026055681?s=20&t=6-hkY0dxnID7y05XvJkEsg
[b0rk-image]: https://pbs.twimg.com/media/DeLcVfSWAAAw6OZ?format=jpg&name=small
[gawk]: https://www.gnu.org/software/gawk/ 
[bats]: https://bats-core.readthedocs.io/en/stable/ 
[test-runner]: https://github.com/exercism/awk-test-runner
