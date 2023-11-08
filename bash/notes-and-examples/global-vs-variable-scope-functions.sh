# Global variables and local variables inside a function
# Note: Before a function is called, all variables declared within the function are invisible outside the body of the function, not just those explicitly declared as local. They become visible after the function has been called.

#!/bin/bash
# local and global variables
# All variables have global scope unless explicitly defined as local within a function

function testing_variables() {
    var1=234;  # not declared as local so becomes global by default
    local var2=999;

    echo "Value of local variable is $var2"
    echo "Value of global variable is $var1"
}

testing_variables  # function call

# the value of $var2 below cannot be accessed outside of the function definition, it has been defined local in the function
echo "The value of the local variable is $var2"

echo "The value of the global variable is $var1"

# What will be outputted in this program?