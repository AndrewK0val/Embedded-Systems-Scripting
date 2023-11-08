# Lists in python are similar to one dimensional arrays with one difference
# A list can contain different data types. A list contains items separated by 
# commas and enclosed within square brackets ([ ]). Lists are ordered and
# changeable. Duplicate values are allowed.

# The items in a list can be accessed using ([ ] and [:]) with indexes 
# starting at [0] in the beginning of the list and working their way from 
# -1 at the end.

def main():
    engList = ["Cert", "BSc", "BEng", "MEng"]
    print(engList)  # print the complete list
    
    print(engList[1])  # print second item in list
    
    print(engList[1:3])  # print items 1 to 3 in the list
    
    engNumbers = [] # create an empty list
    engNumbers.append(10)  # the append methods add to list
    engNumbers.append(5)
    engNumbers.append(22)
    engNumbers.append(3)
    
    for i in engNumbers:
        print(i)  # print elements of the list on each line
        
    # print(engNumbers[4])  # this will cause an error, [4] does not exist
    
    print(len(engNumbers))  # len method will print the number of elements
    
main()