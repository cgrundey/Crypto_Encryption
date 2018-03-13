#!/bin/bash

filename="$1"
result=`cat task4result.txt`
spaces="2020202020202020202020202020202020202020202020202020202020202020"

while read line
do
	line=`xxd -pu <<< $line`
	line="${line::-2}"
	line="$line$spaces"
	line="${line:0:32}"

	openssl enc -aes-128-cbc -d -in task4enc.txt -out task4dec.txt -K "$line" -iv 0000000000000000
	
	test=`cat task4dec.txt`
	if [ "$result" == "$test" ]
	then
		echo "This works!!!!"
		break
	fi

	if cmp -s "task4dec.txt" "task4result.txt" ; then
		echo "Got it\n Key used: $line\n"
		break
	fi

done < $filename

