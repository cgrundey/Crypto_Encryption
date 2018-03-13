#!/bin/bash

plain=$(cat task4plaintext.txt)
echo $plain
while read line; do
	echo $line
	hexval=$(xxd -pu <<< "$line")
	echo "hex: $hexval"
	key="${hexval::-2}"
	spacemask="2020202020202020202020202020202020202020202020202020202020202020"
	inkey="$key$spacemask"
	mykey="${inkey:0:32}"
	openssl enc -aes-128-cbc -d -in test.txt -out task4dec.txt -K "$mykey" -iv 0000000000000000
	dec=$(cat task4dec.txt)
	echo $mykey
	echo "$dec"
	echo "$plain"
	if [ "$plain" == "$dec" ]; then
		echo "Key FOUND: $line"
		break
	fi
done < words.txt
