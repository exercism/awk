function pigify(word,    pig, m) {
    if (word ~ /^([aeiou]|xr|yt)/)                 # apple, xray, ytria
        pig = word
    else if (match(word, /^(.?qu)(.*)/, m))        # quit, square
        pig = m[2] m[1]
    else if (match(word, /^([^aeiou]+)(y.*)/, m))  # rhythm, my
        pig = m[2] m[1]
    else if (match(word, /^([^aeiou]+)(.*)/, m))   # strength, cat
        pig = m[2] m[1]
    else
        pig = word

    return pig "ay"
}

{
    for (i = 1; i <= NF; i++)
        $i = pigify($i)
    print
}
