#!/bin/bash

declare -A QUIZ_RESULTS

NUMQUESTIONS=5
TABLE_NUM=""
USERNAME=""
PASSWORD=""


function main() {
    echo "welcome to my times tables bash script - the most child-friendly learning enviornment!"
    login
}




function login(){
    MENU_CHOICE = 0
    echo -e 'are you a teacher or a student? \n 1. teacher \n 2. student' 
    read $MENU_CHOICE
        if $MENU_CHOICE == 1
            then
                until [[ $USERNAME =~ ^[[:alnum]]+$ ]]
                do
                    read -p "Please enter your username (must be lowercase letters and numbers)" USERNAME
                    # error handling for username validation
                    if [[ ! $USERNAME =~ ^[[alnum]]+$ ]]
                    then
                        echo "Invalid Username: only use numbers and letters"
                    fi
                done

                until ((${#PASSWORD} >= 8 )) && [[ $PASSWORD =~ ^[[:alnum]]+$ ]]
                do
                    read -p "Please enter your password (must be at least eight charachters in lenght -letters and numbers only)" 
                    if [[ ${#PASSWORD} -lt 8 || ! $PASSWORD =~ ^[[:alnum:]]+$ ]]
                    then
                    echo "Invalid Password, please try again (make sure its at least 8 charachters long and contains no letters or numbers)"
                    fi
                done
                echo "you are logged in as: "

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

    for ((i=0;i<$NUMQUESTIONS;i++))
    do
        read $ARITH_OP
            case $ARITH_OP in
                1) echo "$((i+1))"
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
        if [ $USER_ANS -eq $ANS ]
        then
            echo "Good job, do you want a medal for that?"
        else
            echo "not good enough, maybe try harder next time" 
        fi
    done
}

function takeQuiz(){
    TABLE_NUM=$1
    for((i=0;i<$NUMQUESTIONS;i++))
    do
        ARITH_OP=$((RANDOM%4+1))

        case $ARITH_OP in
            1)
                echo "$((i+1)):"
                QUIZNUM=$((RANDOM%12+1))
                ANS=$((NUMBER+QUIZNUM))
                echo "$NUMBER + $QUIZNUM = ?"
            ;;
            2)
                echo "$((i+1)):"
                QUIZNUM=$((RANDOM%12+1))
                ANS=$((NUMBER-QUIZNUM))
                echo "$NUMBER - $QUIZNUM = ?"
            ;;
            3)
                echo "$((i+1)):"
                QUIZNUM=$((RANDOM%12+1))
                ANS=$((NUMBER/QUIZNUM))
                echo "$NUMBER / $QUIZNUM = ?"
            ;;
            4)
                echo "$((i+1)):"
                QUIZNUM=$((RANDOM%12+1))
                ANS=$((NUMBER*QUIZNUM))
                echo "$NUMBER x $QUIZNUM = ?"
            ;;
        esac
    done
}

function chooseArithOp(){
    ARITH_OP = 0
    until [ $ARITH_OP -gt 0 -a $ARITH_OP -le 4]
    do
        echo "Choose an operator"
        echo "1. Addition"
        echo "2. Subtraction"
        echo "3. Multiplication"
        echo "3. Division"

        if [ $ARITH_OP -lt 1 -o $ARITH_OP -gt 4 ]
        then
            echo "$ARITH_OP is invalid, please try again! "
            chooseArithOp
        fi         
    done 
}

function manageStudents() {
    MENU_CHOICE=""
    echo "Please choose an option: \n 1."

    addStudent $TABLE_NUM
    updateStudent $TABLE_NUM
    RemoveStudent $TABLE_NUM

}

# function addStudent() {
    

# }

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
