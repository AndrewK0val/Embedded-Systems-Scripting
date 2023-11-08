#!/bin/bash
# checking for integer only input
# [[ ... ]] supports extra operations e.g. || instead of -o, && instead of -a
# =~ inbuilt regular expression comparison operator
# ^ is an anchor for start of string, $ for end
# [0-9] means any character between 0 and 9
# + is for the repetition of the latest pattern

# you could also store the regex in a variable e.g. re='^[0-9]+$' and then use $NUM =~ $re

re='^[0-9]+$'
until [[ $NUM =~ $re ]]
do
   read -p "Enter a numeric value only" NUM
   if [[ $NUM =~ $re ]]
   then
     echo "$NUM is numeric"
   else
     echo "$NUM contain illegal characters"
   fi
done
echo "The number you entered was $NUM"