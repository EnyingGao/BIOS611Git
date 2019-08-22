import sys

arg = list(map(int, sys.argv[1:4]))
number = [1,6,9,8,14]
output = number + arg
print(output)
print(len(output))
sorted_output = sorted(output)
print(sorted_output)
