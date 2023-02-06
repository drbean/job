#!/usr/pkg/bin/bash

area=$1

echo >> $HOME/job/done
x=$(eval echo {$2..$3})
for i in ${x[@]} ; do
	declare -i first last
	first=$(< next)
	echo $area: $i of $x
	$HOME/job/spam.sh < $HOME/job/$area.$i
	last=$(< next)
	echo $(date) $((++first))~$last pusan.$i >> $HOME/job/done
done

