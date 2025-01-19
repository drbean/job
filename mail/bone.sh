

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
			declare -n strength_nameref=$c
			key_n=$(yq ".strength | keys | length" $MEAT)
			key_index=$(( $RANDOM % $key_n ))
			script_nameref=${script_nameref[$key_index]}
			echo key index: $key_index, script_nameref: $script_nameref
			array_n=$(yq ".strength.$script_nameref | length" $MEAT)
			array_index=$(( $RANDOM % $array_n ))
			strength_nameref=$(yq ".strength.$strength_nameref.[$array_index]" $MEAT)
			echo array index: $array_index, strength_nameref: $strength_nameref
		elif [[ $c == "point" ]] ; then
			# for i in {0..3} ; do
			# 	declare -n point${i}_nameref=$point$i
			# done
			key_n=$(yq ".point | keys | length" $MEAT)
			key_index=$(( $RANDOM % $key_n ))
			script_nameref=${script_nameref[$key_index]}
			echo key index: $key_index, script_nameref: $script_nameref
			declare -a point
			readarray -t point <<<$(yq ".point.$script_nameref" $MEAT)
				point1=${point[0]#- }
				point2=${point[1]#- }
				point3=${point[2]#- }
				point4=${point[3]#- }
				echo point1: $point1, point2: $point2, point3: $point3, point4: $point4
			echo point_array: ${point[@]}
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

$point1$separator $strength, $point2$separator $strength, $point3$separator $strength, $point4$separator $strength
OFFER
