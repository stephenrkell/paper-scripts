#!/bin/bash

# lpr-parseopts.cl
# When run with command-line options to lpr.cl, this script
# prints out a bunch of environment variable definitions
# corresponding to the command-line options.

test -x `which lpr.cl` || (echo "No lpr.cl command found in PATH!" 1>&2; false) || exit 1

# we understand output from 
# lpr.cl -debug 
# in the following forms:
# blah is foo
# blah = foo
# blah true
# blah type foo
# file name [0-9]+ is blah

expr1='^(LPR)?([^ ]*) *is *(.*[^ ]) *$'
expr2='^(LPR)?([^ ]*) *= *(.*[^ ]) *$'
expr3='^(LPR)?([^ ]*) *(true) *$'
expr4='^(LPR)?([^ ]*) *type *(.*[^ ]) *$'
expr5='^(LPR)?file name ([0-9]+) is *(.*)$'

lpr.cl -noprint -debug "$@" | egrep "$expr1|$expr2|$expr3|$expr4|$expr5" \
     | sed -r \
"/$expr1/ { s/$expr1/LPR_OPT_\2=\"\3\"/ "$'\n'"p"$'\n'"d }
/$expr2/ { s/$expr2/LPR_OPT_\2=\"\3\"/ "$'\n'"p"$'\n'"d }
/$expr3/ { s/$expr3/LPR_OPT_\2=\"\3\"/ "$'\n'"p"$'\n'"d }
/$expr4/ { s/$expr4/LPR_OPT_\2=\"\3\"/ "$'\n'"p"$'\n'"d }
/$expr5/ { s/$expr5/LPR_OPT_filename\2=\"\3\"/ "$'\n'"p"$'\n'"d }"
# the convolutedness of the above makes sure to apply at most one substitution per line
