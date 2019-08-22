import sys

def sum_of_square(x,y):
	summation = 0
	x = int(x)
	y = int(y)
	for i in range(x,y+1):
		summation += i**2
	print(summation)

x = sys.argv[1]
y = sys.argv[2]

sum_of_square(x,y)
