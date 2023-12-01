
NUMQUESTIONS=5
TABLE_NUM=""
USERNAME=""
PASSWORD=""
declare -A student_credentials
declare -A QUIZ_RESULTS

function main() {
    echo "welcome to my times tables bash script - did you know that the command line is the most child-friendly learning enviornment according to science?"
    setup
    login
}

function login(){
    USERNAME=""
    PASSWORD=""
    MENU_CHOICE=0
    echo -e "are you a student or a teacher? \n 1. student \n 2. teacher"
    read MENU_CHOICE
    if [ $MENU_CHOICE == 1 ]; then
        echo "you are a student"
        studentMenu USERNAME
    
    elif [ $MENU_CHOICE == 2 ]; then
        echo "you are a teacher"
        #students CRUD operations in teacher menu
        teacherMenu
    fi
}

function studentMenu(){
    echo "Hello $USERNAME"
}


function teacherMenu(){
    MENU_CHOICE=0
    echo -e "please choose from the following options: \n 1. Create, Update or Remove students \n 2. View quiz results"

    read MENU_CHOICE
    if [ $MENU_CHOICE == 1 ]; then 
        studentOperations
    elif [ $MENU_CHOICE == 2 ]; then
        echo "view quiz results"
    elif  [ $MENU_CHOICE -lt 1 -o $MENU_CHOICE -gt 2]; then
        echo "$MENU_CHOICE is invalid! please try again"
        teacherMenu
    fi 
}



function setup(){
    # Check if db-students.txt exists
    if [ ! -f db-students.txt ]; then
        # If it doesn't exist, create it
        touch db-students.txt
    fi
}


