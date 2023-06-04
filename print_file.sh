#!/bin/bash

target=$1
find $HOME/ -name $target -type f -exec cat {} 2>fileprint.error \; > tmp873245.txt
if [[ -s tmp873245.txt ]]
then
    printf "%s\n" "$(cat tmp873245.txt)" > /dev/stdout #output
else
    printf "file not found\n" >&2 #error
fi
rm tmp873245.txt