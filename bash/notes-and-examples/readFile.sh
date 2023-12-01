#!/bin/bash

echo "Enter file name"
read MYFILE

filecontent=( $(cat $MYFILE) )
# or could use filecontent=( $(cat /path/to/filename) )

for i in "${filecontent[@]}"
do
  echo $i
done

echo "Reading of file completed"
# #output the contents of the array
# echo "${filecontent[@]}"