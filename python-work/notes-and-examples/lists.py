def square_list_in_place(int_list):
    for index, element in enumerate(int_list):
        int_list[index] *= element


def square_list_out_of_place(int_list):
    squared_list = [None] * len(int_list)

    for index, element in enumerate(int_list):
       squared_list[index] = element ** 2

    return squared_list


original_list = [1,2,3,4,5,6,7]
square_list_out_of_place(original_list)

print("original list:",original_list)
