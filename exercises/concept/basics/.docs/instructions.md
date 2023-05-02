# Instructions

Once upon a time, there was a bustling city called Cyberspace.
Cyberspace was a digital metropolis, with millions of inhabitants logging in and out every day.
To keep track of all these users, Cyberspace had a special file called /etc/passwd.

The /etc/passwd file was like a phonebook for the city.
It listed every user who had an account on the system, along with some important information about each user:

| n   | field |
| --- | --- |
| 1   | username |
| 2   | password ("x" indicates the actual password is stored elsewhere, for security) |
| 3   | UID, a unique numerical user ID |
| 4   | GID, a unique numerical group iD (typically the same as the UID) |
| 5   | user info (typically the user's full name, but can include other information) |
| 6   | home directory |
| 7   | login shell |

The fields are separated with a colon character.
This is a typical entry:

```none
glennj:x:1010:1010:Glenn Jackman:/home/glennj:/usr/local/bin/fish
```

The file was managed by a team of system administrators, who were responsible for creating new accounts, updating existing accounts, and removing old accounts.
The system administrators were the gatekeepers of Cyberspace, making sure that only authorized users could access the system.

One day, a new system administrator named Alex was hired to join the team.
Alex was excited to take on the job, and they quickly learned the ins and outs of the /etc/passwd file.
They learned how to add new users to the system, how to update user information, and how to remove old users.

As Alex was working on the /etc/passwd file, they noticed something strange.
Some users had strange or unusual home directories.
Some users had their home directories set to /dev/null, while others had their home directories set to strange paths that didn't exist.

Alex realized that these users were not real people, but rather fake accounts that had been created by hackers.
The hackers had found a way to exploit a vulnerability in the system, and had created these fake accounts to gain access to Cyberspace.

Alex knew that they needed to take action.
They used awk to analyze the /etc/passwd file, and wrote a script to identify all the fake accounts.
They then worked with the rest of the team to remove these accounts, and to patch the vulnerability that had allowed the hackers to create them in the first place.

Thanks to Alex's use of awk, the team was able to identify and remove the fake accounts, and to make Cyberspace a safer place for everyone.
The system administrators continued to manage the /etc/passwd file, keeping it up-to-date and secure, and ensuring that only authorized users could access the system.

Now, it's your turn to be a system administrator like Alex.

~~~~exercism/note
Here is some additional AWK syntax you'll need to solve this exercise.

* Boolean operators are similar to other languages:

    | operation | example            |
    | --------- | ------------------ |
    | AND       | `expr1 && expr2`   |
    | OR        | `expr1 \|\| expr2` |
    | NOT       | `! expr`           |

* Calling a function has familiar syntax:

    ```awk
    function greet(name) {
        print "Hello", name
    }
    BEGIN {
        greet("Mary")   # prints "Hello Mary"
    }
    ```

~~~~

## 1. List the usernames

Write an awk program to print the first colon-separated field for every line in the passwd file.

## 2. Print the line numbers

Write an awk command that prints the line number of each record in the input file.
Only print the line number, not any other information.

## 3. Print records with invalid home directories.

In Cyberspace, a "valid" home directory starts with `/home` or `/root`.
Print the records of the input file with **invalid** home directories.

## 4. Print the valid users who use bash

Print the records where the home directory is valid **and** the login shell is `bash`.
