# Installation

## What awk do I have?

The Exercism AWK track uses `gawk`, GNU's AWK.
You may already have it; to check, execute this command
```sh
awk --version
```

If that returns:

* something like `GNU Awk 5.1.0 ...`
    - You already have GNU awk and can carry on with the exercises.

* something like `awk version 20200816`
    - This is `nawk`, also known as BWK awk (after Brian Kernighan) or "one true awk".
    - This is what ships with MacOS and BSD systems.
    - Read below for installation instructions.

* the error `awk: not an option: --version`
    - You probably have `mawk`.
    - Confirm with: `awk -W version` which may return `mawk 1.3.4 20200120`.
    - mawk is a very good and fast awk implementation, but it doesn't have some of the gawk-specific features we'll use in the track.
    - Read below for installation instructions.

* the error `awk: unrecognized option: version` followed by `BusyBox v1.35.0 ...`
    - You might be using Alpine Linux.
    - Read below for installation instructions.

* a "command not found" error
    - Then either your PATH is messed up or you just don't have awk installed.
    - Read below for installation instructions.

### Linux

Varies with your distro's package manager. Typically:
```sh
apt install gawk
yum install gawk
apk add gawk
# and so on
```
You may need to use `sudo` to execute the appropriate command.

### MacOS

[Homebrew][brew] is your friend. Follow the link to install it and then run:
```sh
brew install gawk
```

### Windows

For [WSL][wsl], see instructions for Linux above.
For cygwin, install the `gawk` package.

### Compile from source

For the brave, instructions [available in the `gawk` manual][build].

## Need more help?

Places to look for help for AWK questions:

* [Stack Overflow `awk` tag][so].
* check the Resources section of the [Stack Overflow `awk` tag into page][so-info].
* raise an issue at the [exercism/awk][github] Github repository.
* IRC: `irc://irc.liberachat.net/#awk`, `irc://irc.liberachat.net/#exercism`
    * see [Libera.chat][libera] if you're unfamiliar with IRC.


[build]: https://www.gnu.org/software/gawk/manual/gawk.html#Installation
[wsl]: https://docs.microsoft.com/en-us/windows/wsl/about
[brew]: https://brew.sh/
[so]: https://stackoverflow.com/tags/awk
[so-info]: https://stackoverflow.com/tags/awk/info
[github]: https://github.com/exercism/awk
[libera]: https://libera.chat
