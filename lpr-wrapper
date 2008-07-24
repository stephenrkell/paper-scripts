#!/bin/bash

# lpr-wrapper: calls the user's preferred lpr, building the
# argument string from environment variables

opts=$( printenv | grep '^LPR_OPT_' )
space=${IFS:- }
while read opt; do
	opt_key=$( echo "$opt" | sed 's/=.*//' )
	opt_val=$( echo "$opt" | sed 's/.*=//' )
	case "$opt_key" in
		LPR_OPT_p) argstring="${argstring}${space}-p ${opt_val}" ;;
		LPR_OPT_staple) argstring="${argstring}${space}-staple" ;;
		LPR_OPT_printer) argstring="${argstring}${space}-P ${opt_val}" ;;
		LPR_OPT_filename*) #filenames="$filenames"$'\n'"$opt_val" ;;
			;;
		LPR_OPT_fullcmd) ;; # ignore this
		*)	echo "Unrecognised option key: $opt_key" 1>&2 ;;
	esac
done <<<"$opts"

#echo "$filenames" | echo xargs lpr ${argstring} 
lpr ${argstring} "$@"
