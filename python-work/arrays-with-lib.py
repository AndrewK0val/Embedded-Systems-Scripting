# python arrays - need to use the array library
# Elements of the array are all the same data type
# use square bracket notation [0] .. [SIZE-1]
# the methods used for lists can also be used for arrays 
# See https://docs.python.org/3/library/array.html for data types

import array 
# we are using key value pairs

groupAges = array.array('i', [21, 19, 17, 18, 22, 21, 22, 45, 17, 18]) 

# accessing elements of array 
for i in groupAges: 
	print(i) 
    
max=groupAges[0]
for i in range(1, len(groupAges)): 
    if groupAges[i] > max: 
        max = groupAges[i]
        
print("Maximum age is", max)

groupAges.append(25)
groupAges.append(21)

print(groupAges)
print(len(groupAges))


