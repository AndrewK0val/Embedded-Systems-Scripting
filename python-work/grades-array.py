
# python arrays - need to use the array library
# Elements of the array are all the same data type
# use square bracket notation [0] .. [SIZE-1]
# the methods used for lists can also be used for arrays

import array 

def validateGrade(g):
    if float(g) in range (0, 100):
        return True
    else:
        return False

def enterGrades(gradesArr):
    for i in range(0,6):
        grade = float(input("Please enter grade " + str(i+1) + " between 0 and 100: "))
        while not validateGrade(grade):  ## function call
            grade = float(input("Please enter grade " + str(i+1) + " between 0 and 100: "))
        gradesArr.append(grade)
        
def findMaxGrade(gradesArr):
    max = gradesArr[0]
    for i in range(1,6):
        if gradesArr[i] > max:
            max = gradesArr[i]
    return max
    


def main():
    myGrades = array.array('f', []) # create an empty array of float data type
    enterGrades(myGrades) # function call
    
    print(myGrades)
    
    print("Maximum grade is ", findMaxGrade(myGrades))
    
main() # function call5