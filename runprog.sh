#!/bin/bash

#./runprog.sh run_file
#run_file contains n lines where each line is prog_name <options> input_file

if [[ $# -ne 1 ]] #check for correct input
then
    printf "Wrong number of arguments\n" > /dev/stderr
else
    run_file=$1
    if ! [[ -f $1 ]] #check if input file exists
    then
	printf "File %s not found\n" $1 > /dev/stderr
    else
	i=1 #number of run
       	while read -r line || [ -n "$line" ] #go through each line if the last line is not empty
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
		if [ $i -eq 1 ] && [ -f "$prog_name"_PIDs.txt ]
		then rm "$prog_name"_PIDs.txt #update PIDs when start over
		fi
		$line >"$prog_name"_run_"$i".txt 2>&1 & #run line in background and redirect stdout/err
		echo "line$i's PID: $!" >>"$prog_name"_PIDs.txt #print PIDs for each run
	    fi
	    i=$((i+1)) #go to the next run
	done < $1
    fi
fi
