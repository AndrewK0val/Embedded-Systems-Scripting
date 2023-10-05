#!/bin/bash

# passing arguments to a function - place them after the function call separated by spaces
# Note: the $0 argument is reserved for the functions name
# The parameters passed are in the order $1, $2, $3, ... , $n

function hello(){
    echo "Hi " $1
}

function total(){
    
}