#!/bin/bash

# first argument is list of words (i.e. words.txt)
# sample usage: ./task4.sh words.txt
# Typical execution time: ~3.5 minutes

filename="$1"
encFile="task4enc.txt"
decFile="task4dec.txt"
answer="task4plaintext.txt"
result=`cat $answer`
spaces="2020202020202020202020202020202020202020202020202020202020202020"

echo "Cracking the code......."

# Looping through each word in dictionary
while read line
do
    thekey=$line
    if [ ${#thekey} -gt 16 ]; then
      continue
    fi
    # Formatting key for openssl input
    # Hex conversion
    line=`xxd -pu <<< $line`
    line="${line::${#line}-2}"
    # Add spaces to get correct size key
    line="$line${spaces::32-${#line}}"

    # Decryption command
    openssl enc -aes-128-cbc -d -in $encFile -out $decFile -K "$line" -iv 0000000000000000 &>/dev/null

    # Test if decryption was successful
    if cmp -s $decFile $answer
    then
        echo "FOUND KEY -> $thekey"
        break
    fi

done < $filename