function studentOperations(){
    readArrayFromFile
    echo "Please choose from the following options: "
    echo "1. Add student"
    echo "2. Update student"
    echo "3. Remove student"
    read MENU_CHOICE
    if [ $MENU_CHOICE == 1 ]; then
        # echo "please enter a username for the student (must be one word and cannot contain special charchters)"
        
        until [[ $USERNAME =~ ^[[:alnum:]]+$ && -z ${student_credentials[$USERNAME]} ]]
        do
            read -p "Please enter username for student (e.g. AndrewK0val), letters and numbers only: " USERNAME               
            if [[ ! $USERNAME =~ ^[[:alnum:]]+$ || -n ${student_credentials[$USERNAME]} ]]
            then
                echo -e "\nInvalid or duplicate Username! please follow the syntax rules and ensure the username is unique\n"
            fi
        done

        # echo "Please create a password for the student (no special charachters)"
        # read PASSWORD
        until [[ ${#PASSWORD} -ge 8 && $PASSWORD =~ ^[[:alnum:]]+$ ]]
        do
            read -p "Please enter a password for the student (must be at least eight charachters in lenght -letters and numbers only)" PASSWORD
            if [[ ${#PASSWORD} -lt 8 || ! $PASSWORD =~ ^[[:alnum:]]+$ ]]
            then
                echo -e " \nInvalid Password! please try again (make sure its at least 8 charachters long and contains no letters or numbers) \n"
            fi
        done

        # echo -e "Please enter the students level (1-4 - 1 being the lowest level and 4 being the highest) \n"
        # read LEVEL
        until [[ $LEVEL -ge 1 && $LEVEL -le 4 ]]
        do
            read -p "Please enter the students level (1-4 --- 1 being the lowest level and 4 being the highest)" LEVEL
            if [[ $LEVEL -lt 1 || $LEVEL -gt 4 ]]
            then
                echo -e "\nInvalid level! please try again \n"
            fi
        done 
        # echo "Please enter the students age group (age 5-12)"
        # read AGE_GROUP
        until [[ $AGE_GROUP -ge 5 && $AGE_GROUP -le 12 ]]
        do
            read -p "Please enter the students age group (age 5-12)" AGE_GROUP
            if [[ $AGE_GROUP -lt 5 || $AGE_GROUP -gt 12 ]]
            then
                echo -e "\nInvalid age group! please try again \n"
            fi
        done

        #pass the arguments to the addStudent function
        addStudent $USERNAME $PASSWORD $LEVEL $AGE_GROUP
    elif [ $MENU_CHOICE == 2 ]; then
        read -p "Enter the username of the user you want to update: " STUDENT_TO_UPDATE
        updateStudent $STUDENT_TO_UPDATE
    elif [ $MENU_CHOICE == 3 ]; then
        RemoveStudent
    fi
}


function addStudent(){
    #remenants of debug code
    # for i in {0..9}; do
    #     student_credentials["username$i"]="password$i"
    # done

    #takes in credentials as arguments
    
    USERNAME=$1
    PASSWORD=$2
    LEVEL=${3:-"N/A"}  # Use "N/A" if LEVEL is not provided
    AGE_GROUP=${4:-"N/A"}  # Use "N/A" if AGE_GROUP is not provided

    student_credentials["$USERNAME"]="$PASSWORD,$LEVEL,$AGE_GROUP"
    echo "writing to file..."
    # Write the array to a file
    for key in "${!student_credentials[@]}"; do
        echo "$key=${student_credentials[$key]}" >> db-students.txt
    done
    sleep 1 #adding artifical delay to make it seem like the script is doing something
    echo "student added successfully :)"
}

function RemoveStudent(){
    # Populate the student_credentials array from the file
    while IFS="=" read -r key value; do
        student_credentials[$key]=$value
    done < db-students.txt

    # Remove a user
    read -p "Enter the username of the user you want to remove: " username
    unset student_credentials[$username]
    echo "removing $username from the database..."

    # Clear the contents of the old file
    : > db-students.txt
    echo "writing to file..."
    sleep 1
    # Write the array to the file again
    for key in "${!student_credentials[@]}"; do
        echo "$key=${student_credentials[$key]}" >> db-students.txt
    done
    
    echo "student removed successfully"
}

# function updateStudent(){
#     $MENU_CHOICE=0
#     STUDENT_TO_UPDATE=$1
#     echo -e 'which of the following would you like to update? \n 1. password \n 2. level \n 3. age group \n 4. return to main menu'
#     read $MENU_CHOICE
#     if [ $MENU_CHOICE == 1 ]; then
#          until [[ ${#PASSWORD} -ge 8 && $PASSWORD =~ ^[[:alnum:]]+$ ]]
#         do
#             read -p "Please enter a password for the student (must be at least eight charachters in lenght -letters and numbers only)" PASSWORD
#             if [[ ${#PASSWORD} -lt 8 || ! $PASSWORD =~ ^[[:alnum:]]+$ ]]
#             then
#                 echo -e " \nInvalid Password! please try again (make sure its at least 8 charachters long and contains no letters or numbers) \n"
#             fi
#         done
#     elif [ $MENU_CHOICE == 2 ]; then
#         until [[ $LEVEL -ge 1 && $LEVEL -le 4 ]]
#         do
#             read -p "Please enter the students level (1-4 --- 1 being the lowest level and 4 being the highest)" LEVEL
#             if [[ $LEVEL -lt 1 || $LEVEL -gt 4 ]]
#             then
#                 echo -e "\nInvalid level! please try again \n"
#             fi
#         done 
#     elif [ $MENU_CHOICE == 3 ]; then
#         until [[ $AGE_GROUP -ge 5 && $AGE_GROUP -le 12 ]]
#         do
#             read -p "Please enter the students age group (age 5-12)" AGE_GROUP
#             if [[ $AGE_GROUP -lt 5 || $AGE_GROUP -gt 12 ]]
#             then
#                 echo -e "\nInvalid age group! please try again \n"
#             fi
#         done
#     elif [ $MENU_CHOICE == 4 ]; then
#         echo "returning to main menu"
#         teacherMenu

#     else
#         echo 'please enter a valid option'
#         updateStudent $STUDENT_TO_UPDATE
#     fi

# }

function updateStudent(){
    MENU_CHOICE=0
    STUDENT_TO_UPDATE=$1

    # Read the existing student data from the file
    while IFS="=" read -r key value; do
        student_credentials[$key]=$value
    done < db-students.txt

    echo -e 'You have selected $STUDENT_TO_UPDATE \nWhich of the following would you like to update? \n 1. password \n 2. level \n 3. age group \n 4. return to main menu'
    read MENU_CHOICE
    if [ $MENU_CHOICE == 1 ]; then
         until [[ ${#PASSWORD} -ge 8 && $PASSWORD =~ ^[[:alnum:]]+$ ]]
            do
                read -p "Please enter a password for the student (must be at least eight charachters in lenght -letters and numbers only)" PASSWORD
                if [[ ${#PASSWORD} -lt 8 || ! $PASSWORD =~ ^[[:alnum:]]+$ ]]
                then
                    echo -e " \nInvalid Password! please try again (make sure its at least 8 charachters long and contains no letters or numbers) \n"
                fi
            done
        # Update password
        IFS=',' read -r old_password old_level old_age_group <<< "${student_credentials[$STUDENT_TO_UPDATE]}"
        student_credentials[$STUDENT_TO_UPDATE]="$PASSWORD,$old_level,$old_age_group"
    elif [ $MENU_CHOICE == 2 ]; then
        # Rest of your code...
        until [[ $LEVEL -ge 1 && $LEVEL -le 4 ]]
            do
                read -p "Please enter the students level (1-4 --- 1 being the lowest level and 4 being the highest)" LEVEL
                if [[ $LEVEL -lt 1 || $LEVEL -gt 4 ]]
                then
                    echo -e "\nInvalid level! please try again \n"
                fi
            done 
        # Update level
        IFS=',' read -r old_password old_level old_age_group <<< "${student_credentials[$STUDENT_TO_UPDATE]}"
        student_credentials[$STUDENT_TO_UPDATE]="$old_password,$LEVEL,$old_age_group"
    elif [ $MENU_CHOICE == 3 ]; then
        until [[ $AGE_GROUP -ge 5 && $AGE_GROUP -le 12 ]]
            do
                read -p "Please enter the students age group (age 5-12)" AGE_GROUP
                if [[ $AGE_GROUP -lt 5 || $AGE_GROUP -gt 12 ]]
                then
                    echo -e "\nInvalid age group! please try again \n"
                fi
            done
        # Update age group
        IFS=',' read -r old_password old_level old_age_group <<< "${student_credentials[$STUDENT_TO_UPDATE]}"
        student_credentials[$STUDENT_TO_UPDATE]="$old_password,$old_level,$AGE_GROUP"
    elif [ $MENU_CHOICE == 4 ]; then
        echo "Returning to main menu"
        teacherMenu
    else
        echo 'Please enter a valid option'
        updateStudent $STUDENT_TO_UPDATE
    fi

    # Write the updated array back to the file
    : > db-students.txt
    for key in "${!student_credentials[@]}"; do
        echo "$key=${student_credentials[$key]}" >> db-students.txt
    done
}

# Read the file line by line

function readArrayFromFile() {
    echo "Printing file contents"
    while IFS="=" read -r key value; do
        student_credentials[$key]=$value
        echo "key: $key, value: $value"
    done < db-students.txt
}


main