#!/usr/pkg/bin/bash

x=$(seq $1 $2)
for i in ${x[@]} ; do
	echo "taibei: $i/${x[-1]}"
	$HOME/job/spam.sh < taibei$i
	echo taibei$i >> done_taibei
done

