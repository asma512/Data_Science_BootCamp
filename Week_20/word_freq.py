filename = str(input("Enter name of input file:"))

# Open the file in read mode
inputFile = open(filename, "r")


frequency_list={}
for line in inputFile:
    line = line.strip().lower()

    words = line.split(" ")
    for word in words:
        if word in frequency_list:
            frequency_list[word] += 1
        else:
            frequency_list[word] = 1

#print(frequency_list)
sort_orders = sorted(frequency_list.items(), key=lambda x: (x[1],x[0]), reverse=True)
print(sort_orders.dict())

    





