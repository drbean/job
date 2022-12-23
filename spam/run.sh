#!/usr/pkg/bin/bash

x=$(eval echo {$1..$2})
for i in ${x[@]} ; do
	echo -e "\n" >> $HOME/job/done
	echo north: $i of $x
	$HOME/job/spam.sh < $HOME/job/north.$i
	echo $(date) north.$i >> $HOME/job/done
done

