#!/bin/bash

#./runprog.sh run_file
#run_file contains n lines where each line is an entry of the prog_name <options> input_file

run_file=$1 

if [[ $# -ne 1 ]] #check for correct input
then
    printf "wrong number of arguments\n" > /dev/stderr
else
    if ! [[ -f $1 ]] #check if input file exists
    then
	printf "file %s not found\n" $1 > /dev/stderr
    else
	i=1 #number of run
	
	if [ $i -eq 1 ] && [ -f "$prog_name"_PIDs.txt ]
        then
            rm "$prog_name"_PIDs.txt
        fi
	echo " " >> $1
       	while read -r line #go through each line
	do
	    prog_name="$(echo "$line" | awk '{print $1}')"
	    input_file="$(echo "$line" | awk '{print $NF}')"
	    if ! [[ -x $prog_name ]] #check prog_name exists and is executable
	    then
		printf "line %d: %s not found or not executable\n" $i $prog_name > /dev/stderr
		
	    elif ! [[ -f $input_file ]] #check input_file exists
	    then
		printf "line %d: file %s not found\n" $i $input_file > /dev/stderr
	    else
		$line >"$prog_name"_run_"$i".txt 2>&1 & #run line in background and redirect stdout/err
		echo "line$i's PID: $!" >>"$prog_name"_PIDs.txt #print PIDs for each run
	    fi
	    i=$((i+1)) #go to the next run
	done < $1
    fi
fi
