#!/usr/pkg/bin/bash

x=$(eval echo {$1..$2})
for i in ${x[@]} ; do
	echo taibei: $i of $x
	$HOME/job/spam.sh < $HOME/job/taibei$i
	echo taibei$i >> $HOME/job/done_taibei
done

