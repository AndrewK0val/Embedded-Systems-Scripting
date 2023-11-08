#!/bin/bash
# checking for alphanumeric only input
# [[ ... ]] supports extra operations e.g. || instead of -o, && instead of -a
# =~ inbuilt regular expression comparison operator
# ^ is an anchor for start of string, $ for end
# [A-Za-z0-9] means any character between A and Z, a and z or 0 and 9
# + is for the repetition of the latest pattern

# you could also store the regex in a variable e.g. re='^[A-Za-z0-9]+$' and then use $STR =~ $re

until [[ $STR =~ ^[A-Za-z0-9]+$ ]]
do
   read -p "Enter a string containing only alphanumeric characters" STR
   if [[ ! $STR =~ ^[A-Za-z0-9]+$ ]]
   then
     echo "$STR contain illegal characters"
   fi
done
echo "The string you entered was $STR"