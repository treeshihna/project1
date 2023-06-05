#!/bin/bash

sleep $1 && printf "I am done sleeping!!!\n" #this prints to stdout

echo "I'm echoed by sleepecho!" > $2 #echo this line to the input file
