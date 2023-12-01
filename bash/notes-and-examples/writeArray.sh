# Declare an associative array
declare -A student_credentials

function writeArrayToFile(){
    for i in {0..9}; do
        student_credentials["username$i"]="password$i"
    done
    echo "writing to file"
    # Write the array to a file
    for key in "${!student_credentials[@]}"; do
        echo "$key=${student_credentials[$key]}" >> db.txt
    done
}

function removeEntryFromArray(){
    # Populate the student_credentials array from the file
    while IFS="=" read -r key value; do
        student_credentials[$key]=$value
    done < db.txt

    # Remove a user
    read -p "Enter the username of the user you want to remove: " username
    unset student_credentials[$username]
    echo "removing $username from the database..."

    # Clear the contents of the old file
    : > db.txt

    # Write the array to the file again
    for key in "${!student_credentials[@]}"; do
        echo "$key=${student_credentials[$key]}" >> db.txt
    done
}

# Read the file line by line

function readArrayFromFile() {
    echo "Printing file contents"
    while IFS="=" read -r key value; do
        new_student_credentials[$key]=$value
        echo "key: $key, value: $value"
    done < db.txt
}

function studentOperations(){
    echo "Please choose from the following options: "
    echo "1. Write to file"
    echo "2. Read from file"
    echo "3. Remove entry from file"
    read MENU_CHOICE
    if [ $MENU_CHOICE == 1 ]; then
        writeArrayToFile
    elif [ $MENU_CHOICE == 2 ]; then
        readArrayFromFile
    elif [ $MENU_CHOICE == 3 ]; then
        removeEntryFromArray
    fi
}
studentOperations

# writeArrayToFile
# sleep 1
# readArrayFromFile
