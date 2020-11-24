#!/usr/bin/bash

# #!/bin/sh

subject="Greg Matheson: Job application";

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

while read -a addressarray;
do
	if [[ ! ( ${addressarray[0]:0:1} == '#' || ${#addressarray[*]} -eq 0 ) ]] ;
	then
		last=${#addressarray[@]};
		addresspart=${addressarray[$((--last))]};
		unset addressarray[$last];
		display=${addressarray[*]};
		sed -e "1i\\
To: $display $addresspart
		" -e "1i\\
From: Greg Matheson <drbean@freeshell.org>
		" -e "1i\\
Subject: $subject
		" -e "1i\\
Content-Type: text/plain; charset=\"UTF-8\"
		" -e "1i\\
Reply-To: drbean@freeshell.org
		" < $HOME/job/2020-12_college.txt | /usr/sbin/sendmail -oem -oi $addresspart;

		error=$?;
		echo -n $display $addresspart;
		if [[ $error == 0 ]]; then printf ' OK\n'; else printf ' \x1b[91mNOK\x1b[39;49m\n'; fi;
		sleep $((35 + $RANDOM % 20));
	fi;
done
