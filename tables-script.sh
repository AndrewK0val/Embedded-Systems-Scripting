#!/bin/bash

declare -A QUIZ_RESULTS

TABLE_NUM=""


function main() {
    echo "welcome to my times tables bash script - the most child-friendly learning enviornment!"
    login
}

function login(){
    MENU_CHOICE=''
    echo -e 'are you a teacher or a student? \n 1. teacher \n 2. student' 
    read $MENU_CHOICE
        if $MENU_CHOICE == 1
            then
                echo 'please enter your username'
                read local $USERNAME
                echo 'please enter your password'
                read local $PASSWORD
                teacherMenu $USERNAME $PASSWORD
        elif $MENU_CHOICE == 2
            then
            echo 'please enter your table number'
            read local $TABLE_NUM
            echo 'please enter your password'
            read local $PASSWORD
                studentMenu $TABLE_NUM $PASSWORD
        else
            echo 'please enter a valid option'
            login
        fi
}

function teacherMenu(){
    filecontent=( $(cat ./teacherCredentials.txt) )
    # or could use filecontent=( $(cat /path/to/filename) )
    for i in "${filecontent[@]}"
    do
    echo $i
    done
    echo "${filecontent[@]}"
    USERNAME=$1
    PASSWORD=$2

    MENU_CHOICE=''
    echo 'please choose one of the following:'
    viewStudentQuizResults
    manageStudents
}

function studentMenu() {
    filecontent=( $(cat ./studentCredentials.txt) )
    #Encrypting a variable to test against another encrypted variable in a file
    SHAPWD="$(printf "%s" "./studentCredentials.txt" | sha1sum | cut -d ' ' -f 1)"
    # or could use filecontent=( $(cat /path/to/filename) )
    for i in "${filecontent[@]}"
    do
    echo $i
    done
    echo "${filecontent[@]}"

    ENTERED_TABLE_NUM=$1
    ENTERED_PASSWORD=$2
    echo 'please choose one of the following:'
    learnTables
    takeQuiz $TABLE_NUM
    exit

}

function learnTables(){
    echo 'which type of table would you like to learn?'
    read $ARITH_OP
        case $ARITH_OP in
            1) echo 'addition'
            ;;
            2) echo 'subtraction'
            ;;
            3) echo 'multiplication'
            ;;
            4) echo 'division'
            ;;
            *) echo 'please enter a valid option'
            learnTables
            ;;
        esac
    
}

function takeQuiz(){
TABLE_NUM=$1

}

function chooseArithOp(){

}

function manageStudents() {
    MENU_CHOICE=""
    echo "Please choose an option: \n 1."

    addStudent $TABLE_NUM
    updateStudent $TABLE_NUM
    RemoveStudent $TABLE_NUM

}

function addStudent() {
    

}

function updateStudent() {
    TABLE_TO_UPDATE=$1
    echo -e 'which of the following would you like to update? \n 1. table number \n 2. password'
    if $MENU_CHOICE == 1
        then
            echo 'please enter the new table number'
            read $NEW_TABLE_NUM
            echo 'please enter the password'
            read $PASSWORD
            # update the table number
            # update the password
    elif $MENU_CHOICE == 2
        then
            echo 'please enter the table number'
            read $TABLE_NUM
            echo 'please enter the new password'
            read $NEW_PASSWORD
            # update the password
    else
        echo 'please enter a valid option'
        updateStudent $TABLE_NUM
    fi


}

function RemoveStudent() {
    TABLE_TO_REMOVE=$1

}

function viewStudentQuizResults() {
    # placeholder for now , will need to read from file
    MYARRAY=()

    echo "Enter file name"
    read MYFILE

    index=0
    while read LINE
    do
    MYARRAY[$index]="$LINE"
    index=$(($index+1))
    done < $MYFILE  # tell the terminal to read the data from the file via STDIN stream

    echo "Reading of file completed"

    # output the contents of the array
    echo "Contents of the array is" ${filecontent[@]}
    # echo "Total number of rows in file is ${index}"

}

function printQuizReportCard() {

    
}


function exit() {
    exit 0
}

main
