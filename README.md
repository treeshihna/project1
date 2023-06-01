# Practical Project 1.

Purpose:

The script runprog.sh will run a program n times. Assume the program takes one input file prints its result to stdout and is run with the following command:

prog_name <options> input_file

where options may include any number of options. For example,

ls -Al --time-style=+%F ../a.txt

In this example, prog_name = "ls", options = "-Al --time-style=+%F" and input_file = "../a.txt"

Syntax:

The runprog.sh script should run with the following command:

./runprog.sh run_file

where run_file is an input file containing n lines where each line is an entry of the format:

<options> input_file

The script should run prog_name in the background, should redirect both the stderr and and stdout from run i to a file named prog_name_run_i.txt. A file named prog_name_PIDs.txt should be created that contains a list of the PIDs for each run, each on a separate line.

General Features:

Add appropriate error checking to your code (e.g., does the command prog_name exist? does input_file exist, etc) and include informative comments that explain what your code is doing. Create and maintain your code in a public github repository under your account named project1.
