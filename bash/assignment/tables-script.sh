#redundant
# TABLE_NUM=""

USERNAME=""
PASSWORD=""
declare -A student_credentials
declare -A QUIZ_RESULTS

function main() {
    echo "welcome to my times tables bash script"
    setup
    login
}


function setup(){
    # Check if db-students.txt exists
    if [ ! -f db-students.txt ]; then
        # If it doesn't exist, create it
        touch db-students.txt
    fi
}


function login(){
    USERNAME=""
    PASSWORD=""
    MENU_CHOICE=0
    echo -e "Are you a student or a teacher? \n 1. Student \n 2. Teacher"
    read MENU_CHOICE
    if [ $MENU_CHOICE == 1 ]; then
        echo "You are a student"
        read -p "Please enter your username: " USERNAME
        read -sp "Please enter your password: " PASSWORD
        echo

        # Read the student data from the file
        declare -A student_credentials
        while IFS="=" read -r key value; do
            student_credentials[$key]=$value
        done < db-students.txt

        # Check if the entered username and password match the stored ones
        IFS=',' read -r stored_password stored_level stored_age_group <<< "${student_credentials[$USERNAME]}"
        if [[ $PASSWORD == $stored_password ]]; then
            studentMenu $USERNAME $stored_age_group
        else
            echo -e "\nInvalid username or password. Please try again.\n"
            login
        fi
    elif [ $MENU_CHOICE == 2 ]; then
        echo "You are a teacher"
        # Students CRUD operations in teacher menu
        teacherMenu
    else
        echo "Invalid option. Please enter 1 for Student or 2 for Teacher."
        login
    fi
}


function studentMenu(){
    USERNAME=$1
    AGE_GROUP=$2
    echo -e "\nHello $USERNAME, please choose from the following options: "
    echo "1. Learn tables"
    echo "2. Take a quiz"
    echo "3. Return to main menu"
    read MENU_CHOICE
    if [ $MENU_CHOICE == 1 ]; then
        NUMOFQUESTIONS=$(numberOfQuestions $AGE_GROUP)
        echo "numeber of questions: $NUMOFQUESTIONS"
        learnTables $NUMOFQUESTIONS
    elif [ $MENU_CHOICE == 2 ]; then
        takeQuiz $AGE_GROUP $USERNAME
    elif [ $MENU_CHOICE == 3 ]; then
        login
    fi
}



function takeQuiz() {
    AGE_GROUP=$1
    USERNAME=$2
    NUMOFQUESTIONS=$(numberOfQuestions $AGE_GROUP)

    for ((i = 0; i < $NUMOFQUESTIONS; i++)); do
        ARITH_OP=$((RANDOM % 4 + 1))
        QUIZNUM=$((RANDOM % 12 + 1))
        
        case $ARITH_OP in
            1)  # Addition
                ANS=$((NUMBER + QUIZNUM))
                ;;
            2)  # Subtraction
                ANS=$((NUMBER - QUIZNUM))
                ;;
            3)  # Division
                ANS=$((NUMBER / QUIZNUM))
                ;;
            4)  # Multiplication
                ANS=$((NUMBER * QUIZNUM))
                ;;
        esac

        echo "Question $((i + 1)):"
        echo "$NUMBER $(getArithOpSymbol $ARITH_OP) $QUIZNUM = ?"
        echo -n "-----> "
        read USER_ANS

        if [ $USER_ANS -eq $ANS ]; then
            CORRECT=1
            echo "Correct!"
        else
            echo "Wrong!"
            CORRECT=0
        fi

        # Store quiz results in the array
        QUIZ_RESULTS[$i,0]=$NUMBER
        QUIZ_RESULTS[$i,1]=$ARITH_OP
        QUIZ_RESULTS[$i,2]=$QUIZNUM
        QUIZ_RESULTS[$i,3]=$ANS
        QUIZ_RESULTS[$i,4]=$USER_ANS
        QUIZ_RESULTS[$i,5]=$CORRECT
    done

    saveQuizResults
}



function saveQuizResults() {
   local folder="results/"
   local file="${folder}${USERNAME}-$(date +%Y%m%d%H%M%S).txt"

   # Check if the directory exists, if not, create it
   if [ ! -d "$folder" ]; then
       mkdir "$folder"
   fi
   # Create the file or clear its contents
   > "$file"
   # Add the header to the file
   echo -ne "NUM     Op     Num2     ANS      USR      TF" >> "$file"
   # Add the data to the file
   for ((i = 0; i < 6; i++)); do
      echo -ne "\n" >> "$file"
      for ((j = 0; j < 6; j++)); do
         echo -ne "${QUIZ_RESULTS[${i},${j}]}\t" >> "$file"
      done
   done

   echo -e "\nQuiz results saved to: $file"
}


function chooseNum(){
	until [ $NUMBER -ge 1 -a $NUMBER -le 20 ]
	do
		echo "Enter number between 1 and 20"
		read NUMBER
		if [ $NUMBER -lt 1 -o $NUMBER -gt 20 ]
		then
			echo "Number must be between 1 and 20"
		fi
	done
}

