

#!/usr/pkg/bin/bash

SKELETON=$HOME/edit/email/edit_offer/skeleton.yaml
declare -A N PICK language care understanding experience roman alpha num

component=(greeting intro promotion strength point separator weakness pitch toeflic outro)
strength=(language care understanding experience) 
point=(roman alpha num) 

for c in ${component[*]} ; do
	N[$c]=$(yq ".$c | length" $SKELETON)
	echo .$c length: ${N[$c]}
done

for s in ${strength[*]} ; do
	N[$s]=$(yq ".strength.$s | length" $SKELETON) 
	echo .strength.$s length: ${N[$s]}
done

for p in ${component[*]} ${strength[*]} ; do
	PICK[$p]=$(( $RANDOM % ${N[$p]} ))
	echo $p pick: ${PICK[$p]} / ${N[$p]}
done

for c in ${component[*]} ; do
	if [[ -v $c ]] ; then
		declare -n yq_nameref=$c
		for s in ${yq_nameref[*]} ; do
			echo $c.$s: $(yq ".$c.$s.[${PICK[$s]}]" $SKELETON)
		done
		else echo $c: $(yq ".$c.[${PICK[$c]}]" $SKELETON)
	fi
done

cat <<OFFER
$(yq ".greeting.[${PICK[greeting]}]" $SKELETON)!

$(yq ".intro.[${PICK[intro]}]" $SKELETON).

$(yq ".promotion.[${PICK[promotion]}]" $SKELETON):

$(yq ".point.roman.[0]" $SKELETON)$(yq ".separator.[${PICK[separator]}]" $SKELETON)
OFFER
