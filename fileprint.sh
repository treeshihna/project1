#!/bin/bash                                                                    
                                                                               
# fileprint.sh filename
# check fileprint.error for stderr output

files="$(find $HOME -type f -printf '%f\n' 2>fileprint.error)" # list names of files in $HOME                                                
numfile="$(find $HOME -type f -name $1 2>>fileprint.error | wc -l)" # number of files with the same name

if [[ $# -ne 1 ]] # check for correct number of arguments
                                                                                
then
    1>&2 printf "fileprint: wrong number of arguments\n"

elif [[ "$numfile" -gt 1 ]] # check if the file name only matches 1 file
then
    1>&2 printf "printfile: multiple files with the same name\n"
    
elif ! [[ -f "$(find $HOME -type f -name $1 2>>fileprint.error)" ]] # check if file exists
then
    1>&2 printf "file not found\n"
else
    for file in $files
    do
	if [[ "$file" = "$1" ]]
	then
	    cat  $(find $HOME -type f -name $file 2>>error)  # print to stdout
	fi
    done
fi


