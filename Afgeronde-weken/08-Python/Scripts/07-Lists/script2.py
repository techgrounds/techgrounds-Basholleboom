my_list = [9, 80, 16, 67, 35]

# Iterate through the list
for i in range(len(my_list)):
    # Calculate the sum of the current item and the next one (or the first one if it's the last item)
    result = my_list[i] + my_list[(i + 1) % len(my_list)]

    # Print the result
    print(result)