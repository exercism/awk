# Exercism AWK track

AWK is a fun little language, widely used for text manipulation.
One can express a lot of functionality in very few lines of code.

[![awk intro comic][b0rk-image]][b0rk-tweet]

[b0rk-tweet]: https://twitter.com/b0rk/status/1000604334026055681?s=20&t=6-hkY0dxnID7y05XvJkEsg
[b0rk-image]: https://pbs.twimg.com/media/DeLcVfSWAAAw6OZ?format=jpg&name=small

## Spelling

The language is AWK.  
The interpreter is `awk` or `gawk`.

## Language variant

We'll use [GNU awk][gawk] in this track.
It may not be the default awk in any platform, but it's in widespread use and has lots of builtin goodies.
Other variants:
* mawk
* nawk
* ...

## Testing framework

Since I (@glennj) have spent a lot of time building up the bash track, I'll steal some of the learnings from it.
Testing will be done with [`bats-core`][bats]

## Support

[![Join the chat at https://gitter.im/exercism/awk](https://badges.gitter.im/exercism/awk.svg)](https://gitter.im/exercism/awk?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Eventually, a `#track-awk` Slack channel.

## TODO

In no particular order

* awk-test-runner, largely built on bash's
    * pick a docker image for gawk v5
    * also needs bash v??
* Documentation
    * exercises/shared/.docs/help.md
    * exercises/practice/<slug>/.meta/.docs/instructions.append.md
        * hello-world
* concepts
* admin requests
    * create exercism repos
    * awk icon

[gawk]: https://www.gnu.org/software/gawk/ 
[bats]: https://bats-core.readthedocs.io/en/stable/ 
