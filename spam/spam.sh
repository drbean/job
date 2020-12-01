#!/usr/bin/bash

# #!/bin/sh

subject="NUU TOEIC Speaking course online";

# ./spam.sh < addresses

#for address in \
#	"Greg_Matheson <gregoer@healthy..chinmin.tw>" \
#	"Greg Matheson <greg@healthy.chinmin.edu.tw>" \
#	"Greg J Matheson <greg@healthy.chinmin.edu.tw>" \
#	"Greg John Matheson <greg@healthy.chinmin.edu.tw>" \
#	;
#do
#	n=0;
#	for part in $address;
#	do
#		addressarray[$((n++))]=$part;
#	done;

n=2341
while read -a addressarray;
do
	if [[ ! ( ${addressarray[0]:0:1} == '#' || ${#addressarray[*]} -eq 0 ) ]] ;
	then
		n=$((++n))
		file=$HOME/job/sending.txt
		cat $HOME/job/toeic.txt > $file
		echo "$(fortune $HOME/.mutt/fortunes)" >> $file
		last=${#addressarray[@]};
		addresspart=${addressarray[$((--last))]};
		unset addressarray[$last];
		display=${addressarray[*]};
		sed -e "1i\\
To: $display $addresspart
		" -e "1i\\
From: Greg Matheson <drbean+$n@freeshell.org>
		" -e "1i\\
Subject: $subject
		" -e "1i\\
Content-Type: text/plain; charset=\"UTF-8\"
		" -e "1i\\
Reply-To: drbean+$n@freeshell.org
		" < $file | /usr/sbin/sendmail -oem -oi $addresspart;

		error=$?;
		echo -n $display $addresspart;
		if [[ $error == 0 ]]; then printf ' OK\n'; else printf ' \x1b[91mNOK\x1b[39;49m\n'; fi;
		sleep $((35 + $RANDOM % 20));
	fi;
done
