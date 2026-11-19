
#!/usr/pkg/bin/bash

MEAT=./meat.yaml

sentence=(greeting question authority verb determiner page summary outro)
summary=(point separator item)
point=(roman alpha num) 

for c in ${component[*]} ; do
	declare -n script_nameref=$c
	if [[ -v $c ]] ; then
		if [[ $c == "strength" ]] ; then
			declare -n strength_nameref=$c
			declare -a order
			readarray -t order <<<$(../../yq ".strength | keys | shuffle | .[]" $MEAT)
			# echo order array: ${order[@]}
			declare -a strength
			for i in ${!order[@]} ; do
				# echo order: $i
				key=${order[$i]}
				key_n=$(../../yq ".strength.$key | length" $MEAT)
				key_index=$(( $RANDOM % $key_n ))
				strength_nameref=$key
				array_n=$(../../yq ".strength.$key | length" $MEAT)
				array_index=$(( $RANDOM % $array_n ))
				strength_nameref=$(../../yq ".strength.$strength_nameref.[$array_index]" $MEAT)
				# echo array index: $array_index, strength_nameref: $strength_nameref
				declare -n order_nameref=strength$((i+=1)); order_nameref=$strength_nameref
			done
			# echo strength1: $strength1, strength2: $strength2, strength3: $strength3, strength4: $strength4
		elif [[ $c == "point" ]] ; then
			key_n=$(../../yq ".point | keys | length" $MEAT)
			key_index=$(( $RANDOM % $key_n ))
			script_nameref=${script_nameref[$key_index]}
			# echo key index: $key_index, script_nameref: $script_nameref
			declare -a point
			readarray -t point <<<$(../../yq ".point.$script_nameref | .[]" $MEAT)
			for i in {0..3} ; do
				declare -n point_nameref=point$((i+1))
				point_nameref=${point[i]}
			done
			# echo point1: $point1, point2: $point2, point3: $point3, point4: $point4
			# echo point_array: ${point[@]}
		fi
	else 
		n=$(../../yq ".$c | length" $MEAT)
		r=$(( $RANDOM % $n ))
		script_nameref=$(../../yq ".$c.[$r]" $MEAT)
	fi
done

cat <<REPORT
$greeting!

$question

$authorization

$verb $determiner $page

$summary

$point1$separator $item0,
$point2$separator $item1,
$point3$separator $item2,
$point4$separator $item3.

$outro!
REPORT
