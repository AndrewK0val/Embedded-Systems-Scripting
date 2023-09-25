#!/bin/bash

MAX=20
LEVEL=2
TABLE_NUM=0
MENU_CHOICE=0
NUM_QUESTIONS=20

declare -A QUIZ_RESULTS
#declare associative array


function printArray(){
    for ((i=0; i<$NUM_QUESTIONS; i++ ))
    do
        for ((j=0; j<6; j++))
        do
            QUIZ_RESULTS[${i},${j}]=0
        done
    done
}

function random_ex(){
        local Y=4 X=1 MAX=13 NUM=5

        # 10 random numbers between 1 and 4
        for((i = 0; i < 10; i++))
        do
                echo -ne "$((RANDOM%Y+X))\t"
        done

        echo ""
        echo "10 Random Numbers between 0 and 12"
        for((i=0; i < 10; i++))
        do
                echo -ne "$((RANDOM%MAX))\t"
        done

        echo ""
        echo "10 Random number between $NUM and $((NUM+12))"
        for((i=0; i<10; i++))
        do
                CEILING=$NUM+12
                FLOOR=$NUM
                RANGE=$(($CEILING-$FLOOR+1))
                echo -ne "$((RANDOM%RANGE+FLOOR))\t"
        done
}

function tableQuiz(){
    #generate random number between 1 and 4
    #genarate random num between 1 and MAX
    for ((i=0; i<NUM_QUESTIONS; i++))
    do
        NUM=$((RANDOM%MAX+1))
        case $((RANDOM%4+1)) in
        1) #ask addition question
            #random number between 0 and 12
            echo "what is $((RANDOM%MAX))\t"

        ;;

        2) #ask subtraction question
            #random number between NUM and NUM+12

        ;;

        3) #ask multiplication question
            #random numebr between 0 and 12
        ;;

        4) #ask division question
            #random number between NUM and NUM*12 in steps of NUM
        ;;

        *) echo "Not an arithmetic choice, please ask your teacher for help"
        ;;
        esac
    done    
    echo "Thanks for taking the quiz"
}

function chooseNum(){
    TABLE_NUM=0
    until [ $TABLE_NUM -ge 1 -a $TABLE_NUM -le $MAX ]
    do
        echo "Enter table number value from 1 to $MAX"
        read TABLE_NUM
        if [ $TABLE_NUM -lt 1 -o $TABLE_NUM -gt $MAX ]
        then
            echo "invalid number for table number"
        fi
    done
    # echo ""
    # read TABLE_NUM
}

function main(){
    if [ $LEVEL -eq 1 ]
    then
        teacherMenu
    elif [ $LEVEL -eq 2 ] 
    then
        studentMenu
    else 
        echo "Invalid selection"
    fi
}

function chooseActivity(){
    echo ""
}

function teacherMenu(){
    MENU_CHOICE=0
    until [ $MENU_CHOICE -ge 1 -a $MENU_CHOICE -le 3 ]
    do
        echo "Manage students"
        echo "View quiz attempts"
        echo "3. Run stats"
        echo "4. exit"

        if [ $MENU_CHOICE -lt 1 -o $MENU_CHOICE -gt 4 ]
        then
            echo "Invalid choice, please try again"
        fi
    done
    case $MENU_CHOICE in
        1)
            manageStudents # call manageStudents function
            ;;
        2)
            viewQuizAttempts
            ;;
        3)
            viewStats
            ;;
        4)
            exitProgram
            ;;
        *)
            echo "invalid teacher menu"
            ;;
    esac

    read MENU_CHOICE
}

function studentMenu(){
    MENU_CHOICE=0 
    until [ $MENU_CHOICE -ge 1 -a $MENU_CHOICE -le 3 ]
    do
        echo "1. Learn tables"
        echo "2. Take Quiz"
        echo "3. Exit"
        read MENU_CHOICE
        if [ $MENU_CHOICE -lt 1 -o $MENU_CHOICE -ge 3 ]
        then
            echo "Invalid choice for student menu"
        fi
    done	
    case $MENU_CHOICE in 
        1)
            learnTables ;; 
        2)
            takeQuiz ;;
        3)
            exitProgram ;;
        *)
            echo "invalid student menu"
            ;;
    esac
}

function learnTables(){
    chooseNum
    chooseArithOp
    case $ARITH_OP in
        1) # Addition
            ANS=-999
            for((i = 0; i<= 12; i++))       # for i in {1..12}
            do 
                until [ $ANS -eq $(($TABLE_NUM + $i)) ]
                do
                    echo "What is $TABLE_NUM + $i"
                    read ANS

                    if [ $ANS -ne $(($TABLE_NUM + $i)) ]
                    then
                        echo "Incorrect, try again"
                    fi
                done
                echo "Correct!" #only output correct when outside of until loop
            done
            ;;
        2) # Subtraction
            for((i = 0; i<= 12; i--))       # for i in {1..12}
            do 
                until [ $ANS -eq $(($TABLE_NUM + $i)) ]
                do
                    echo "What is $TABLE_NUM - $i"
                    read ANS

                    if [ $ANS -ne $(($TABLE_NUM - $i)) ]
                    then
                        echo "Incorrect, try again"
                    fi 
                done
                echo "Correct!" #only output correct when outside of until loop
            done
            ;;
        3) # Multiplication
            for ((i=0; i<= 12; i++))
            do
                until [ $ANS -eq $(($TABLE_NUM - $i)) ]
                do

                done 
            done
            ;;
        4) # Division
            ;;

        *)
            echo "invalid learn tables option"
            ;;
    esac
}



function chooseArithOp(){
ARITH_OP=0
    until [ $ARITH_OP -ge 1 -a $ARITH_OP -le 4 ]
    do
        echo "choose one of the following"
        echo "1. Addition"
        echo "2. Subtraction"
        echo "3. Division"
        echo "4. Multiplication"
        read ARITH_OP
    done
}

function manageStudents(){
    echo ""
}

function exitProgram(){
    echo "Exit program"
}

main