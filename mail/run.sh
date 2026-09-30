#!/usr/pkg/bin/bash

LAND_AREA=$1
LAND=${LAND_AREA:0:2}
AREA=${LAND_AREA#$LAND?}
declare -a BATCH

echo >> $HOME/job/$LAND/$AREA/done
if [[ $# -eq 2 ]]; then
	PACKET=$2
	BATCH=( $( eval echo {${PACKET}0..${PACKET}9} ) )
elif [[ $# -eq 3 ]]; then
	from=$2
	to=$3
	if [[ $(( $from )) -gt $(( $to )) ]]; then
		echo "{$from..$to} backwards!" >&2
		exit
	fi
	BATCH=( $( eval echo {$from..$to} ) )
else
	echo "$@: Too many/few args?" >&2
	exit 1
fi

echo "Batch ${BATCH%?}: $(date)">> $HOME/job/$LAND/$AREA/done
for i in ${BATCH[@]} ; do
	declare -i first last
	first=$(< $HOME/job/$LAND/$AREA/next)
	echo "$LAND/$AREA: $i of ${BATCH[0]} ~ ${BATCH[-1]}"
	if ! [[ -f $HOME/job/$LAND/$AREA/$i ]] ; then
		echo "No $i batch. Continuing with batch $((i+1))."
		continue
	fi
	$HOME/job/$LAND/$AREA/sendmail.sh < $HOME/job/$LAND/$AREA/$i
	last=$(< $HOME/job/$LAND/$AREA/next)
	echo $(date) $((++first))~$last $LAND $AREA $i |
		tee -a $HOME/job/$LAND/$AREA/done
	echo -e '\a'
done
