def square_list_in_place(int_list):
    for index, element in enumerate(int_list):
        int_list[index] *= element
    
    return element


def square_list_out_of_place(int_list):
    squared_list = [None] * len(int_list)

    for index, element in enumerate(int_list):
       squared_list[index] = element ** 2

    return squared_list

    
original_list = [1,2,3,4,5,6,7]

print("original list:",original_list)
print("out of place: ", square_list_out_of_place(original_list))
print("in place: ", square_list_in_place(original_list))
