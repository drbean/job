#!/usr/pkg/bin/bash

echo >> $HOME/job/done
x=$(eval echo {$1..$2})
for i in ${x[@]} ; do
	declare -i first last
	first=$(< next)
	echo pusan: $i of $x
	$HOME/job/spam.sh < $HOME/job/pusan.$i
	last=$(< next)
	echo $(date) $((++first))~$last pusan.$i >> $HOME/job/done
done

