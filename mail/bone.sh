

#!/usr/pkg/bin/bash

MEAT=$HOME/edit/email/edit_offer/skeleton.yaml
declare -A N PICK language care understanding experience roman alpha num

component=(greeting intro promotion strength point separator weakness pitch toeflic outro)
strength=(language care understanding experience) 
point=(roman alpha num) 

for c in ${component[*]} ; do
	N[$c]=$(yq ".$c | length" $MEAT)
	echo .$c length: ${N[$c]}
done

for s in ${strength[*]} ; do
	N[$s]=$(yq ".strength.$s | length" $MEAT) 
	echo .strength.$s length: ${N[$s]}
done

for p in ${component[*]} ${strength[*]} ; do
	PICK[$p]=$(( $RANDOM % ${N[$p]} ))
	echo $p pick: ${PICK[$p]} / ${N[$p]}
done

for c in ${component[*]} ; do
	declare -n script_nameref=$c
	if [[ -v $c ]] ; then
		if [[ $c == "strength" ]] ; then
			declare -n yq_nameref=$c
			declare -a category
			declare -i i=0
			while read p ; do
				category[$i]=$p
				echo ${category[$i]}
				i+=1
			done <<<$(yq ".strength | keys.[]" $MEAT)
			for s in ${category[*]} ; do
				n=$(yq ".$c.$s | length" $MEAT)
				r=$(( $RANDOM % $n ))
				echo $s: $r
				script_nameref=$(yq ".$c.$s.$r" $MEAT)
			done
		fi
	else 
		n=$(yq ".$c | length" $MEAT)
		r=$(( $RANDOM % $n ))
		script_nameref=$(yq ".$c.[$r]" $MEAT)
	fi
done

cat <<OFFER
$greeting!

$intro.

$promotion:

$(yq ".point.roman.[0]" $MEAT)$(yq ".separator.[${PICK[separator]}]" $MEAT)
$strength
OFFER
