#!/usr/bin/env gawk -f

BEGIN {name = "you"}
NF    {name = $0}
END   {print "One for " name ", one for me."}
