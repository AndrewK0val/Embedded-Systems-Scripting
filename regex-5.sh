#!/bin/bash
# check for alpha numeric character entry only
# use the inbuilt character class alnum for A-Z, a-z or 0-9

until [[ $STR =~ ^[[:alnum:]]+$ ]]
do
   read -p "Enter a  string containing alpha numeric characters only: " STR
   if  [[ $STR =~ ^[[:alnum:]]+$ ]]
   then
     echo "$STR is alpha numeric"
   else
     echo "$STR contains illegal characters"
   fi
done

echo "The string you entered was $STR"