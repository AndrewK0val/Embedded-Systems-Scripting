#!/bin/bash
# checking for integer only input
# [[ ... ]] supports extra operations e.g. || instead of -o, && instead of -a
# =~ inbuilt regular expression comparison operator
# ^ is an anchor for start of string, $ for end
# [0-9] means any character between 0 and 9
# + is for the repetition of the latest pattern

until [[ $NUM =~ ^[0-9]+$ ]]
do
   read -p "Enter a numeric value only" NUM
   if [[ $NUM =~ ^[0-9]+$ ]]
   then
     echo "$NUM is numeric"
   else
     echo "$NUM contain illegal characters"
   fi
done
echo "The number you entered was $NUM"