

#!/usr/pkg/bin/bash

MEAT=$HOME/edit/email/edit_offer/meat.yaml
declare -A N PICK language care understanding experience roman alpha num

component=(greeting intro promotion strength point separator weakness pitch toeflic outro)
strength=(language care understanding experience) 
point=(roman alpha num) 

for c in ${component[*]} ; do
	declare -n script_nameref=$c
	if [[ -v $c ]] ; then
		if [[ $c == "strength" ]] ; then
			declare -n yq_nameref=$c
			# declare -a category
			# declare -i i=0
			# while read p ; do
			# 	category[$i]=$p
			# 	echo ${category[$i]}
			# 	i+=1
			# done <<<$(yq ".strength | keys.[]" $MEAT)
			key_n=$(yq ".strength | keys | length" $MEAT)
			key_index=$(( $RANDOM % $key_n ))
			yq_nameref=${yq_nameref[$key_index]}
			echo key index: $key_index, yq_nameref: $yq_nameref
			array_n=$(yq ".strength.$yq_nameref | length" $MEAT)
			array_index=$(( $RANDOM % $array_n ))
			script_nameref=$(yq ".strength.$yq_nameref.[$array_index]" $MEAT)
			echo array index: $array_index, script_nameref: $script_nameref
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

$(yq ".point.roman.[0] + .separator.[0]" $MEAT) $strength
OFFER
