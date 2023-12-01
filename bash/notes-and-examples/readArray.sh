
# Read the file line by line

function readArrayFromFile() {
    declare -A new_user_pass

    echo "Printing file contents"
    while IFS="=" read -r key value; do
        new_user_pass[$key]=$value
        echo "key: $key, value: $value"
    done < db.txt

    if [ ${#new_user_pass[@]} -eq 0 ]; then
        # echo "The array is empty"
        otherFunction 1
    else
        otherFunction 0
    fi 
}

function otherFunction() {
    if [ $1 -eq 1 ]; then
        echo "The array is empty"
    else
        echo "The array is not empty"
    fi
}

readArrayFromFile
# otherFunction