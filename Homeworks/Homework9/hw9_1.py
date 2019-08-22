import sys

arg = map(int, sys.argv[1:])

for number in arg:
    if number % 2 == 0:
        print(number)
