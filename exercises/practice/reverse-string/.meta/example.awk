BEGIN {
	FS = ""
}
{
	for (i = NF; i; i--)
		out = out $i
	print out
}
