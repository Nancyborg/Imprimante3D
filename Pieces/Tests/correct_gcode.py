#!/bin/zsh
#

prec=""
while read line
do
	if [[ $(echo ${line} | grep X) ]]
	then
		x=$(echo ${line} | cut -d ' ' -f 2)
		x=${x#X}
		
		if [[ ${prec} != "" ]]
		then
			if [[ ${x} -lt ${prec} ]]
			then
				new=$((${x} - 1))
#				new=$(echo ${new} | grep -o "[0-9]\{1,4\}\.[0-9]\{4\}")
				nline=$(echo ${line} | sed "s/X${x}/X${new}/")
			else
				nline=${line}
			fi
		else
			nline=${line}
		fi
		prec=${x}
		echo ${nline}
	else
		echo ${line}
	fi
done < $1
