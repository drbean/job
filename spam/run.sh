#!/usr/pkg/bin/bash

AREA=$1
declare -a BLOCK

echo >> $HOME/job/$AREA/done
if [[ $# -eq 2 ]]; then
	BATCH=$2
	BLOCK=( $( eval echo {${BATCH}0..${BATCH}9} ) )
elif [[ $# -eq 3 ]]; then
	from=$2
	to=$3
	if [[ $(( $from )) -gt $(( $to )) ]]; then
		echo "{$from..$to} backwards!" >&2
		exit
	fi
	BLOCK=( $( eval echo {$from..$to} ) )
else
	echo "$@: Too many/few args?" >&2
	exit 1
fi
for i in ${BLOCK[@]} ; do
	declare -i first last
	first=$(< $HOME/job/$AREA/next)
	echo "$AREA: $i of ${BLOCK[0]} ~ ${BLOCK[-1]}"
	$HOME/job/$AREA/spam.sh < $HOME/job/$AREA/$i
	last=$(< $HOME/job/$AREA/next)
	echo $(date) $((++first))~$last $AREA.$i |
		tee -a $HOME/job/$AREA/done
done
