#!/bin/bash
# associative array - an array that can store string values as an index or key
# arrayname[key]=value

declare -A AIRPORT_CODES

AIRPORT_CODES[DUB]="Dublin"
AIRPORT_CODES[LHR]="Heathrow"
AIRPORT_CODES[LGW]="Gatwick"
AIRPORT_CODES[NYC]="New York City"
AIRPORT_CODES[PAR]="Paris"
AIRPORT_CODES[SYD]="Sydney"

# printing a value using the key
echo "Printing a value using the key"
echo ${AIRPORT_CODES[LGW]}
echo ${AIRPORT_CODES[PAR]}

echo ""

# printing all array keys
echo "Printing all array keys"
for key in "${!AIRPORT_CODES[@]}"
do
  echo $key
done

echo ""

# printing all array values using a for loop
echo "Printing the complete array contents"
for i in "${AIRPORT_CODES[@]}"
do
  echo $i
done

echo ""

# printing all key-value combinations
echo "Printing all key-value combinations"
for key in "${!AIRPORT_CODES[@]}"
do
   echo "$key is an abbreviation for ${AIRPORT_CODES[$key]}"
done

# example to add another array element
AIRPORT_CODES+=([SHN]="Shannon")

echo ""
echo "${AIRPORT_CODES[@]}"

# print the number of elements
echo ""
echo "Number of array elements is now ${#AIRPORT_CODES[@]}"

# deleting an array - commented here as I don't want to delete the array
# unset AIRPORT_CODES