#!/usr/pkg/bin/bash

# #!/bin/sh

# subject="Academic paper editing service";
# body="edit_offer.txt"
threshold=33
ranger=20

declare -a subject_file body_file
declare -A count instance

# ./sendmail.sh < addresses

declare -i n=0 count[subject]=0
for f in ./subject/* ; do 
	(( ++count[subject] ))
	subject_file[$((n++))]=$f
done

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

date

while read -a addressarray;
do
	if [[ ! ( ${addressarray[0]:0:1} == '#' || ${#addressarray[*]} -eq 0 ) ]] ;
	then

		i=$(( $RANDOM % ${count[subject]} ))
		instance[subject]=${subject_file[$i]}
		instance[body]=$(./bone.sh)

		read next < ./next
		n=$((++next))
		echo $n > ./next
		ext=$(sed -n "${n}p" /usr/share/dict/words | tr -d \\n)
		file=./sending.txt
		echo "${instance[body]}" > $file
		echo "$(fortune $HOME/.mutt/fortunes | ~/.mutt/signature.sh)" \
			>> $file
		last=${#addressarray[@]};
		addresspart=${addressarray[$((--last))]};
		unset addressarray[$last];
		display=${addressarray[*]};
		sed -e "1i\\
To: $display $addresspart
		" -e "1i\\
From: Greg Matheson <drbean+$ext@freeshell.org>
		" -e "1i\\
Subject: $(cat ${instance[subject]})
		" -e "1i\\
Content-Type: text/plain; charset=\"UTF-8\"
		" -e "1i\\
Reply-To: drbean+$n@freeshell.org
		" < $file | /usr/sbin/sendmail -oem -oi $addresspart;

		error=$?;
		echo -n $n: $display $addresspart | tee last_address;
		if [[ $error == 0 ]]; then printf ' OK\n'; else printf ' \x1b[91mNOK\x1b[39;49m\n'; fi;
		sleep $(($threshold + $RANDOM % $ranger));
	fi;
done
