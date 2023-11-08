#!/bin/bash
# returning values from functions - BASH does not allow you to return values like in other programming languages
# when a bash function finishes execution it will either return 0 for success or a number in the range 1-255 based on the status of the last statement executed


# you can specify the value of the return status, it will be assigned to the $? variable
function hello() {
  echo "Hello $1"

return 42
}

hello "Fergal"
echo "The value returned from hello function is $?"


# to return a value from a function you can use a global variable defined in the function
# Note: there is no value being returned from the function, you are using a global variable to then access the value set in the function
function total_nums() {
  total=0              # define a global variable and set it to 0 initially (note: this could be set outside of the function definition)
  total=$(($1 + $2))   # here the global total can be accessed anywhere in the program
}

total_nums 5 7     # function call
echo "The value in the global variable total is now $total"

total_nums 8 12    # function call
echo "The value of the global variable total is now $total"

# another method to return a value from a function would be to use stdout i.e. send the value to echo or printf
function multiply() {
  local product=0
  product=$((7 * 8))
  echo "$product"  # return the value in an echo
}

val1="$(multiply)"  # function call will store the result of the echo statement in function call in the global variable val1
echo "value of val1 variable is $val1"  # output the value of the global variable val1, it will be 56