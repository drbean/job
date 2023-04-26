#!/usr/pkg/bin/bash

area=$1

echo >> $HOME/job/$area/done
if [[ $# -eq 2 ]]; then
	x=$(eval echo {0${2}0..0${2}9})
elif [[ $# -eq 3 ]]; then
	from=$2
	to=$3
	if [[ $(( 10#$from )) -gt $(( 10#$to )) ]]; then
		echo "{$from..$to} backwards!" >&2
		exit
	fi
	x=$(eval echo {$from..$to})
else
	echo "$@: Too many/few args?" >&2
	exit
fi
for i in ${x[@]} ; do
	declare -i first last
	first=$(< $HOME/job/$area/next)
	echo $area: $i of $x
	$HOME/job/$area/spam.sh < $HOME/job/$area/$i
	last=$(< $HOME/job/$area/next)
	echo $(date) $((++first))~$last $area.$i |
		tee -a $HOME/job/$area/done
done
