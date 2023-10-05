#!/bin/bash

i=0
for j in $(cat testfile.txt)
do
  ARRAY[$i]=$j
  # more lines of code here if necessary
  i=$(($i+1))
done
echo "Value of second element in the array: ${ARRAY[1]}"

# Or using a while loop to read contents line by line
index=0
FILE="/home/fohanlon/inputFile.txt"
while read -r LINE
do
  MYARRAY[$index]="$LINE"
  index=$(($index+1))
done < $FILE
echo "{MYARRAY[@]}"

declare -A MYARRAY2  # an associative array
FILE2="/home/fohanlon/inputFile2.txt"
while IFS=$'\n' read -r LINE2
do
  # display $LINE2 or do something with $LINE2
  printf '%s\n' "$LINE2"
  echo $LINE2 | grep "in"
done < $FILE2