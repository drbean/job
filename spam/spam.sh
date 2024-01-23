#!/usr/pkg/bin/bash

# #!/bin/sh

# subject="Academic paper editing service";
# body="edit_offer.txt"
threshold=35
ranger=20

declare -a subject_file body_file
declare -A count instance

# ./spam.sh < addresses

for i in subject body ; do
    declare -i n=0 count[$i]=0
    for j in $i/* ; do 
        (( ++count[$i] ))
        if [[ $i == subject ]] ; then
            subject_file[$((n++))]=$j
        else body_file[$((n++))]=$j
        fi
    done
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

        for c in subject body ; do
            i=$(( $RANDOM % ${count[$c]} ))
            if [[ $c == subject ]] ; then
                instance[$c]=${subject_file[$i]}
            else instance[$c]=${body_file[$i]}
            fi
        done

		read next < ./next
		n=$((++next))
		echo $n > ./next
		ext=$(sed -n "${n}p" /usr/share/dict/words | tr -d \\n)
		file=./sending.txt
		cat ${instance[body]} > $file
		echo "$(fortune $HOME/.mutt/fortunes)" >> $file
		last=${#addressarray[@]};
		addresspart=${addressarray[$((--last))]};
		if [[ $addresspart == *@hotmail.com ]] ; then
			echo -n $n: $display $addresspart |
				tee last_address unsent.ntu.txt
			printf ' \x1b[91mUNSENT\x1b[39;49m\n'
			continue
		fi 
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

echo -e '\a'
