#!/bin/bash
# write the contents of a 2D (associative) array to a file using a function
# this script populates a 2D array called MYARRAY with random numbers, the contents of this 2D array is then written to the file 2d_test.txt using the function

# create a 2D array and populate with random numbers
declare -A MYARRAY
read -p "Enter the number of rows:" r
read -p "Enter the number of columns: " c

for((i = 0; i < r; i++))
do
  for((j = 0;j < c; j++))
  do
     MYARRAY[${i},${j}]=$RANDOM
  done
done

function write_to_file()
{
   local file="2d_test.txt"
   if [ ! -f "$file" ]   # check if the $file exists
   then
       "touch $file"   # if file does not exist, create it now empty
   fi

   >$file    # clear the contents of the file

   for((i = 0; i < r; i++))
   do
     for((j = 0; j < c; j++))
     do
        echo -ne "${MYARRAY[${i},${j}]}\t" >> "$file"
     done
   done
   echo "" >> "$file"  # append a newline to the file
}

write_to_file  # function call   

# Remember in the echo statement
# -n omit newline from output
# -e enable the function of the backslash (\) character