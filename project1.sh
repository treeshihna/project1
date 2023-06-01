#!/bin/bash

# Syntax: ./runprog.sh run_file

# runprog.sh runs a program n times
# assume the program is run with the command prog_name <option> input_file and prints results to stdout
# run_file contains n lines where each line is an entry of the format <options> input_file

if [[ $# -ne 1 ]] # check number of arguments 
then
    1>&2 printf "runprog.sh: wrong number of arguments\nSyntax: ./runprog.sh run_file\n" 
else
    if ! command -v prog_name > /dev/null 2>&1 #check if the command exists
    then
	1>&2 printf "runprog.sh: program %s does not exist\n" program name # error message if command doesn't exist
	
    elif [ -f run_file ] # check if file exists
    then
	cp run_file $PWD/temp_run # make a copy of run_file to temp_run
	echo " " >> temp_run # add a line so that wc-l is correct
	
	for i in $(seq 1 $(cat temp_run | wc -l)) # while read also works -> see notes 
	do
	    sed -e "$i"'s/$/ > prog_name_run_'"$i"'.txt 2>\&1 \&/' -i temp_run
	    # redirect stderr and stdout from line i to a file named prog_name_run_i.txt
	    bash temp_run # run the file
	    ps -aux | grep 'program_name' | grep -v 'grep' | awk '{print $2}' > prog_name_PIDs.txt
	    # put PIDs from each run on separate lines in a file named prog_name_PIDs.txt
	    # pgrep "program_name" might work too? but only prints processes currently running
	    
	    rm temp_run # remove temporary file
	done
    else
	1>&2 printf "runprog.sh: file %s does not exist\n" run_file # error message if file doesn't exist
    fi # end of file checking
fi # end of argument checking

#ANOTHER WAY TO EDIT EACH LINE
echo " " >> temp_run # still need to add another line

n=1
while read line
do
# for read each line
    sed -e "$n"'s/$/ > prog_name_run_'"$n"'.txt 2>\&1 \&/' -i temp_run
    n=$((n+1))
done < temp_run
    
