#!/bin/bash
# runjob [command] -a [cmd args] -n [no jobs to run]

if [[ $# -le 2 ]] || [[ $# -ge 6 ]] # check number of arguments >=3 and <6
then
    printf "runjob: wrong number of arguments...\n" > /dev/stderr
else
    cmd=$1
    if [[ $# -eq 3 ]]
    then
    if [[ $2 = "-n" ]] # no arguments
    then
        numexec=$3
    else
        if [[ $2 = "-a" ]] # arguments with default numexec=1
        then
        args=$3
        numexec=1 # execute program once by default
        else
        printf "runjob: unknown option =  %s\n" $2  > /dev/stderr # option not recognized
        exit
        fi
    fi
    else
    if ! [[ $2 = "-a" ]] # check second argument is args 
    then
        printf "options: second argument %s should be -a\n" $2  > /dev/stderr
        exit
    fi
    if ! [[ $4 = "-n" ]] # check fourth argument is numexec
    then
        printf "options: fourth argument %s should be -n\n" $4  > /dev/stderr
        exit
    fi
    args=$3
    numexec=$5
    fi
    echo "Job IDs:" > jobpids.txt 
    for (( jobnum=1; jobnum<=numexec; jobnum++))
    do
    $cmd $args 2>&1 > run$jobnum.txt &
    echo $! >> jobpids.txt  # save PIDs for jobs
    done
fi