function numberOfQuestions(){
    AGE_GROUP=$1
    echo $AGE_GROUP
    NUMQUESTIONS=0
    if [ $AGE_GROUP -ge 5 -a $AGE_GROUP -le 6 ]
    then
        NUMQUESTIONS=5
        echo "you are in age group 5-6"
    elif [ $AGE_GROUP -ge 7 -a $AGE_GROUP -le 8 ]
    then
        NUMQUESTIONS=10
        echo "you are in age group 7-8"
    elif [ $AGE_GROUP -ge 9 -a $AGE_GROUP -le 10 ]
    then
        NUMQUESTIONS=15
        echo "you are in age group 9-10"
    elif [ $AGE_GROUP -ge 11 -a $AGE_GROUP -le 12 ]
    then
        NUMQUESTIONS=20
        echo "you are in age group 11-12"
    fi
    echo $NUMQUESTIONS
}


function chooseArithOp(){
    ARITH_OP=0

	until [ $ARITH_OP -gt 0 -a $ARITH_OP -le 4 ] #until we pick a valid arithmetic operator!
	do
		echo "Pick an operator:"
		echo "1) Addition"
		echo "2) Subtraction"
		echo "3) Division"
		echo "4) Multiplication"
		read ARITH_OP

		if [ $ARITH_OP -lt 1 -o $ARITH_OP -gt 4 ]
		then
			echo "$ARITH_OP is an invalid option, Try Again!"
            chooseArithOp
		fi
	done
}



function learnTables(){
    NUMOFQUESTIONS=$1
    # echo "AGE_GROUP: $AGE_GROUP"
    echo "NUMOFQUESTIONS: $NUMOFQUESTIONS"
    chooseArithOp
    chooseNum

    for ((i=0;i<$NUMOFQUESTIONS;i++))
    do
        case $ARITH_OP in
			1)	#Addition
				echo "Question $((i+1)):"
				OPERAND2=$((RANDOM%12+1))
				OPERAND1=$((RANDOM%12+1))
				ANS=$((NUMBER+OPERAND2))
				echo "$NUMBER + $OPERAND2 = ?"
				;;
			2)	#Subtraction
				echo "Question $((i+1)):"
				OPERAND2=$((RANDOM%12+1))
				OPERAND1=$((OPERAND2+(RANDOM%12+1)))
				ANS=$((NUMBER-OPERAND2))
				echo "$NUMBER - $OPERAND2 = ?"
				;;
			3)	
				#Division
				echo "Question $((i+1)):"
				OPERAND2=$((RANDOM%12+1))
				OPERAND1=$((OPERAND2*(RANDOM%12+1)))
				ANS=$((NUMBER/OPERAND2))
				echo "$NUMBER / $OPERAND2 = ?"
				;;
			4) 	
                # Multiplication
                echo "Question $((i+1)):"
				OPERAND2=$((RANDOM%12+1))
				OPERAND1=$((RANDOM%12+1))
				ANS=$((NUMBER*OPERAND2))
				echo "$NUMBER * $OPERAND2 = ?"
				;;
		    esac

		echo -n "----->: "
		read USER_ANSWER
		if [ $USER_ANSWER -eq $ANS ]
		then
            echo "Correct!"
        else
            echo "Wrong!"
		fi
    done
}


function teacherMenu(){
    MENU_CHOICE=0
    echo -e "please choose from the following options: \n 1. Create, Update or Remove students \n 2. View quiz results"

    read MENU_CHOICE
    if [ $MENU_CHOICE == 1 ]; then 
        studentOperations
    elif [ $MENU_CHOICE == 2 ]; then
        echo "view quiz results"
        read -p "Please enter the username of the student you want to view results for: " USERNAME
        viewQuizResults $USERNAME
    elif  [ $MENU_CHOICE -lt 1 -o $MENU_CHOICE -gt 2]; then
        echo "$MENU_CHOICE is invalid! please try again"
        teacherMenu
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


function viewQuizResults(){
    echo "view quiz results"
    i=0
    while read line 
    # reading input line by line and storing each line in the matches array. The i variable is used to keep track of the current index in the array
    do
        matches[i]="$line"
        (( i++ ))
    done < <( find ./results -name "$1*.txt" | cut -d '/' -f 3 ) # finding all .txt files in the ./results directory that start with the first argument passed to the function, extracting the filenames from the full paths, and storing these filenames in the matches array
    
        r=1
    # printing each element in the matches array, preceded by a counter
    for n in "${matches[@]}"
    do
        echo "$r:  $n"
        (( r++ ))
    done
    # validating user input
    until [[ $fileChoice =~ ^[[:digit:]]+$ ]]
    do
    echo "Please choose a file to view"
    read fileChoice
    if [[ $fileChoice =~ ^[[:digit:]]+$ ]]
    then
        cat "./results/${matches[((fileChoice--))]}"
    else
        echo "$fileChoice contains illegal characters"
    fi
    done
}


main