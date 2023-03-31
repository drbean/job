#!/usr/pkg/bin/bash

area=$1

echo >> $HOME/job/$area/done
x=$(eval echo {$2..$3})
for i in ${x[@]} ; do
	declare -i first last
	first=$(< $HOME/job/$area/next)
	echo $area: $i of $x
	$HOME/job/spam.sh < $HOME/job/$area/$i
	last=$(< $HOME/job/$area/next)
	echo $(date) $((++first))~$last $area.$i |
		tee -a $HOME/job/$area/done
done

