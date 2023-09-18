#!/bin/bash

MAX=20
LEVEL=2
TABLE_NUM=0
MENU_CHOICE=0

function chooseNum(){
	TABLE_NUM=0
	until [$TABLE_NUM -ge 1 -o $TABLE_NUM le MAX]
	do
		echo "Enter table number value from 1 to $MAX"
		read TABLE_NUM
		if [ $TABLE_NUM -lt 1 -o $TABLE_NUM -gt MAX ]
		then
			echo "invalid number for table number"
		fi
        done
    echo ""
    read TABLE_NUM

}

function main(){
	if [$LEVEL -eq 1]
	then
		teacherMenu
	elif [ $LEVEL -eq 2] 
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
until [$MENU_CHOICE -ge 1 -a $MENU_CHOICE -le 3]
do
	echo "Manage students"
	echo "View quiz attempts"
	echo "3. Run stats"
	echo "4. exit"

	if[ $MENU_CHOICE -lt 1  -o $MENU_CHOICE -gt 4]
	then
		echo "Invalid choice, please try again"
	if
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
until [$MENU_CHOICE -ge 1 -a $MENU_CHOICE -le 3]
do
		if [$MENU_CHOICE - lt 1 -o $MENU_CHOICE -ge 3]
		then
				echo "Invalid choice for student menu"
		fi
		read MENU_CHOICE
done	
    case $MENU_CHOICE in 
        1)
                 learnTables ;; 
        2)
                 tableQuiz  ;;

        3)       exitProgram   ;;

        *)       echo "invalid student menu"
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
                
                if [$ANS -ne $(($TABLE_NUM + $i))] 
                    echo "Incorrect, try again"
                fi 
            done
         echo "Correct!" #only output correct when outside of until loop
        done
     ;;
    2) # Subtraction
        for((i = 0; i<= 12; i--))       # for i in {1..12}
        do 
            until [ $ANS -eq $(($TABLE_NUM - $i)) ]
            do
                echo "What is $TABLE_NUM - $i"
                read ANS
                
                if [$ANS -ne $(($TABLE_NUM - $i))] 
                    echo "Incorrect, try again"
                fi 
            done
         echo "Correct!" #only output correct when outside of until loop
        done
    ;;
    3) # Multiplication
    ;;
    4) # Division
    ;;

    *)
        echo "invalid learn tables option"
        ;;
    esac
}

function tableQuiz(){
    echo ""
}

function chooseArithOp(){
    until [$ARITH_OP -ge 1 -a $ARITH_OP]
	do
        echo "choose one of the following"
        echo "1. Addition"
        echo "2. Subtraction"
        echo "3. Division"
        echo "4. Multiplication"
	ARITH_OP=0
}

function manageStudents(){
    echo ""
}



function exitProgram(){
	echo "Exit program"
}