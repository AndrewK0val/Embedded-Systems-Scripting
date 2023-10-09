#!/bin/bash
# passing arguments to a function - place them after the function call separated by spaces
# Note: the $0 argument is reserved for the functions name
# The parameters passed are in the order $1, $2, $3, ... , $n

function hello() {
  echo "Hello $1"
}

function total() {
  echo "The sum of two numbers is $(($1 + $2))"
}

hello "Fergal"             # function call with 1 argument passed - will output Hello Fergal
total 5 6                  # function call with 2 arguments passed - will output The sum of two number is 11