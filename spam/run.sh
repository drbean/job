#!/usr/pkg/bin/bash

echo >> $HOME/job/done
x=$(eval echo {$1..$2})
for i in ${x[@]} ; do
	echo north: $i of $x
	$HOME/job/spam.sh < $HOME/job/north.$i
	echo $(date) north.$i >> $HOME/job/done
done

