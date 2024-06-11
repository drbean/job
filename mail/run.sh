#!/usr/pkg/bin/bash

LAND_AREA=$1
LAND=${LAND_AREA:0:2}
AREA=${LAND_AREA#$LAND?}
declare -a BLOCK

echo >> $HOME/job/$LAND/$AREA/done
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
	first=$(< $HOME/job/$LAND/$AREA/next)
	echo "$LAND/$AREA: $i of ${BLOCK[0]} ~ ${BLOCK[-1]}"
	if ! [[ -f $HOME/job/$LAND/$AREA/$i ]] ; then
		echo "No $i block. Continuing with block $((i+1))."
		continue
	fi
	$HOME/job/$LAND/$AREA/spam.sh < $HOME/job/$LAND/$AREA/$i
	last=$(< $HOME/job/$LAND/$AREA/next)
	echo $(date) $((++first))~$last $LAND $AREA $i |
		tee -a $HOME/job/$LAND/$AREA/done
done
