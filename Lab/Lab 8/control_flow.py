
for x in range(5):
    if x % 2 == 0:
        print("x is even")
    else:
        print("x is odd")

for x in range(5):
    if x % 2 == 0:
        continue
    else:
        print("x is odd")

for x in range(5):
    if x % 2 == 0:
        print("x is even")
    else:
        break

x = 0
while x != 5:
    x += 1
    print x

x = 0
while True:
    if x == 4:
        break
    x += 1
    print x
