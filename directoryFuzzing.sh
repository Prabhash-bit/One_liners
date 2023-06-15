#!/bin/bash

echo 'Do you want to run file fuzzing script(y/yes/n/no)'
read yesorno

if [ $yesorno == 'y' ] || [ $yesorno == 'yes' ]
then
# ask the user to input filenames

echo 'Enter Valid url:'
read url1

mkdir $url1
read -p "Enter file extensions you want to FUZZ+++>> example .php,.html,.txt etc: " -a file_extension

read -p "Enter if you want to filter :" -a options1

echo "ffuf -u https://$url1/FUZZ -w /usr/share/seclists/Discovery/Web-Content/raft-medium-files-lowercase.txt -e ${file_extension[*]} ${options1[*]} -o $url1-files.txt"

ffuf -u https://$url1/FUZZ -w /usr/share/seclists/Discovery/Web-Content/raft-medium-files-lowercase.txt -e ${file_extension[*]} ${options1[*]} -o $url1-files.txt

mv $url1-files.txt ./$url1
else
	echo 'Terminated :( See you soon '
fi
